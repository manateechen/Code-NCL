load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

; ASO
season = "ASO"
idx_A = 8
idx_B = 9
idx_C = 7

yearstart = 1979
yearend = 1994
nyear = yearend - yearstart + 1

ttestval = 2.120

snow = asciiread("../../snow/before.txt",(/nyear/),"float")

airfile = addfile("../../ncfile/cru/pre.nc","r")
airs = airfile->pre


lat_wind = airfile->lat
lon_wind = airfile->lon
year=calendar_decode2(airfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))

air = airs(year_idx,:,:)

hA = air(idx_A::12,:,:)
hB = air(idx_B::12,:,:)
hC = air(idx_C::12,:,:)
air_season = (hA + hB + hC) / 3.0 

rc_air = regCoef_n(snow, air_season, 0, 0)
tval_air = reshape(abs(rc_air@tval),(/dimsizes(rc_air(:,0)),dimsizes(rc_air(0,:))/))

copy_VarMeta(air(0,:,:),rc_air)

copy_VarMeta(air(0,:,:),tval_air)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 25
res@mpMaxLatF = 46.5
res@mpMinLonF = 64
res@mpMaxLonF = 106

res@mpCenterLonF=180

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
;res@cnLevels=(/-1.1,-0.9,-0.7,-0.5,-0.3,-0.1,0,0.1,0.3,0.5,0.7,0.9,1.1/)
res@cnLevels=ispan(-15,15,1)
;res@cnFillColors=(/18,34,50,66,82,0,0,146,162,178,194,210,226,242,255,268/)

res@lbOrientation="Vertical"

;res@cnFillOpacityF=0.8

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "PRE-"+season)
gsn_define_colormap(wks,"BlueWhiteOrangeRed")


map = gsn_csm_contour_map(wks, rc_air, res)


resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,f(:,0),f(:,1),resp)



resvc                  = True                      ; plot mods desired
resvc@gsnDraw=False
resvc@gsnFrame=False

resvc@gsnLeftString=""
resvc@gsnRightString=""

resvc@vcMinDistanceF=0.02

resvc@vcRefMagnitudeF  = 1
resvc@vcRefLengthF     = 0.025

resvc@vcGlyphStyle="FillArrow"
resvc@vcLineArrowThicknessF=2.6

resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "1"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -0.12
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

;map2 = gsn_csm_vector(wks,u_sig,v_sig,resvc)
;overlay(map,map2)



resshade=True
resshade@pmTickMarkDisplayMode="Always"
resshade@cnFillOn=True
resshade@cnLinesOn=False
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False
resshade@cnMonoFillColor=True

resshade@cnFillPatterns=(/-1,17/)
resshade@cnFillDotSizeF=0.004
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

tval_air=smth9_Wrap(tval_air, 0.5, -0.25, False)

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


llat_idx = ind(lat_wind.ge.tibet_lat_low.and.lat_wind.le.tibet_lat_high)
llon_idx = ind(lon_wind.ge.tibet_lon_left.and.lon_wind.le.tibet_lon_right)
ave = dim_avg_n_Wrap(dim_avg_n_Wrap(rc_air(llat_idx,llon_idx), 0),0)

print(ave)

draw(map)
frame(wks)
