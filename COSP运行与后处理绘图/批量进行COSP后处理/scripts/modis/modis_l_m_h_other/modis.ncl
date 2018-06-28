load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

cloudfile=addfile("./cosp/reffclimodis_12.nc", "r")
wrffile=addfile("wrfout_d02_2007-01-01_00:00:00", "r")

nx=300
ny=201

cldfra_oned=dim_avg_n_Wrap(cloudfile->reffclimodis,0)
lat = wrf_user_getvar(wrffile,"XLAT",0)
lon = wrf_user_getvar(wrffile,"XLONG",0)
cldfra=onedtond(cldfra_oned,(/ny,nx/))*1E6
cldfra!0="lat"
cldfra!1="lon"
cldfra@lat2d=lat
cldfra@lon2d=lon

dom_dims = dimsizes(cldfra)
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
res@cnLevels=ispan(5,65,3)
res@gsnLeftString = "reffclimodis_12_WRF"
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
res@mpLeftCornerLatF   = lat(0,0)
res@mpLeftCornerLonF   = lon(0,0)
res@mpRightCornerLatF  = lat(ny1,nx1)
res@mpRightCornerLonF  = lon(ny1,nx1)
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame


wks = gsn_open_wks("eps", "reffclimodis_model_12")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour_map(wks, cldfra, res)
attach_china_map(wks, plot)
draw(plot) 
frame(wks)


