load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

timeslice="2014-05-22_04:00:00"
timeslicess="2014-05-22_03:00:00"
scheme="Morrison"
wrffile=addfile("./wrfout/wrfout_d03_"+timeslice,"r")
wrffiless=addfile("./wrfout/wrfout_d03_"+timeslicess,"r")
wrff1=addfile("./wrfout/wrfout_d03_2014-05-22_04:00:00","r")
wrff2=addfile("./wrfout/wrfout_d03_2014-05-22_09:00:00","r")
;aa=180
;bb=320
;cc=160
;dd=280
aa=0
bb=434
cc=0
dd=353
npoints=4
thick=10.0

opts=True
opts@extrapolate=True
opts@field_type="ght"
dbz_tmp = wrf_user_getvar(wrffile,"dbz",-1)
DBZ=wrf_user_vert_interp(wrffile,dbz_tmp,"ght_agl",0.5,opts)
dbz=DBZ(0,0,cc:dd,aa:bb)
TT=wrf_user_getvar(wrffile,"tk",-1)
TTss=wrf_user_getvar(wrffiless,"tk",-1)
tt=TT(0,0,cc:dd,aa:bb)-TTss(0,0,cc:dd,aa:bb)
copy_VarMeta(TT,tt)
wrf_smooth_2d(tt,npoints)



rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
tmp1=rainnc1+rainc1

rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
tmp2=rainnc2+rainc2

rain=tmp2(0,cc:dd,aa:bb)-tmp1(0,cc:dd,aa:bb)

copy_VarMeta(rainnc1,rain)

wrf_smooth_2d(rain,npoints)


lat1 = wrf_user_getvar(wrffile,"XLAT",0)
lon1 = wrf_user_getvar(wrffile,"XLONG",0)

lattt=lat1(cc:dd,aa:bb)
lonnn=lon1(cc:dd,aa:bb)

dbz@lat2d = lattt
dbz@lon2d = lonnn
tt@lat2d = lattt
tt@lon2d = lonnn
rain@lat2d = lattt
rain@lon2d = lonnn

dom_dims = dimsizes(dbz)
dom_rank = dimsizes(dom_dims)
nx1 = dom_dims(dom_rank - 1) - 1
ny1 = dom_dims(dom_rank - 2) - 1

res                 = True
resTT =res
respre=res

res@cnFillOn        = True
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@gsnSpreadColors = True
res@vpWidthF=0.60
res@vpHeightF=0.35 
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(5,55,5)
res@gsnLeftString = ""
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

res@mpGridAndLimbOn       = True                ; Turn off lat/lon lines
res@mpGridLineDashPattern       = 2
res@pmTickMarkDisplayMode = "Always"             ; Turn on map tickmarks
;res = set_mp_wrf_map_resources(wrffile,res)
res@mpLimitMode        = "Corners"               ; Portion of map to zoom
;res@mpLeftCornerLatF   = lattt(0,0)
;res@mpLeftCornerLonF   = lonnn(0,0)
;res@mpRightCornerLatF  = lattt(ny1,nx1)
;res@mpRightCornerLonF  = lonnn(ny1,nx1)
res@mpLeftCornerLatF=21.204
res@mpRightCornerLatF=24.804
res@mpLeftCornerLonF=111.555
res@mpRightCornerLonF=115.155
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame
res@gsnLeftString =""
res@gsnCenterString=scheme

resTT@cnFillOn        = False
resTT@cnLinesOn       = True
resTT@cnLineLabelsOn  = True
resTT@gsnDraw         = False
resTT@gsnFrame        = False
resTT@gsnCenterString=""
resTT@gsnLeftString =""
resTT@gsnRightString =""
resTT@cnLevelSelectionMode = "ExplicitLevels"
resTT@cnLevels=(/-3,-1/)
resTT@cnInfoLabelOn   = True
resTT@cnLineLabelInterval        = 1             ; default = 2
resTT@cnLineLabelPlacementMode   = "constant"    ; choose constant label method
resTT@cnLineThicknessF=thick
resTT@cnLineColor       = "Blue"  ;"magenta4"


respre@cnFillOn        = False
respre@cnLinesOn       = True
respre@cnLineLabelsOn  = True
respre@gsnDraw         = False
respre@gsnFrame        = False
respre@gsnCenterString=""
respre@gsnLeftString =""
respre@gsnRightString =""
respre@cnLevelSelectionMode = "ExplicitLevels"
respre@cnLevels=(/10,30,50/)
respre@cnInfoLabelOn   = True
respre@cnLineLabelInterval        = 1             ; default = 2
respre@cnLineLabelPlacementMode   = "constant"    ; choose constant label method
respre@cnLineColor       = "magenta4"    ;"Blue"                  ; blue contour lines 
respre@cnLineDashPattern = 12    
respre@cnLineThicknessF=thick
 
wks = gsn_open_wks("eps", "wrfout_d03_"+timeslice)
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot00=gsn_csm_contour(wks,tt,resTT)
plot01=gsn_csm_contour(wks,rain,respre)
plot = gsn_csm_contour_map(wks,dbz,res)
overlay(plot,plot00)
overlay(plot,plot01)
attach_china_map(wks, plot)
draw(plot) 
frame(wks)

