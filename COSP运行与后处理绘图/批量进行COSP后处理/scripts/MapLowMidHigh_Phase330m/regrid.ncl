load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

globalfile=addfile("/home2_hn/qf/wrf-cosp/cloud_obs/MapLowMidHigh_Phase330m_2007_avg_CFMIP1_sat_2.69.nc","r")
lat=globalfile->latitude
lon=globalfile->longitude

wrffile=addfile("wrfout_d02_2007-01-01_00:00:00","r")
XLAT=wrffile->XLAT(0,:,:)
XLON=wrffile->XLONG(0,:,:)

var=globalfile->cltcalipso_RPIC

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

out=addfile("cltcalipso_RPIC_WRF.nc","c")
out->cltcalipso_RPIC=temp_regrid
out->lat=XLAT
out->lon=XLON

temp_regrid=temp_regrid*100.0
temp_regrid@lat2d=XLAT
temp_regrid@lon2d=XLON

dom_dims = dimsizes(temp_regrid)
dom_rank = dimsizes(dom_dims)
nx1 = dom_dims(dom_rank - 1) - 1
ny1 = dom_dims(dom_rank - 2) - 1

res                 = True
res@cnFillOn        = True
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@gsnSpreadColors = True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(5,99,5)
res@gsnRightString = ""
res@gsnDraw         = False
res@gsnFrame        = False

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)

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
res@mpRightCornerLatF  = XLAT(ny1,nx1)
res@mpRightCornerLonF  = XLON(ny1,nx1)
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame

month=(/"01","02","03","04","05","06","07","08","09","10","11","12"/)
do i=0,11
res@gsnLeftString = "cltcalipso_RPIC_"+month(i)
wks = gsn_open_wks("eps", "cltcalipso_RPIC_obs_"+month(i))
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour_map(wks, temp_regrid(i,:,:), res)
attach_china_map(wks, plot)
draw(plot) 
frame(wks)
delete(wks)
end do
