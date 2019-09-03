load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

; SON
season = "SON"
idx_A = 8
idx_B = 9
idx_C = 10

yearstart = 1979
yearend = 2017
nyear = yearend - yearstart + 1

ttestval = 2.228

mylev = 200

f = addfile("NM-TP-.nc", "r")

lat_wind = f->lat
lon_wind = f->lon


rc_hgt = f->hgt_high_ave


rc_uwind = f->uwnd_high_ave
rc_vwind = f->vwnd_high_ave



res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = -20
;res@mpMinLonF = 40
;res@mpMaxLonF = 285

res@mpCenterLonF=-60

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(-45, 45, 5)  

res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "NM-TP-")
gsn_define_colormap(wks,"ncl_default")

map = gsn_csm_contour_map(wks, rc_hgt, res)

resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)



resvc                  = True                      ; plot mods desired
resvc@gsnDraw=False
resvc@gsnFrame=False

resvc@gsnLeftString=""
resvc@gsnRightString=""
resvc@gsnAddCyclic=True

resvc@vcMinDistanceF=0.02

resvc@vcRefMagnitudeF  = 3
resvc@vcRefLengthF     = 0.025

resvc@vcGlyphStyle="FillArrow"
resvc@vcLineArrowThicknessF=2.6

resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "3"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -0.125
resvc@vcRefAnnoParallelPosF     = 0.999
resvc@vcRefAnnoBackgroundColor  = "green"
resvc@vcVectorDrawOrder         = "PostDraw"
resvc@vcFillArrowWidthF=0.05
resvc@vcFillArrowHeadYF=0.07

resvc@vcMonoFillArrowFillColor =True
resvc@vcFillArrowFillColor="black"
resvc@vcFillArrowEdgeColor="black"
resvc@vcGlyphOpacityF = 0.3

;map1 = gsn_csm_vector(wks,rc_uwind_200,rc_vwind_200,resvc)

;map1 = gsn_csm_vector(wks,u_not_sig,v_not_sig,resvc)

;overlay(map,map1)


resvc@vcFillArrowFillColor = "black"
resvc@vcFillArrowEdgeColor = "black"
resvc@vcGlyphOpacityF = 1

map2 = gsn_csm_streamline(wks,rc_uwind,rc_vwind,resvc)
overlay(map,map2)


tibet_lat_low = 30
tibet_lat_high = 40.0
tibet_lon_left = 70.0
tibet_lon_right = 82.0
ypts = (/tibet_lat_low,  tibet_lat_low, tibet_lat_high ,  tibet_lat_high, tibet_lat_low/)
xpts = (/tibet_lon_left, tibet_lon_right, tibet_lon_right, tibet_lon_left, tibet_lon_left/)
resc=True
resc@gsLineColor      = "red4"                     ; color of lines
resc@gsLineThicknessF = 3.0                       ; thickness of lines
dum5 = new(4,graphic)
dum6 = new(4,graphic)
dum7 = new(4,graphic)
dum8 = new(4,graphic)
do i = 0 , 3
  dum5(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum6(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum7(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum8(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do



draw(map)
frame(wks)
