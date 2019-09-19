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

mylev = 200

snow = asciiread("../../fig01/before.txt",(/nyear/),"float")

ufile = addfile("../../ncfile/ncep2nc/uwnd.mon.mean.nc","r")
vfile = addfile("../../ncfile/ncep2nc/vwnd.mon.mean.nc","r")

us = short2flt(ufile->uwnd)
vs = short2flt(vfile->vwnd)

lat = ufile->lat
lon = ufile->lon
time = ufile->time
level = ufile->level
year=calendar_decode2(ufile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))
level_wind = ufile->level
lev_wind = ind(level_wind.eq.mylev)

u = us(year_idx,lev_wind,:,:)
v = vs(year_idx,lev_wind,:,:)

uA = u(idx_A::12,:,:)
uB = u(idx_B::12,:,:)
uC = u(idx_C::12,:,:)
u_season = (uA + uB + uC) / 3.0 
copy_VarMeta(uC, u_season)

vA = v(idx_A::12,:,:)
vB = v(idx_B::12,:,:)
vC = v(idx_C::12,:,:)
v_season = (vA + vB + vC) / 3.0 

pi = atan(1.0)*4.
f =  2.*2.*pi/(60.*60.*24.)*sin(pi/180. * lat)

rv = uv2vr_cfd(u_season,v_season,lat,lon,3)
av = rv + conform_dims(dimsizes(rv), f, 1)

av_anom = regCoef_n(snow, av, 0, 0)
av_mean = dim_avg_n_Wrap(av, 0)

div = uv2dv_cfd(u_season,v_season,lat,lon,3)

dv = dv2uvF_Wrap(div)
dv_u = dv(0,:,:,:)
dv_v = dv(1,:,:,:)

dv_u_anom = regCoef_n(snow, dv_u, 0, 0)
dv_v_anom = regCoef_n(snow, dv_v, 0, 0)

dv_u_mean = dim_avg_n_Wrap(dv_u, 0)
dv_v_mean = dim_avg_n_Wrap(dv_v, 0)

s = -uv2dv_cfd(dv_u_anom*av_mean,dv_v_anom*av_mean,lat,lon,3)-uv2dv_cfd(dv_u_mean*av_anom,dv_v_mean*av_anom,lat,lon,3)
copy_VarMeta(u(0,:,:), s)

ss = -uv2dv_cfd(dv_u*av, dv_v*av, lat, lon, 3)
sssy = regCoef_n(snow, ss, 0, 0)
tval_air = reshape(abs(sssy@tval),(/dimsizes(sssy(:,0)),dimsizes(sssy(0,:))/))


ab = shaeC(s)
ssq = exp_tapershC(ab, 19.4, 2)
sss = shseC(ssq, dimsizes(lon))*1e11
printVarSummary(sss)
copy_VarMeta(u(0,:,:), sss)

copy_VarMeta(u(0,:,:), tval_air)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMaxLatF = 70
res@mpMaxLonF = 240
res@mpMinLonF = 60

res@mpCenterLonF=180

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/-3.5,-3,-2.5,-2,-1.5,-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5/)
;res@cnLevels=(/-2.25,-1.75,-1.25,-0.75,-0.25,0,0.25,0.75,1.25,1.75,2.25/)
;res@cnLevels=(/-4.5,-3.5,-2.5,-1.5,-0.5,0,0.5,1.5,2.5,3.5,4.5/)
;res@cnFillColors=(/2,4,5,6,7,9,0,0,11,12,13,14,15,16/)
res@cnFillColors=(/2,18,34,50,66,82,88,0,0,143,145,147,149,150,160,170,180,190/)

res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("pdf", "source-"+season)
gsn_define_colormap(wks,"BlueWhiteOrangeRed")


map = gsn_csm_contour_map(wks, sss, res)


resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

fty=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,fty(:,0),fty(:,1),resp)







lat_low = 42.0
lat_high = 67.0
lon_left = 115 ;291.0
lon_right = 130 ;318.0
yp = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
xp = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
resc=True
resc@gsLineColor      = "red"                     ; color of lines
resc@gsLineThicknessF = 6.0                       ; thickness of lines
dums = new(4,graphic)
do i = 0 , 3
    dums(i)=gsn_add_polyline(wks,map,xp(i:i+1),yp(i:i+1),resc)
end do
idx_region_lat = ind(lat.ge.lat_low.and.lat.le.lat_high)
idx_region_lon=ind(lon.ge.lon_left.and.lon.le.lon_right)
region_ave = dim_avg_n_Wrap(dim_avg_n_Wrap(ss(:,idx_region_lat,idx_region_lon),2),1)

rc = escorc_n(region_ave,snow,0,0)
t = abs(rc * sqrt( (nyear-2) / (1-rc*rc) ))
flag=t.ge.ttestval
print("PASS 95: " +rc+" "+ flag)












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
res2@cnLevels=ispan(30,100,10)

res2@cnLineThicknesses = 6

map3 = gsn_csm_contour(wks, dim_avg_n_Wrap(u_season, 0), res2)
overlay(map, map3)



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