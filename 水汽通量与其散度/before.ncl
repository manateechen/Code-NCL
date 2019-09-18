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
yearend = 1994
nyear = yearend - yearstart + 1

ttestval = 2.120

;snow = asciiread("../snow/before.txt",(/nyear/),"float")
snow = asciiread("../NA-SST-GC-P1/sst.txt",(/nyear/),"float")

wfile = addfile("../ncfile/ncep2nc/watflux.mon.mean.nc","r")

uwinds = wfile->uq_int
vwinds = wfile->vq_int
airs = wfile->qV_int_div


lat_wind = wfile->lat
lon_wind = wfile->lon
year=calendar_decode2(wfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))

uwind= uwinds(year_idx,:,:)
vwind = vwinds(year_idx,:,:)
air = airs(year_idx,:,:)

uA = uwind(idx_A::12,:,:)
uB = uwind(idx_B::12,:,:)
uC = uwind(idx_C::12,:,:)
uwind_season = (uA + uB + uC) / 3.0

vA = vwind(idx_A::12,:,:)
vB = vwind(idx_B::12,:,:)
vC = vwind(idx_C::12,:,:)
vwind_season = (vA + vB + vC) / 3.0

hA = air(idx_A::12,:,:)
hB = air(idx_B::12,:,:)
hC = air(idx_C::12,:,:)
air_season = (hA + hB + hC) / 3.0 

rc_uwind = regCoef_n(snow, uwind_season, 0, 0) 
rc_vwind = regCoef_n(snow, vwind_season, 0, 0) 
rc_air = regCoef_n(snow, air_season, 0, 0) 


tval_uwind = reshape(abs(rc_uwind@tval),(/dimsizes(rc_uwind(:,0)),dimsizes(rc_uwind(0,:))/))
tval_vwind = reshape(abs(rc_vwind@tval),(/dimsizes(rc_vwind(:,0)),dimsizes(rc_vwind(0,:))/))
tval_air = reshape(abs(rc_air@tval),(/dimsizes(rc_air(:,0)),dimsizes(rc_air(0,:))/))

rc_uwind = rc_uwind 
rc_vwind = rc_vwind 
rc_air = rc_air * 1e7

u_sig = where(tval_uwind.ge.ttestval.or.tval_vwind.ge.ttestval,rc_uwind,rc_uwind@_FillValue)
u_not_sig = where(tval_uwind.lt.ttestval.and.tval_vwind.lt.ttestval,rc_uwind,rc_uwind@_FillValue)

v_sig = where(tval_uwind.ge.ttestval.or.tval_vwind.ge.ttestval,rc_vwind,rc_vwind@_FillValue)
v_not_sig = where(tval_uwind.lt.ttestval.and.tval_vwind.lt.ttestval,rc_vwind,rc_vwind@_FillValue)


copy_VarMeta(uwind(0,:,:),rc_uwind)
copy_VarMeta(vwind(0,:,:),rc_vwind)
copy_VarMeta(air(0,:,:),rc_air)


copy_VarMeta(uwind(0,:,:),tval_uwind)
copy_VarMeta(vwind(0,:,:),tval_vwind)
copy_VarMeta(air(0,:,:),tval_air)

copy_VarMeta(uwind(0,:,:),u_sig)
copy_VarMeta(vwind(0,:,:),v_sig)

copy_VarMeta(uwind(0,:,:),u_not_sig)
copy_VarMeta(vwind(0,:,:),v_not_sig)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMaxLatF = 70
res@mpMinLonF = 40
res@mpMaxLonF = 150

;res@mpCenterLonF=180

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(-2,2,21)
res@cnFillColors=(/2,10,18,26,34,42,50,58,66,82,0,0,143,146,149,152,155,158,161,164,167,170,173,176/)

res@lbOrientation="Vertical"

;res@cnFillOpacityF=0.8

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "before-"+season)
gsn_define_colormap(wks,"BlueWhiteOrangeRed")


map = gsn_csm_contour_map(wks, rc_air, res)


resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,f(:,0),f(:,1),resp)



resvc                  = True                      ; plot mods desired
resvc@gsnDraw=False
resvc@gsnFrame=False

resvc@gsnLeftString=""
resvc@gsnRightString=""

resvc@vcMinDistanceF=0.02

resvc@vcRefMagnitudeF  = 0.08
resvc@vcRefLengthF     = 0.025

resvc@vcGlyphStyle="FillArrow"
resvc@vcLineArrowThicknessF=2.6

resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "0.08"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -0.115
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

map1 = gsn_csm_vector(wks,u_not_sig,v_not_sig,resvc)

overlay(map,map1)

resvc@vcFillArrowFillColor = "black"
resvc@vcFillArrowEdgeColor = "black"
resvc@vcGlyphOpacityF = 1

map2 = gsn_csm_vector(wks,u_sig,v_sig,resvc)
overlay(map,map2)



resshade=True
resshade@pmTickMarkDisplayMode="Always"
resshade@cnFillOn=True
resshade@cnLinesOn=False
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False
resshade@cnMonoFillColor=True

resshade@cnFillPatterns=(/-1,17/)
resshade@cnFillDotSizeF=0.006
resshade@cnFillColor = "black"
resshade@cnMonoFillScale = True 
resshade@cnFillScaleF = 2.0

resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/ttestval/)
resshade@lbLabelBarOn=False
resshade@cnInfoLabelOn=False

resshade@gsnAddCyclic=False

resshade@gsnDraw=False
resshade@gsnFrame=False

resshade@gsnLeftString=""
resshade@gsnRightString=""

;tval_air=smth9_Wrap(tval_air, 0.5, -0.25, False)

map2 = gsn_csm_contour(wks, tval_air, resshade)
overlay(map,map2)



tibet_lat_low = 27.5
tibet_lat_high = 36.0
tibet_lon_left = 88.5
tibet_lon_right = 100.5
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
