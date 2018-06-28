load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

wrffile=addfile("wrfout_d03_2013-05-08_07:30:00","r")

slp=wrf_user_getvar(wrffile,"slp",0)
t2=wrf_user_getvar(wrffile,"T2",0)-273
u10=wrf_user_getvar(wrffile,"U10",0)
v10=wrf_user_getvar(wrffile,"V10",0)
lat = wrf_user_getvar(wrffile,"XLAT",0)
lon = wrf_user_getvar(wrffile,"XLONG",0)

slp@lat2d = lat
slp@lon2d = lon
t2@lat2d = lat
t2@lon2d = lon

dom_dims = dimsizes(slp)
dom_rank = dimsizes(dom_dims)
nx1 = dom_dims(dom_rank - 1) - 1
ny1 = dom_dims(dom_rank - 2) - 1

res=True
res@cnFillOn        = False
res@cnLinesOn       = True
res@cnLineLabelsOn  = True
res@cnLineColor     = "black"
res@cnLineThicknessF=3.0 
res@gsnMaximize     = True    ; Maximize plot in frame
res@gsnDraw         = False
res@gsnFrame        = False
res@cnLineLabelFontQuality="High"
res@cnInfoLabelOn   = False
res@gsnLeftString=""
res@gsnRightString=""
res@cnLineLabelFontHeightF=0.017
res@cnLineLabelPerimOn =True
res@cnLineLabelInterval=1 
res2=res
res@mpFillOn=False
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
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(975,1020,19)
res@gsnCenterString=""

res2@cnLevelSelectionMode = "ExplicitLevels"
res2@cnLevels=fspan(-4,40,12)

vcres=True
vcres@tfDoNDCOverlay=True
vcres@vcFillArrowsOn=False
vcres@vcGlyphStyle="WindBarb"
vcres@gsnDraw         = False
vcres@gsnFrame        = False
vcres@vcMinDistanceF=0.020
vcres@vcRefLengthF=0.03
vcres@gsnLeftString=""
vcres@gsnRightString=""

wks = gsn_open_wks("eps", "wrfout_d03_2013-05-08_07:30:00")
plot=gsn_csm_contour_map(wks,slp(:,:),res)
res2@cnLineColor="red"
plot1=gsn_csm_contour(wks,t2(:,:),res2)
overlay(plot,plot1)
plot2=gsn_csm_vector(wks,u10,v10,vcres)
overlay(plot,plot2)
draw(plot)
frame(wks)
