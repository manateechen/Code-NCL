load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

globalfile=addfile("ERA_pre_sum_2008.nc","r")
lat=globalfile->latitude
lon=globalfile->longitude

wrffile=addfile("wrfout_d02_2006-06-01_00:00:00","r")
XLAT=wrffile->XLAT(0,:,:)
XLON=wrffile->XLONG(0,:,:)

pre=globalfile->pre

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
temp_regrid = ESMF_regrid_with_weights(pre,wgtFileName,OPT)
printVarSummary(temp_regrid)
printVarSummary(pre)

template=addfile("precipitation.nc","r")
pre_d02=template->pre_d02
lat_d02=template->lat_d02
lon_d02=template->lon_d02

copy_VarMeta(pre_d02(0,0,:,:),temp_regrid)

out=addfile("ERA-pre-WRFgrid_2008.nc","c")
out->pre=temp_regrid
out->lat_d02=lat_d02(0,:,:)
out->lon_d02=lon_d02(0,:,:)

temp_regrid@lat2d=XLAT
temp_regrid@lon2d=XLON

dom_dims = dimsizes(temp_regrid)
  dom_rank = dimsizes(dom_dims)
  nx2 = dom_dims(dom_rank - 1) - 1
  ny2 = dom_dims(dom_rank - 2) - 1


res                 = True


  res@cnFillOn        = True
  res@cnLinesOn       = False
  res@cnLineLabelsOn  = False
  res@cnInfoLabelOn   = False
  res@gsnSpreadColors = True
  res@gsnLeftString = ""
  res@gsnRightString = ""

  res@gsnDraw         = False
  res@gsnFrame        = False

res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
  res@mpOutlineOn              = True
  res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last
  res@mpGridAndLimbOn       = True                ; Turn off lat/lon lines
  res@mpGridLineDashPattern       = 2
  res@pmTickMarkDisplayMode = "Always"             ; Turn on map tickmarks
  res = set_mp_wrf_map_resources(wrffile,res)
  res@mpLimitMode        = "Corners"               ; Portion of map to zoom
  res@mpLeftCornerLatF   = XLAT(0,0)
  res@mpLeftCornerLonF   = XLON(0,0)
  res@mpRightCornerLatF  = XLAT(ny2,nx2)
  res@mpRightCornerLonF  = XLON(ny2,nx2)


wks = gsn_open_wks("eps", "wrf_overlay_doms")  ; Open graphics file
gsn_define_colormap(wks,"OceanLakeLandSnow")
map = gsn_csm_contour_map(wks, temp_regrid(:,:), res)
draw(map) 
frame(wks)
