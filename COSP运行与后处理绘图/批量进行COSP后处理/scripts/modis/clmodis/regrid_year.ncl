load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

filelists=systemfunc("ls /home2_hn/qf/wrf-cosp/cloud_obs/MCD08_M3_NC.2007.*.C051.V02.nc")
globalfile=addfiles(filelists,"r")
ListSetType (globalfile, "join")
lat=globalfile[0]->lat
lon=globalfile[0]->lon

wrffile=addfile("wrfout_d02_2007-01-01_00:00:00","r")
XLAT=wrffile->XLAT(0,:,:)
XLON=wrffile->XLONG(0,:,:)

tmp=globalfile[:]->Optical_Thickness_vs_Cloud_Top_Pressure
var=tmp(ncl_join|:,Cloud_Top_Pressure|:,Cloud_Optical_Thickness|:,lat|:,lon|:)*100.0
copy_VarMeta(tmp(ncl_join|:,Cloud_Optical_Thickness|:,Cloud_Top_Pressure|:,lat|:,lon|:),var)

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

plev=globalfile[0]->Cloud_Top_Pressure
tau=globalfile[0]->Cloud_Optical_Thickness
plev_bnds=globalfile[0]->Cloud_Top_Pressure_bnds
tau_bnds=globalfile[0]->Cloud_Optical_Thickness_bnds
ntau=dimsizes(tau)
XVALUE=new(ntau+1,"float")
XVALUE(0:ntau-1)=tau_bnds(0,:)
XVALUE(ntau)=100.0
nplev=dimsizes(plev)
YVALUE=new(nplev+1,"float")
YVALUE(0:nplev-1)=plev_bnds(0,:)/100.0
YVALUE(nplev)=1100.0

res                      = True
res@cnFillOn             = True
res@cnLinesOn            = False
res@cnLineLabelsOn       = False
res@gsnSpreadColors      = True
res@gsnRightString       = ""
res@tiMainString         = "Modis Cloud Area Fraction"
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

clmodis=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(temp_regrid,4),3),0)
printVarSummary(clmodis)

res@gsnLeftString        = "mean"
wks = gsn_open_wks("eps", "clmodis_obs_mean")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour(wks, clmodis, res)
delete(wks)
