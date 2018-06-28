load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

globalfile=addfile("/home2_hn/qf/wrf-cosp/cloud_obs/cfadLidarsr532_obs4cmip5_CALIOP_L3_CALIPSO-GOCCP-v2.1_20071215_20071215.nc","r")
lat=globalfile->lat
lon=globalfile->lon

wrffile=addfile("wrfout_d02_2007-01-01_00:00:00","r")
XLAT=wrffile->XLAT(0,:,:)
XLON=wrffile->XLONG(0,:,:)

var=globalfile->cfadLidarsr532(0,:,:,:,:)

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

alt40=globalfile->alt40
srbox=globalfile->srbox
alt40_bnds=globalfile->alt40_bnds
srbox_bnds=globalfile->srbox_bnds/1000.0

nsrbox=dimsizes(srbox)+1
XVALUE=new(nsrbox,"float")
XVALUE(nsrbox-1)=100
XVALUE(0:nsrbox-2)=doubletofloat(srbox_bnds(:,0))

nalt40=dimsizes(alt40)+1
YVALUE=new(nalt40,"float")
YVALUE(0)=19200
YVALUE(1:nalt40-1)=doubletofloat(alt40_bnds(::-1,0))
YVALUE=YVALUE/1000.0

res                      = True
res@cnFillOn             = True
res@cnLinesOn            = False
res@cnLineLabelsOn       = False
res@gsnSpreadColors      = True
res@gsnRightString       = ""
res@tiMainString         = var@long_name
res@cnFillMode           = "RasterFill"
res@tmXBMinorOn          = False
res@trYReverse           = True
res@cnLevelSpacingF      = 1.0
res@tmXBMode             = "Explicit"
res@tmXBValues           = ispan(1,nsrbox,1)
res@tmXBLabels           = XVALUE
res@sfXArray             = res@tmXBValues
res@tmYLMode             = "Explicit"
res@tmYLValues           = ispan(1,nalt40,1)
res@tmYLLabels           = YVALUE
res@tmYLLabelFontHeightF = 0.01
res@sfYArray             = res@tmYLValues
res@lbOrientation        = "vertical"
res@tiXAxisString        = "cloud optical depth"
res@tiYAxisString        = alt40@long_name+ " [km]"
res@cnLevelSelectionMode        = "ExplicitLevels"
res@cnLevels    = fspan(1,6,6)

cfadLidarsr532=dim_avg_n_Wrap(dim_avg_n_Wrap(temp_regrid,3),2)
printVarSummary(cfadLidarsr532)

res@gsnLeftString        = "12"
wks = gsn_open_wks("eps", "cfadLidarsr532_obs_12")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour(wks, cfadLidarsr532(alt40|:,srbox|:)/10.0, res)
delete(wks)
