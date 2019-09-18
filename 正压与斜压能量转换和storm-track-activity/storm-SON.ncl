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

ttestval = 2.069

snow = asciiread("./sst.txt",(/nyear/),"float")

airfile = addfile("./storm.nc","r")

air = airfile->storm(0:191,:,:)


lat_wind = airfile->lat
lon_wind = airfile->lon



hA = air(idx_A::12,:,:)
hB = air(idx_B::12,:,:)
hC = air(idx_C::12,:,:)
air_season = (hA + hB + hC) / 3.0 

rc_air = regCoef_n(snow, air_season, 0, 0)

tval_air = reshape(rc_air@tval,(/dimsizes(rc_air(:,0)),dimsizes(rc_air(0,:))/))

copy_VarMeta(air(0,:,:),rc_air)

copy_VarMeta(air(0,:,:),tval_air)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMaxLatF = 80
res@mpMinLonF = -100
res@mpMaxLonF = 0

res@mpCenterLonF=180

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
;res@cnLevels=(/-1.1,-0.9,-0.7,-0.5,-0.3,-0.1,0,0.1,0.3,0.5,0.7,0.9,1.1/)
res@cnLevels=fspan(-20,20,21)
;res@cnFillColors=(/2,10,18,26,34,42,50,58,66,82,0,0,143,146,149,152,155,158,161,164,167,170,173,176/)

res@lbOrientation="Vertical"

;res@cnFillOpacityF=0.8

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "storm-"+season)
gsn_define_colormap(wks,"BlueRed")


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

ufile = addfile("../ncfile/ncep2nc/uwnd.mon.mean.nc","r")
vfile = addfile("../ncfile/ncep2nc/vwnd.mon.mean.nc","r")

yearstart = 1979
yearend = 1994
nyear = yearend - yearstart + 1

mylev = 200 

year=calendar_decode2(ufile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))
level_wind = ufile->level
lev_wind = ind(level_wind.eq.mylev)


uwnds = short2flt(ufile->uwnd(year_idx,lev_wind,:,:))
vwnds = short2flt(vfile->vwnd(year_idx,lev_wind,:,:))


uA = uwnds(idx_A::12,:,:)
uB = uwnds(idx_B::12,:,:)
uC = uwnds(idx_C::12,:,:)
u_season = (uA + uB + uC) / 3.0 

vA = vwnds(idx_A::12,:,:)
vB = vwnds(idx_B::12,:,:)
vC = vwnds(idx_C::12,:,:)
v_season = (vA + vB + vC) / 3.0 

uwnd_season_clim = dim_avg_n_Wrap(u_season, 0)
vwnd_season_clim = dim_avg_n_Wrap(v_season, 0)

copy_VarMeta(uA(0,:,:),uwnd_season_clim)
copy_VarMeta(uA(0,:,:),vwnd_season_clim)

res2 = True
res2@cnFillOn=False
res2@cnLinesOn=True
res2@gsnLeftString=""
res2@gsnRightString=""
res2@gsnDraw=False
res2@gsnFrame=False
res2@gsnAddCyclic=True

res2@cnInfoLabelOn=False
res2@cnLevelSelectionMode = "ExplicitLevels"
res2@cnLevels=ispan(14,100,4)

res2@cnLineThicknessF = 4

map333 = gsn_csm_contour(wks, uwnd_season_clim, res2)
overlay(map, map333)

draw(map)
frame(wks)
