load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

  wks = gsn_open_wks("eps", "wrf_overlay_doms")  ; Open graphics file
  gsn_define_colormap(wks,"cmp_b2r")

  d1 = addfile("wrfpress_d01_1998-06-16_00:00:00", "r")
  d2 = addfile("wrfpress_d02_1998-06-16_00:00:00", "r")

  wrff1=addfile("wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("wrfout_d02_1998-06-16_00:00:00","r")

  Q1 = wrf_user_getvar(d1,"Q_PL",-1)
U1 = wrf_user_getvar(d1,"U_PL",-1)
V1 = wrf_user_getvar(d1,"V_PL",-1)
  
  lat1 = wrf_user_getvar(wrff1,"XLAT",0)
  lon1 = wrf_user_getvar(wrff1,"XLONG",0)
  
  Q2 = wrf_user_getvar(d2,"Q_PL",-1)
U2 = wrf_user_getvar(d2,"U_PL",-1)
V2 = wrf_user_getvar(d2,"V_PL",-1)


  lat2 = wrf_user_getvar(wrff2,"XLAT",0)
  lon2 = wrf_user_getvar(wrff2,"XLONG",0)

  Q1@lat2d = lat1
  Q1@lon2d = lon1
  Q2@lat2d = lat2
    Q2@lon2d = lon2
    
    U1@lat2d = lat1
  U1@lon2d = lon1
  U2@lat2d = lat2
    U2@lon2d = lon2
    
    V1@lat2d = lat1
  V1@lon2d = lon1
  V2@lat2d = lat2
    V2@lon2d = lon2
    
    spq1=Q1/(Q1+1)
    spq2=Q2/(Q2+1)
    uq1=spq1*U1
    vq1=spq1*V1
     uq2=spq2*U2
    vq2=spq2*V2
    copy_VarMeta(Q1,uq1)
    copy_VarMeta(Q2,uq2)
    copy_VarMeta(Q1,vq1)
    copy_VarMeta(Q2,vq2)    

  dom_dims = dimsizes(Q1)
  dom_rank = dimsizes(dom_dims)
  nx1 = dom_dims(dom_rank - 1) - 1
  ny1 = dom_dims(dom_rank - 2) - 1
  dom_dims = dimsizes(Q2)
  dom_rank = dimsizes(dom_dims)
  nx2 = dom_dims(dom_rank - 1) - 1
  ny2 = dom_dims(dom_rank - 2) - 1

  
res=True
res@tfDoNDCOverlay=True
res@vcFillArrowsOn=False
;res@vcRefLengthF=0.050
res@vcGlyphStyle="CurlyVector"
res@vcMinDistanceF=0.010
res@vcLineArrowThicknessF=3
res@vcRefAnnoOrthogonalPosF=0.01
res@vcRefAnnoOn=False
res@gsnMaximize=True 
res@gsnRightString          = ""
res@gsnLeftString           = ""
res@gsnDraw                 = False
res@gsnFrame                = False   
  

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



map = gsn_csm_vector_map(wks,uq1(0,2,:,:) ,vq1(0,2,:,:) ,res)
plot = gsn_csm_vector(wks,uq2(0,2,:,:) ,vq2(0,2,:,:), res2)
attach_china_map(wks, map)

draw(map) 
gsn_polyline(wks,map,lon2(0,:),lat2(0,:),True)
gsn_polyline(wks,map,lon2(:,0),lat2(:,0),True)
gsn_polyline(wks,map,lon2(ny2,:),lat2(ny2,:),True)
gsn_polyline(wks,map,lon2(:,nx2),lat2(:,nx2),True)

frame(wks)


