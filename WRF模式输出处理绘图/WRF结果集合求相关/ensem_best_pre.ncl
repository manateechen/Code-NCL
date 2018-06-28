load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

  wks = gsn_open_wks("eps", "bestpre")  ; Open graphics file
  gsn_define_colormap(wks,"cmp_b2r")

  ensemblefile01=addfile("all_pre_01.nc","r")
    ensemblefile02=addfile("all_pre_02.nc","r")
  
  
  var1=ensemblefile01->c0101
  var1=0.0
  var1=ensemblefile01->c0301+ensemblefile01->c0801+ensemblefile01->c0601+ensemblefile01->c1001
  var1=var1/4.0
  
  var2=ensemblefile02->c0102
  var2=0.0
  var2=ensemblefile02->c0302+ensemblefile02->c0802+ensemblefile02->c0602+ensemblefile02->c1002
  var2=var2/3.0
  
  
  
  

  wrff1=addfile("./case01/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")

  lat1 = wrf_user_getvar(wrff1,"XLAT",0)
  lon1 = wrf_user_getvar(wrff1,"XLONG",0)
  
  lat2 = wrf_user_getvar(wrff2,"XLAT",0)
  lon2 = wrf_user_getvar(wrff2,"XLONG",0)

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
res@cnLevels=(/40,80,120,160,200,240,280,320,360,400,440/)
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


map = gsn_csm_contour_map(wks, var1, res)
plot = gsn_csm_contour(wks, var2, res2)
attach_china_map(wks, map)


draw(map) 
gsn_polyline(wks,map,lon2(0,:),lat2(0,:),True)
gsn_polyline(wks,map,lon2(:,0),lat2(:,0),True)
gsn_polyline(wks,map,lon2(ny2,:),lat2(ny2,:),True)
gsn_polyline(wks,map,lon2(:,nx2),lat2(:,nx2),True)

frame(wks)


