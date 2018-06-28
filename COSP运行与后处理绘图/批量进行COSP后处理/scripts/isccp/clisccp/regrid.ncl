load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

globalfile=addfile("/home2_hn/qf/wrf-cosp/cloud_obs/clisccp_198307-200806.nc","r")
lat=globalfile->latitude
lon=globalfile->longitude

wrffile=addfile("wrfout_d02_2007-01-01_00:00:00","r")
XLAT=wrffile->XLAT(0,:,:)
XLON=wrffile->XLONG(0,:,:)

var=globalfile->clisccp(282:293,:,:,:,:)

srcGridName = "src_SCRIP.nc"
dstGridName = "dst_SCRIP.nc"
wgtFileName = "wgt.nc"

opt                = True
opt@LargeFile      = True

rectilinear_to_SCRIP(srcGridName,lat,lon,opt)
curvilinear_to_SCRIP(dstGridName,XLAT,XLON,opt)

Opt                = True
Opt@InterpMethod   = "bilinear" 

ESMF_regrid_gen_weights(srcGridName,dstGridName,wgtFileName,Opt)

OPT                = True
temp_regrid = ESMF_regrid_with_weights(var,wgtFileName,OPT)

printVarSummary(temp_regrid)

plev=globalfile->plev7
tau=globalfile->tau
plev_bnds=globalfile->plev7_bnds
tau_bnds=globalfile->tau_bnds
ntau=dimsizes(tau)
XVALUE=new(ntau+1,"float")
XVALUE(0:ntau-1)=tau_bnds(:,0)
XVALUE(ntau)=100.0
nplev=dimsizes(plev)
YVALUE=new(nplev+1,"float")
YVALUE(0:nplev-1)=plev_bnds(:,0)/100.0
YVALUE(nplev)=1100.0

res                      = True
res@cnFillOn             = True
res@cnLinesOn            = False
res@cnLineLabelsOn       = False
res@gsnSpreadColors      = True
res@gsnRightString       = ""
res@tiMainString         = "ISCCP Cloud Area Fraction"
res@cnFillMode           = "RasterFill"
res@tmXBMinorOn          = False
res@trYReverse           = True
res@cnLevelSpacingF      = 1.0
res@tmXBMode             = "Explicit"
res@tmXBValues           = XVALUE
res@tmXBLabels           = XVALUE
res@sfXArray             = res@tmXBValues
res@tmYLMode             = "Explicit"
res@tmYLValues           = YVALUE
res@tmYLLabels           = YVALUE
res@sfYArray             = res@tmYLValues
res@lbOrientation        = "vertical"
res@tiXAxisString        = "cloud optical depth"
res@tiYAxisString        = "pressure"+ " [hPa]"
res@cnLevelSelectionMode        = "ExplicitLevels"
res@cnLevels    = fspan(1,6,6)

clisccp=dim_avg_n_Wrap(dim_avg_n_Wrap(temp_regrid,4),3)
printVarSummary(clisccp)

month=(/"01","02","03","04","05","06","07","08","09","10","11","12"/)
do i=0,11
	res@gsnLeftString        = month(i)
	wks = gsn_open_wks("eps", "clisccp_obs_"+month(i))
	gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
	plot = gsn_csm_contour(wks, clisccp(time|i,plev7|:,tau|:), res)
	delete(wks)
end do

res@gsnLeftString        = "mean"
wks = gsn_open_wks("eps", "clisccp_obs_mean")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour(wks, dim_avg_n_Wrap(clisccp(time|:,plev7|:,tau|:),0), res)
delete(wks)
