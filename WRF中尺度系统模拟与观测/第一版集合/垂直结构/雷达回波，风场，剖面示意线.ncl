load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"


opts=True
opts@extrapolate=False
opts@field_type="ght"


wrffile=addfile("wrfout_d03_2014-05-22_01:00:00","r")

tmp00= wrf_user_getvar(wrffile,"dbz",-1)
tmp=wrf_user_vert_interp(wrffile,tmp00,"ght_agl",1,opts)
dbz=tmp(:,:,230:260,210:250)

utmp00=wrf_user_getvar(wrffile,"ua",-1)
vtmp00=wrf_user_getvar(wrffile,"va",-1)

utmp=wrf_user_vert_interp(wrffile,utmp00,"ght_agl",1,opts)
vtmp=wrf_user_vert_interp(wrffile,vtmp00,"ght_agl",1,opts)

u=utmp(:,0,230:260,210:250)
v=vtmp(:,0,230:260,210:250)

lattmp = wrf_user_getvar(wrffile,"XLAT",0)
lontmp = wrf_user_getvar(wrffile,"XLONG",0)

lat1=lattmp(230:260,210:250)
lon1=lontmp(230:260,210:250)

dbz@lat2d = lat1
dbz@lon2d = lon1

u@lat2d = lat1
v@lat2d = lat1
u@lon2d = lon1
v@lon2d = lon1

dom_dims = dimsizes(dbz)
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
res@mpLeftCornerLatF   = lat1(0,0)
res@mpLeftCornerLonF   = lon1(0,0)
res@mpRightCornerLatF  = lat1(ny1,nx1)
res@mpRightCornerLonF  = lon1(ny1,nx1)
res@lbLabelAutoStride = True
res@gsnMaximize     = True    ; Maximize plot in frame
res@gsnLeftString =""
res@gsnCenterString="2014-05-22_01:00"

vcres=True
vcres@gsnDraw         = False
vcres@gsnFrame        = False
vcres@tfDoNDCOverlay=True
vcres@vcFillArrowsOn=False
vcres@vcRefLengthF=0.07
vcres@vcGlyphStyle="CurlyVector"
vcres@vcMinDistanceF=0.001
vcres@vcLineArrowThicknessF=1
vcres@vcRefAnnoOrthogonalPosF=0.001
vcres@vcRefAnnoOn=False
vcres@gsnMaximize=True 
vcres@gsnRightString          = ""
vcres@gsnLeftString           = ""

wks = gsn_open_wks("eps", "slice")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour_map(wks,dbz(0,0,:,:) , res)
plot1=gsn_csm_vector(wks,u(0,:,:),v(0,:,:),vcres)
overlay(plot,plot1)
attach_china_map(wks, plot)
draw(plot) 




xxx=fspan(112.7,112.3,100)
yyy=fspan(23.7,24.1,100)
gsn_polyline(wks,plot,xxx,yyy,True)


xxx1=fspan(112.65,112.25,100)
yyy1=fspan(23.65,24.05,100)
gsn_polyline(wks,plot,xxx1,yyy1,True)

frame(wks)
