load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "../snow/interannual.ncl"

; SON
season = "SON"
idx_A = 8
idx_B = 9
idx_C = 10

yearstart = 1979
yearend = 1994
nyear = yearend - yearstart + 1

ttestval = 2.120 ;1.725 ;2.086

snow = asciiread("../snow/before.txt",(/nyear/),"float")

airfile = addfile("../ncfile/ncep2nc/q1-wzb.nc","r")

airs = airfile->q1


lat_wind = airfile->lat
lon_wind = airfile->lon
year=calendar_decode2(airfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))

air = airs(year_idx,:,:)

hA = air(idx_A::12,:,:)
hB = air(idx_B::12,:,:)
hC = air(idx_C::12,:,:)
air_season = (hA + hB + hC) / 3.0 
copy_VarMeta(hA, air_season)

rc_air = regCoef_n(snow, air_season, 0, 0)
tval_air = reshape(rc_air@tval,(/dimsizes(rc_air(:,0)),dimsizes(rc_air(0,:))/))


copy_VarMeta(air(0,:,:),rc_air)
copy_VarMeta(air(0,:,:),tval_air)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMaxLatF = 80
res@mpMinLonF = 260
res@mpMaxLonF = 360


res@mpCenterLonF=180

res@mpFillOn=False

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(-60,60,21)
;res@cnFillColors=(/5,7,9,0,0,12,14,16/)

res@lbOrientation="horizontal"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "Q1-"+season)
gsn_define_colormap(wks,"BlueRed")


map = gsn_csm_contour_map(wks, rc_air, res)


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

resshade2 = resshade

resshade@cnFillPatterns=(/-1,17/)
resshade@cnFillDotSizeF=0.005
resshade@cnFillColor = "red"
resshade@cnFillScaleF = 1.4
resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/ttestval/)


resshade2@cnFillPatterns=(/17,-1/)
resshade2@cnFillDotSizeF=0.005
resshade2@cnFillColor = "blue"
resshade2@cnFillScaleF = 1.4
resshade2@cnLevelSelectionMode="ExplicitLevels"
resshade2@cnLevels=(/-ttestval/)



map2 = gsn_csm_contour(wks, tval_air, resshade)
overlay(map,map2)

map3 = gsn_csm_contour(wks, tval_air, resshade2)
overlay(map,map3)


;lat_low = 35.0 
;lat_high = 50.0
;lon_left = 320.0 
;lon_right = 335.0 ;330.0
;ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
;xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
;resc=True
;resc@gsLineColor      = "blue"                     ; color of lines
;resc@gsLineThicknessF = 6.0                       ; thickness of lines
;dumm = new(4,graphic)
;do i = 0 , 3
;    dumm(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
;end do
;idx_region_lat = ind(lat_wind.ge.lat_low.and.lat_wind.le.lat_high)
;idx_region_lon=ind(lon_wind.ge.lon_left.and.lon_wind.le.lon_right)
;region_ave3 = dim_avg_n_Wrap(dim_avg_n_Wrap(air_season(:,idx_region_lat,idx_region_lon),2),1)
;delete(idx_region_lat)
;delete(idx_region_lon)
;
;
;lat_low = 25.0 
;lat_high = 40.0 
;lon_left = 280.0
;lon_right = 295.0 ;300.0 
;ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
;xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
;resc=True
;resc@gsLineColor      = "red"                     ; color of lines
;resc@gsLineThicknessF = 6.0                       ; thickness of lines
;dum = new(4,graphic)
;do i = 0 , 3
;    dum(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
;end do
;idx_region_lat = ind(lat_wind.ge.lat_low.and.lat_wind.le.lat_high)
;idx_region_lon=ind(lon_wind.ge.lon_left.and.lon_wind.le.lon_right)
;region_ave4 = dim_avg_n_Wrap(dim_avg_n_Wrap(air_season(:,idx_region_lat,idx_region_lon),2),1)
;
draw(map)
frame(wks)

