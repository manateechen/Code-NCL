load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

wrffile=addfile("wrfout_d03_2013-05-10_07:40:00","r")

cape = wrf_user_getvar(wrffile,"cape_2d",-1)

lat1 = wrf_user_getvar(wrffile,"XLAT",0)
lon1 = wrf_user_getvar(wrffile,"XLONG",0)

cape@lat2d = lat1
cape@lon2d = lon1

dom_dims = dimsizes(cape)
dom_rank = dimsizes(dom_dims)
nx1 = dom_dims(dom_rank - 1) - 1
ny1 = dom_dims(dom_rank - 2) - 1

res                 = True
res@cnFillOn        = True
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@gsnSpreadColors = True
res@vpWidthF=0.60
res@vpHeightF=0.35 
res@cnLevelSelectionMode = "ExplicitLevels"

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
res@mpLeftCornerLatF   = lat1(0,0)
res@mpLeftCornerLonF   = lon1(0,0)
res@mpRightCornerLatF  = lat1(ny1,nx1)
res@mpRightCornerLonF  = lon1(ny1,nx1)
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame
res@gsnLeftString =""
res@gsnCenterString=""

wks = gsn_open_wks("x11", "capewrfout_d03_2013-05-10_07:40:00")
gsn_define_colormap(wks,"WhiteYellowOrangeRed")
res@cnLevels=ispan(500,5000,500)
plot = gsn_csm_contour_map(wks,cape(0,0,:,:) , res)
draw(plot) 
frame(wks)
delete(wks)
delete(res@cnLevels)

wks = gsn_open_wks("x11", "cinwrfout_d03_2013-05-10_07:40:00")
gsn_define_colormap(wks,"WhiteBlue")
res@cnLevels=ispan(10,150,10)
plot = gsn_csm_contour_map(wks,cape(1,0,:,:) , res)
draw(plot) 
frame(wks)
delete(wks)
delete(res@cnLevels)

wks = gsn_open_wks("x11", "lclwrfout_d03_2013-05-10_07:40:00")
gsn_define_colormap(wks,"WhiteGreen")
res@cnLevels=ispan(200,2000,200)
plot = gsn_csm_contour_map(wks,cape(2,0,:,:) , res)
draw(plot) 
frame(wks)
delete(wks)
delete(res@cnLevels)

wks = gsn_open_wks("x11", "lfcwrfout_d03_2013-05-10_07:40:00")
gsn_define_colormap(wks,"MPL_Greys")
res@cnLevels=ispan(300,3000,300)
plot = gsn_csm_contour_map(wks,cape(3,0,:,:) , res)
draw(plot) 
frame(wks)
delete(wks)
delete(res@cnLevels)










