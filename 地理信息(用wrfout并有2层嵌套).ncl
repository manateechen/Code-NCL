load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

  wks = gsn_open_wks("eps", "wrf_overlay_doms")  ; Open graphics file
  gsn_define_colormap(wks,"OceanLakeLandSnow")

  d1 = addfile("wrfout_d01_1998-06-16_00:00:00", "r")
  d2 = addfile("wrfout_d02_1998-06-16_00:00:00", "r")


  var1 = wrf_user_getvar(d1,"HGT",0)
  lat1 = wrf_user_getvar(d1,"XLAT",0)
  lon1 = wrf_user_getvar(d1,"XLONG",0)
  var2 = wrf_user_getvar(d2,"HGT",0)
  lat2 = wrf_user_getvar(d2,"XLAT",0)
  lon2 = wrf_user_getvar(d2,"XLONG",0)

  var1@lat2d = lat1
  var1@lon2d = lon1
  var2@lat2d = lat2
  var2@lon2d = lon2

  dom_dims = dimsizes(var1)
  dom_rank = dimsizes(dom_dims)
  nx1 = dom_dims(dom_rank - 1) - 1
  ny1 = dom_dims(dom_rank - 2) - 1
  dom_dims = dimsizes(var2)
  dom_rank = dimsizes(dom_dims)
  nx2 = dom_dims(dom_rank - 1) - 1
  ny2 = dom_dims(dom_rank - 2) - 1


  res                 = True


  res@cnFillOn        = True
  res@cnLinesOn       = False
  res@cnLineLabelsOn  = False
  res@cnInfoLabelOn   = False
  res@gsnSpreadColors = True
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@cnLevels=(/0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1250,1500,1750,2000,2250,2500,2750,3000,3250,3500,3750,4000,4250,4500,4750,5000,5250,5500,5750,6000/)
  res@gsnLeftString = ""
  res@gsnRightString = ""

  res@gsnDraw         = False
  res@gsnFrame        = False

  res2 = res

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)
  
  res@mpProjection = "LambertConformal"
  res@mpLambertParallel1F = 30
res@mpLambertParallel2F = 60
res@mpLambertMeridianF =  107
  
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


  res2@lbLabelBarOn = False  ; Labelbar already created in 1st plot
  res2@gsnMaximize  = False  ; Use maximization from original plot


  xbox_out = new(5,float)
  ybox_out = new(5,float)
  lnres = True
  lnres@gsLineThicknessF  = 1.5


  map = gsn_csm_contour_map(wks, var1, res)
  plot = gsn_csm_contour(wks, var2, res2)
  attach_china_map(wks, map)


    draw(map)  ; domain 2 already overlaid here - so just draw again
  ;xbox = (/lon2(0,0),lon2(0,nx2),lon2(ny2,nx2),lon2(ny2,0),lon2(0,0)/)
 ; ybox = (/lat2(0,0),lat2(0,nx2),lat2(ny2,nx2),lat2(ny2,0),lat2(0,0)/)
  ;datatondc(map, xbox, ybox, xbox_out, ybox_out)
  ;gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)
  gsn_polyline(wks,map,lon2(0,:),lat2(0,:),True)
   gsn_polyline(wks,map,lon2(:,0),lat2(:,0),True)
   gsn_polyline(wks,map,lon2(ny2,:),lat2(ny2,:),True)
   gsn_polyline(wks,map,lon2(:,nx2),lat2(:,nx2),True)
  

  xxx=fspan(106,123,100)
  xxx1=xxx
  xxx2=xxx
  xxx1=18
  xxx2=33
  yyy=fspan(18,33,100)
  yyy1=yyy
  yyy1=106
  yyy2=yyy
  yyy2=123
  gsn_polyline(wks,map,xxx,xxx1,True)
  gsn_polyline(wks,map,xxx,xxx2,True)
  gsn_polyline(wks,map,yyy1,yyy,True)
  gsn_polyline(wks,map,yyy2,yyy,True)
  
 
  frame(wks)