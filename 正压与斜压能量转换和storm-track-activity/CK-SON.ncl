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

snow = asciiread("./sst.txt",(/nyear/),"float")

ufile = addfile("../ncfile/ncep2nc/uwnd.mon.mean.nc","r")
vfile = addfile("../ncfile/ncep2nc/vwnd.mon.mean.nc","r")

lat_wind = ufile->lat
lon_wind = ufile->lon
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

rc_u = regCoef_n(snow, u_season, 0, 0)
rc_v = regCoef_n(snow, v_season, 0, 0)

copy_VarMeta(uA(0,:,:),rc_u)
copy_VarMeta(vA(0,:,:),rc_v)

uwnd_season_clim = dim_avg_n_Wrap(u_season, 0)
vwnd_season_clim = dim_avg_n_Wrap(v_season, 0)

re=6378388
pi = atan(1.0)*4.
dudx = center_finite_diff_n(uwnd_season_clim, lon_wind*pi/180.*re, True,0,1)
dvdx = center_finite_diff_n(vwnd_season_clim, lon_wind*pi/180.*re, True,0,1)
dudy = center_finite_diff_n(uwnd_season_clim, lat_wind*pi/180.*re, True,0,0)
dvdy = center_finite_diff_n(vwnd_season_clim, lat_wind*pi/180.*re, True,0,0)

ck = (rc_v*rc_v-rc_u*rc_u)/2.0*(dudx-dvdy)-rc_u*rc_v*(dudy+dvdx)
ck = ck * 1E5
copy_VarMeta(uA(0,:,:), ck)
copy_VarMeta(uA(0,:,:),uwnd_season_clim)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMaxLatF = 80
res@mpMinLonF = -100
res@mpMaxLonF = 0

res@mpCenterLonF=0

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/-2.0,-1.5,-1.0,-0.5,0,0.5,1.0,1.5,2.0/)
res@cnFillColors=(/4,5,6,7,0,0,12,13,14,15/)


res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "CK-"+mylev+"-"+season)
gsn_define_colormap(wks,"BlueDarkRed18")

map = gsn_csm_contour_map(wks, ck, res)

resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)


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

map3 = gsn_csm_contour(wks, uwnd_season_clim, res2)
overlay(map, map3)



draw(wks)
frame(wks)
