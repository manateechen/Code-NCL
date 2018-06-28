load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

  wks = gsn_open_wks("eps", "pre")  ; Open graphics file
  gsn_define_colormap(wks,"cmp_b2r")

  ;d1 = addfile("wrfout_d01_1998-06-16_00:00:00", "r")
 ; d2 = addfile("wrfout_d02_1998-06-16_00:00:00", "r")

  wrff1=addfile("./case03/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case03/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp1=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp1(28,:,:)-tmp1(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)
  lat1 = wrf_user_getvar(wrff1,"XLAT",0)
  lon1 = wrf_user_getvar(wrff1,"XLONG",0)
  
  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  lat2 = wrf_user_getvar(wrff2,"XLAT",0)
  lon2 = wrf_user_getvar(wrff2,"XLONG",0)

  var1@lat2d = lat1
  var1@lon2d = lon1
  var2@lat2d = lat2
  var2@lon2d = lon2

  
  
  
  
  
  wrff3=addfile("./case05/wrfout_d01_1998-06-16_00:00:00","r")
  wrff4=addfile("./case05/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc3 = wrf_user_getvar(wrff3,"RAINNC",-1)
  irainnc3 = wrf_user_getvar(wrff3,"I_RAINNC",-1)
  rainc3 = wrf_user_getvar(wrff3,"RAINC",-1)
  irainc3 = wrf_user_getvar(wrff3,"I_RAINC",-1)
  tmp3=(irainnc3+irainc3)*100.0+rainnc3+rainc3
  var3=tmp3(28,:,:)-tmp3(0,:,:)
  copy_VarMeta(rainnc3(0,:,:),var3)
  lat3 = wrf_user_getvar(wrff3,"XLAT",0)
  lon3 = wrf_user_getvar(wrff3,"XLONG",0)
  
  rainnc4 = wrf_user_getvar(wrff4,"RAINNC",-1)
  irainnc4 = wrf_user_getvar(wrff4,"I_RAINNC",-1)
  rainc4 = wrf_user_getvar(wrff4,"RAINC",-1)
  irainc4 = wrf_user_getvar(wrff4,"I_RAINC",-1)
  tmp4=(irainnc4+irainc4)*100.0+rainnc4+rainc4
  var4=tmp4(28,:,:)-tmp4(0,:,:)
  copy_VarMeta(rainnc4(0,:,:),var4)

  lat4 = wrf_user_getvar(wrff4,"XLAT",0)
  lon4 = wrf_user_getvar(wrff4,"XLONG",0)

  var3@lat2d = lat3
  var3@lon2d = lon3
  var4@lat2d = lat4
  var4@lon2d = lon4
  
  var5=var3-var1
  var6=var4-var2
  var5@lat2d = lat3
  var5@lon2d = lon3
  var6@lat2d = lat4
  var6@lon2d = lon4
  
  
  
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
res@cnLevels=(/-100,-90,-80,-70,-60,-50,-40,-30,-20,-10,0,10,20,30,40,50,60,70,80,90,100/)
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
res = set_mp_wrf_map_resources(wrff1,res)
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


map = gsn_csm_contour_map(wks, var5, res)
plot = gsn_csm_contour(wks, var6, res2)
attach_china_map(wks, map)


draw(map) 
gsn_polyline(wks,map,lon2(0,:),lat2(0,:),True)
gsn_polyline(wks,map,lon2(:,0),lat2(:,0),True)
gsn_polyline(wks,map,lon2(ny2,:),lat2(ny2,:),True)
gsn_polyline(wks,map,lon2(:,nx2),lat2(:,nx2),True)

frame(wks)


