load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"


tt=4 ;一天输出每4个时刻的数据

  d1 = addfile("wrfout_d03_2013-07-06_00:00:00", "r")
  d2 = addfile("wrfout_d04_2013-07-06_00:00:00", "r")


  var1 = wrf_user_getvar(d1,"T2",-1)
  lat1 = wrf_user_getvar(d1,"XLAT",0)
  lon1 = wrf_user_getvar(d1,"XLONG",0)
  var2 = wrf_user_getvar(d2,"T2",-1)
  lat2 = wrf_user_getvar(d2,"XLAT",0)
  lon2 = wrf_user_getvar(d2,"XLONG",0)

  var1@lat2d = lat1
  var1@lon2d = lon1
  var2@lat2d = lat2
  var2@lon2d = lon2

nt=dimsizes(var1(:,0,0))
ny1=dimsizes(var1(0,:,0))
nx1=dimsizes(var1(0,0,:))
ny2=dimsizes(var2(0,:,0))
nx2=dimsizes(var2(0,0,:))

mins1=new((/nt/tt,ny1,nx1/),float)
maxs1=new((/nt/tt,ny1,nx1/),float)
means1=new((/nt/tt,ny1,nx1/),float)

mins2=new((/nt/tt,ny2,nx2/),float)
maxs2=new((/nt/tt,ny2,nx2/),float)
means2=new((/nt/tt,ny2,nx2/),float)

do ii=0,nt/tt-1
  mins1(ii,:,:)=dim_min_n_Wrap(var1(ii*tt:(ii+1)*tt-1,:,:), 0)
  maxs1(ii,:,:)=dim_max_n_Wrap(var1(ii*tt:(ii+1)*tt-1,:,:), 0)
  means1(ii,:,:)=dim_avg_n_Wrap(var1(ii*tt:(ii+1)*tt-1,:,:), 0)
  mins2(ii,:,:)=dim_min_n_Wrap(var2(ii*tt:(ii+1)*tt-1,:,:), 0)
  maxs2(ii,:,:)=dim_max_n_Wrap(var2(ii*tt:(ii+1)*tt-1,:,:), 0)
  means2(ii,:,:)=dim_avg_n_Wrap(var2(ii*tt:(ii+1)*tt-1,:,:), 0)
end do

  dom_dims = dimsizes(var1)
  dom_rank = dimsizes(dom_dims)
  nx11 = dom_dims(dom_rank - 1) - 1
  ny11 = dom_dims(dom_rank - 2) - 1
  dom_dims = dimsizes(var2)
  dom_rank = dimsizes(dom_dims)
  nx22 = dom_dims(dom_rank - 1) - 1
  ny22 = dom_dims(dom_rank - 2) - 1


  res                 = True


  res@cnFillOn        = True
  res@cnLinesOn       = False
  res@cnLineLabelsOn  = False
  res@cnInfoLabelOn   = False
  res@gsnSpreadColors = True
 ; res@cnLevelSelectionMode = "ExplicitLevels"
 ; res@cnLevels=(/0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1250,1500,1750,2000,2250,2500,2750,3000,3250,3500,3750,4000,4250,4500,4750,5000,5250,5500,5750,6000/)
  res@gsnLeftString = ""
  res@gsnRightString = ""

  res@gsnDraw         = False
  res@gsnFrame        = False

  res2 = res


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
  res@mpRightCornerLatF  = lat1(ny11,nx11)
  res@mpRightCornerLonF  = lon1(ny11,nx11)


  res@lbLabelAutoStride = True
  res@gsnMaximize     = True    ; Maximize plot in frame
  res@tiMainString = "Urbcat "+"20130706-20130709"


  res2@lbLabelBarOn = False  ; Labelbar already created in 1st plot
  res2@gsnMaximize  = False  ; Use maximization from original plot


  xbox_out = new(5,float)
  ybox_out = new(5,float)
  lnres = True
  lnres@gsLineThicknessF  = 1.5


do ii=0,nt/tt-1
  wks = gsn_open_wks("eps", "ave"+ii)  ; Open graphics file
  gsn_define_colormap(wks,"OceanLakeLandSnow")
  map = gsn_csm_contour_map(wks, means1(ii,:,:), res)
  plot = gsn_csm_contour(wks, means2(ii,:,:), res2)
 overlay(map,plot)
draw(map)  ; domain 2 already overlaid here - so just draw again

  gsn_polyline(wks,map,lon2(0,:),lat2(0,:),True)
   gsn_polyline(wks,map,lon2(:,0),lat2(:,0),True)
   gsn_polyline(wks,map,lon2(ny22,:),lat2(ny22,:),True)
   gsn_polyline(wks,map,lon2(:,nx22),lat2(:,nx22),True)
  
frame(wks)
delete(wks)


  wks = gsn_open_wks("eps", "min"+ii)  ; Open graphics file
  gsn_define_colormap(wks,"OceanLakeLandSnow")
  map = gsn_csm_contour_map(wks, mins1(ii,:,:), res)
  plot = gsn_csm_contour(wks, mins2(ii,:,:), res2)
 overlay(map,plot)
draw(map)  ; domain 2 already overlaid here - so just draw again

  gsn_polyline(wks,map,lon2(0,:),lat2(0,:),True)
   gsn_polyline(wks,map,lon2(:,0),lat2(:,0),True)
   gsn_polyline(wks,map,lon2(ny22,:),lat2(ny22,:),True)
   gsn_polyline(wks,map,lon2(:,nx22),lat2(:,nx22),True)
  
frame(wks)
delete(wks)

  wks = gsn_open_wks("eps", "max"+ii)  ; Open graphics file
  gsn_define_colormap(wks,"OceanLakeLandSnow")
  map = gsn_csm_contour_map(wks, maxs1(ii,:,:), res)
  plot = gsn_csm_contour(wks, maxs2(ii,:,:), res2)
 overlay(map,plot)
draw(map)  ; domain 2 already overlaid here - so just draw again

  gsn_polyline(wks,map,lon2(0,:),lat2(0,:),True)
   gsn_polyline(wks,map,lon2(:,0),lat2(:,0),True)
   gsn_polyline(wks,map,lon2(ny22,:),lat2(ny22,:),True)
   gsn_polyline(wks,map,lon2(:,nx22),lat2(:,nx22),True)
  
frame(wks)
delete(wks)
end do

