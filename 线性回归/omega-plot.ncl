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

ttestval = 2.120 ;1.725 ;2.086

mylev = 300

map_lat_low = 25
map_lat_high = 46
map_lon_left = 62
map_lon_right = 108

snow = asciiread("./sst.txt",(/nyear/),"float")

uwindfile = addfile("../ncfile/ncep2nc/uwnd.mon.mean.nc","r")
vwindfile = addfile("../ncfile/ncep2nc/vwnd.mon.mean.nc","r")
hgtfile = addfile("../ncfile/ncep2nc/omega.mon.mean.nc","r")

uwinds = short2flt(uwindfile->uwnd)
vwinds = short2flt(vwindfile->vwnd)
hgts = short2flt(hgtfile->omega)


lat_wind = uwindfile->lat
lon_wind = uwindfile->lon
year=calendar_decode2(uwindfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))

year2=calendar_decode2(hgtfile->time,0)
year_idx2=ind(year2(:,0).ge.(yearstart).and.year2(:,0).le.(yearend))

level_wind = uwindfile->level
lev_wind = ind(level_wind.eq.mylev)

uwind= uwinds(year_idx,lev_wind,:,:)
vwind = vwinds(year_idx,lev_wind,:,:)
hgt = hgts(year_idx2,lev_wind,:,:)

uwind_season = (uwind(idx_A::12,:,:) + uwind(idx_B::12,:,:) + uwind(idx_C::12,:,:)) / 3.0
vwind_season = (vwind(idx_A::12,:,:) + vwind(idx_B::12,:,:) + vwind(idx_C::12,:,:)) / 3.0
hgt_season = (hgt(idx_A::12,:,:) + hgt(idx_B::12,:,:) + hgt(idx_C::12,:,:)) / 3.0 
hgt_season=hgt_season*3600.0

rc_uwind = regCoef_n(snow, uwind_season, 0, 0)
rc_vwind = regCoef_n(snow, vwind_season, 0, 0)
rc_hgt = regCoef_n(snow, hgt_season, 0, 0)


tval_uwind = reshape(abs(rc_uwind@tval),(/dimsizes(rc_uwind(:,0)),dimsizes(rc_uwind(0,:))/))
tval_vwind = reshape(abs(rc_vwind@tval),(/dimsizes(rc_vwind(:,0)),dimsizes(rc_vwind(0,:))/))
tval_hgt = reshape(rc_hgt@tval,(/dimsizes(rc_hgt(:,0)),dimsizes(rc_hgt(0,:))/))

u_sig = where(tval_uwind.ge.ttestval.or.tval_vwind.ge.ttestval,rc_uwind,rc_uwind@_FillValue)
u_not_sig = where(tval_uwind.lt.ttestval.and.tval_vwind.lt.ttestval,rc_uwind,rc_uwind@_FillValue)

v_sig = where(tval_uwind.ge.ttestval.or.tval_vwind.ge.ttestval,rc_vwind,rc_vwind@_FillValue)
v_not_sig = where(tval_uwind.lt.ttestval.and.tval_vwind.lt.ttestval,rc_vwind,rc_vwind@_FillValue)


copy_VarMeta(uwind(0,:,:),rc_uwind)
copy_VarMeta(vwind(0,:,:),rc_vwind)
copy_VarMeta(hgt(0,:,:),rc_hgt)


copy_VarMeta(uwind(0,:,:),tval_uwind)
copy_VarMeta(vwind(0,:,:),tval_vwind)
copy_VarMeta(hgt(0,:,:),tval_hgt)

copy_VarMeta(uwind(0,:,:),u_sig)
copy_VarMeta(vwind(0,:,:),v_sig)

copy_VarMeta(uwind(0,:,:),u_not_sig)
copy_VarMeta(vwind(0,:,:),v_not_sig)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMinLonF = -110
res@mpMaxLonF = 150

res@mpCenterLonF=0

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/-35,-25,-15,-5,0,5,15,25,35/)
;res@cnFillColors=(/4,5,6,7,0,0,12,13,14,15/)


res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "omega-"+season)
gsn_define_colormap(wks,"BlueRed")

map = gsn_csm_contour_map(wks, rc_hgt, res)

resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)







resshade=True
resshade@pmTickMarkDisplayMode="Always"
resshade@cnFillOn=True
resshade@cnLinesOn=False
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False
resshade@cnMonoFillColor=True
resshade@cnFillDotSizeF=0.005
resshade@gsnAddCyclic=False
resshade@gsnDraw=False
resshade@gsnFrame=False
resshade@gsnLeftString=""
resshade@gsnRightString=""
resshade@lbLabelBarOn=False
resshade@cnInfoLabelOn=False

resshade2 = resshade

resshade@cnFillPatterns=(/-1,17/)
resshade@cnFillColor = "red"
;resshade@cnFillScaleF = 2.0
resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/ttestval/)


map2 = gsn_csm_contour(wks, tval_hgt, resshade)
overlay(map,map2)

resshade2@cnFillPatterns=(/17,-1/)
resshade2@cnFillColor = "blue"
;resshade2@cnFillScaleF = 2.0
resshade2@cnLevelSelectionMode="ExplicitLevels"
resshade2@cnLevels=(/-ttestval/)

map22 = gsn_csm_contour(wks, tval_hgt, resshade2)
overlay(map,map22)

;resshade=True
;resshade@pmTickMarkDisplayMode="Always"
;resshade@cnFillOn=False
;resshade@cnLinesOn=True
;resshade@cnLineLabelsOn=False
;resshade@cnMonoFillPattern=False
;resshade@cnMonoFillColor=True
;resshade@gsnDraw=False
;resshade@gsnFrame=False
;resshade@gsnLeftString=""
;resshade@gsnRightString=""
;resshade@lbLabelBarOn=False
;resshade@cnInfoLabelOn=False
;resshade@gsnAddCyclic=True
;
;resshade@cnLevelSelectionMode="ExplicitLevels"
;resshade@cnLevels=(/ttestval/)
;resshade@cnLineThicknessF = 4
;resshade@cnLineColor = "red"
;
;;tval_hgt=smth9_Wrap(tval_hgt, 0.5, -0.25, False)
;
;map2 = gsn_csm_contour(wks, tval_hgt, resshade)
;overlay(map,map2)



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



