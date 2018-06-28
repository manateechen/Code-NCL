load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

globalfile=addfile("HAR_pre_sum_2008.nc","r")
lat=globalfile->lat
lon=globalfile->lon

wrffile=addfile("wrfout_d02_2006-06-01_00:00:00","r")
XLAT=wrffile->XLAT(0,:,:)
XLON=wrffile->XLONG(0,:,:)

pre=globalfile->pre

srcGridName = "src_SCRIP.nc"
dstGridName = "dst_SCRIP.nc"
wgtFileName = "wgt.nc"

opt                = True
opt@LargeFile      = True

curvilinear_to_SCRIP(srcGridName,lat,lon,opt)
curvilinear_to_SCRIP(dstGridName,XLAT,XLON,opt)

Opt                = True
Opt@InterpMethod   = "bilinear" 

ESMF_regrid_gen_weights(srcGridName,dstGridName,wgtFileName,Opt)

OPT                = True
temp_regrid = ESMF_regrid_with_weights(pre,wgtFileName,OPT)
printVarSummary(temp_regrid)
printVarSummary(pre)

template=addfile("precipitation.nc","r")
pre_d02=template->pre_d02
lat_d02=template->lat_d02
lon_d02=template->lon_d02

copy_VarMeta(pre_d02(0,0,:,:),temp_regrid)

out=addfile("HAR-pre-WRFgrid_2008.nc","c")
out->pre=temp_regrid
out->lat_d02=lat_d02(0,:,:)
out->lon_d02=lon_d02(0,:,:)

