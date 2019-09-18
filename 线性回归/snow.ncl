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

snow = asciiread("../../snow/before.txt",(/nyear/),"float")

airfile = addfile("../../ncfile/rutgersnownc/mysnowcover.nc","r")

airs = airfile->snowcover

lat=airfile->lat
lon=airfile->lon



lat_idx=ind(lat.ge.25.and.lat.le.46.5)
lon_idx=ind(lon.ge.64.and.lon.le.106)

lat_tibet=lat(lat_idx)
lon_tibet=lon(lon_idx)

year=calendar_decode2(airfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))


air = airs(year_idx,:,:)


hA = air(idx_A::12,:,:)
hB = air(idx_B::12,:,:)
hC = air(idx_C::12,:,:)
air_season = (hA + hB + hC) / 3.0 

rc_air = regCoef_n(snow, air_season, 0, 0)


tval_air = reshape(rc_air@tval,(/dimsizes(rc_air(:,0)),dimsizes(rc_air(0,:))/))
tval_air = where(tval_air.eq.-900, 0, tval_air)

;print(tval_air)

copy_VarMeta(air(0,:,:),rc_air)

copy_VarMeta(air(0,:,:),tval_air)



res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnMaximize=True


res@mpLimitMode        = "Corners"               ; Portion of map to zoom
res@mpLeftCornerLatF   = lat(lat_idx(0))
res@mpLeftCornerLonF   = lon(lon_idx(0))
res@mpRightCornerLatF  = lat(lat_idx(dimsizes(lat_idx)-1))
res@mpRightCornerLonF  = lon(lon_idx(dimsizes(lon_idx)-1))


res@mpCenterLonF=180

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
;res@cnLevels=(/-1.1,-0.9,-0.7,-0.5,-0.3,-0.1,0,0.1,0.3,0.5,0.7,0.9,1.1/)
res@cnLevels=fspan(-20,20,21)
;res@cnFillColors=(/18,34,50,66,82,0,0,146,162,178,194,210,226,242,255,268/)

res@lbOrientation="Vertical"

;res@cnFillOpacityF=0.8

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "snow-"+season)
gsn_define_colormap(wks,"BlueWhiteOrangeRed")


map = gsn_csm_contour_map(wks, rc_air, res)


resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,f(:,0),f(:,1),resp)





resshade=True
resshade@pmTickMarkDisplayMode="Always"
resshade@cnFillOn=True
resshade@cnLinesOn=False
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False
resshade@cnMonoFillColor=True
resshade@gsnAddCyclic=False
resshade@gsnDraw=False
resshade@gsnFrame=False
resshade@gsnLeftString=""
resshade@gsnRightString=""
resshade@lbLabelBarOn=False
resshade@cnInfoLabelOn=False
resshade@cnFillColor = "black"
resshade@cnFillScaleF = 2.0

resshade2 = resshade

resshade@cnFillPatterns=(/-1,17/)
resshade@cnFillDotSizeF=0.004
resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/ttestval/)

resshade2@cnFillPatterns=(/17,-1/)
resshade2@cnFillDotSizeF=0.004
resshade2@cnLevelSelectionMode="ExplicitLevels"
resshade2@cnLevels=(/-ttestval/)

;tval_air=smth9_Wrap(tval_air, 0.5, -0.25, False)

map2 = gsn_csm_contour(wks, tval_air, resshade)
overlay(map,map2)


map3 = gsn_csm_contour(wks, tval_air, resshade2)
overlay(map,map3)

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

llat_idx = ind(lat.ge.tibet_lat_low.and.lat.le.tibet_lat_high)
llon_idx = ind(lon.ge.tibet_lon_left.and.lon.le.tibet_lon_right)
ave = dim_avg_n_Wrap(dim_avg_n_Wrap(rc_air(llat_idx,llon_idx), 0),0)

print(ave)


draw(map)
frame(wks)
