load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "$GEODIAG_ROOT/geodiag.ncl"

  wks = gsn_open_wks("pdf", "500hPa")  ; Open graphics file
  gsn_define_colormap(wks,"cmp_b2r")

  d1 = addfile("wrfpress_d01_2007-06-01_00:00:00", "r")

  wrff1=addfile("wrfout_d01_2007-06-01_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
;  var1=dim_avg_n_Wrap(tmp1(60:70,:,:,:),0)
  var1=tmp1(:,:,:,:)
  lat1 = wrf_user_getvar(wrff1,"XLAT",0)
  lon1 = wrf_user_getvar(wrff1,"XLONG",0)
  
  var1@lat2d = lat1
  var1@lon2d = lon1

  dom_dims = dimsizes(var1)
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
res@cnLevels=(/552,556,560,564,568,572,576,580,584,588,592/)
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnDraw         = False
res@gsnFrame        = False

;res@isShowProvince = True
;res@isShowSouthChinaSea = False
;res@isAddMask = False
;res@isShowRivers = True
;res@riverColor = "black"
;res@riverThickness = 0.5
;res@boundaryColor = "black"
;res@boundaryThickness = 0.5
;setup_china_map(res)

res@mpProjection = "LambertConformal"
res@mpLambertParallel1F = 20
res@mpLambertParallel2F = 50
res@mpLambertMeridianF =  115
res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res@mpOutlineOn              = True
res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last
res@mpGridAndLimbOn       = True                ; Turn off lat/lon lines
res@mpGridLineDashPattern       = 2
res@pmTickMarkDisplayMode = "Always"             ; Turn on map tickmarks
res = set_mp_wrf_map_resources(d1,res)
res@mpLimitMode        = "Corners"               ; Portion of map to zoom
res@mpLeftCornerLatF   = lat1(0,0)
res@mpLeftCornerLonF   = lon1(0,0)
res@mpRightCornerLatF  = lat1(ny1,nx1)
res@mpRightCornerLonF  = lon1(ny1,nx1)
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame

do i=0,368
map = gsn_csm_contour_map(wks, var1(i,12,:,:), res)
;attach_china_map(wks, map)

draw(map) 

frame(wks)
end do


