load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

wrff1=addfile("wrfout_d03_2013-05-11_23:50:00","r")
wrff2=addfile("wrfout_d03_2013-05-12_00:00:00","r")

rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
tmp1=rainnc1+rainc1

rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
tmp2=rainnc2+rainc2

rain=tmp2-tmp1

copy_VarMeta(rainnc1,rain)

lat1 = wrf_user_getvar(wrff1,"XLAT",0)
lon1 = wrf_user_getvar(wrff1,"XLONG",0)

rain@lat2d = lat1
rain@lon2d = lon1

dom_dims = dimsizes(rain)
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
;res@cnLevelSelectionMode = "ExplicitLevels"
;res@cnLevels=ispan(5,55,5)
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
res = set_mp_wrf_map_resources(wrff1,res)
res@mpLimitMode        = "Corners"               ; Portion of map to zoom
res@mpLeftCornerLatF   = lat1(0,0)
res@mpLeftCornerLonF   = lon1(0,0)
res@mpRightCornerLatF  = lat1(ny1,nx1)
res@mpRightCornerLonF  = lon1(ny1,nx1)
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame
res@gsnLeftString =""
res@gsnCenterString=""

wks = gsn_open_wks("eps", "wrfout_d03_2013-05-12_00:00:00")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour_map(wks,rain(0,:,:) , res)
draw(plot) 
frame(wks)

