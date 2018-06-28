load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wrffile=addfile("./SBU/wrfout_d03_2014-05-22_06:00:00","r")
aa=229
bb=231
cc=250
dd=252

opts=True
opts@extrapolate=True
;opts@field_type="ght"
;dbz_tmp = wrf_user_getvar(wrffile,"dbz",-1)
;dbz=wrf_user_vert_interp(wrffile,dbz_tmp,"ght_agl",3,opts)
DBZ= wrf_user_getvar(wrffile,"dbz",-1)
dbz=DBZ(0,0,cc:dd,aa:bb)
TT=wrf_user_getvar(wrffile,"T",-1)
tt=TT(0,0,cc:dd,aa:bb)

opts=True
opts@field_type="pressure"
UU=wrf_user_vert_interp(wrffile,wrf_user_getvar(wrffile,"ua",-1),"pressure",500,opts)
VV=wrf_user_vert_interp(wrffile,wrf_user_getvar(wrffile,"va",-1),"pressure",500,opts)
uu=UU(0,0,cc:dd,aa:bb)
vv=VV(0,0,cc:dd,aa:bb)

lat1 = wrf_user_getvar(wrffile,"XLAT",0)
lon1 = wrf_user_getvar(wrffile,"XLONG",0)

lattt=lat1(cc:dd,aa:bb)
lonnn=lon1(cc:dd,aa:bb)
print(lat1(251,230))
print(lon1(251,230))

dbz@lat2d = lattt
dbz@lon2d = lonnn
tt@lat2d = lattt
tt@lon2d = lonnn
uu@lat2d = lattt
uu@lon2d = lonnn
vv@lat2d = lattt
vv@lon2d = lonnn

dom_dims = dimsizes(dbz)
dom_rank = dimsizes(dom_dims)
nx1 = dom_dims(dom_rank - 1) - 1
ny1 = dom_dims(dom_rank - 2) - 1

res                 = True
resTT =res
resvc=res

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
res@mpLeftCornerLatF   = lattt(0,0)
res@mpLeftCornerLonF   = lonnn(0,0)
res@mpRightCornerLatF  = lattt(ny1,nx1)
res@mpRightCornerLonF  = lonnn(ny1,nx1)
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame
res@gsnLeftString =""
res@gsnCenterString="2014-05-22_06:00:00"

resTT@cnFillOn        = False
resTT@cnLinesOn       = True
resTT@cnLineLabelsOn  = True
resTT@gsnDraw         = False
resTT@gsnFrame        = False
resTT@gsnCenterString=""
resTT@gsnLeftString =""
resTT@gsnRightString =""
resTT@cnLevelSelectionMode = "ExplicitLevels"
resTT@cnLevels=ispan(-11,0,1)
resTT@cnInfoLabelOn   = True
resTT@cnLineLabelInterval        = 1             ; default = 2
resTT@cnLineLabelPlacementMode   = "constant"    ; choose constant label method

resvc@gsnDraw         = False
resvc@gsnFrame        = False
resvc@gsnCenterString=""
resvc@gsnLeftString =""
resvc@gsnRightString =""
resvc@vcMinDistanceF=0.0005

wks = gsn_open_wks("eps", "SBU")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot00=gsn_csm_contour(wks,tt , resTT)
plot01=gsn_csm_streamline(wks,uu , vv,resvc)
plot = gsn_csm_contour_map(wks,dbz , res)
overlay(plot,plot00)
overlay(plot,plot01)
attach_china_map(wks, plot)
draw(plot) 
frame(wks)

