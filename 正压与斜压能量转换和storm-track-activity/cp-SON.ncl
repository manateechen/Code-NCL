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

snow = asciiread("./sst.txt",(/nyear/),"float")

tfile = addfile("../ncfile/ncep2nc/air.mon.mean.nc","r")
ufile = addfile("../ncfile/ncep2nc/uwnd.mon.mean.nc","r")
vfile = addfile("../ncfile/ncep2nc/vwnd.mon.mean.nc","r")

lat = tfile->lat
lon = tfile->lon
year=calendar_decode2(tfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))

level = tfile->level
level = level*100.0

airdata = short2flt(tfile->air(year_idx,:,:,:))
udata = short2flt(ufile->uwnd(year_idx,:,:,:))
vdata = short2flt(vfile->vwnd(year_idx,:,:,:))

tA = airdata(idx_A::12,:,:,:)
tB = airdata(idx_B::12,:,:,:)
tC = airdata(idx_C::12,:,:,:)
t_season = (tA + tB + tC) / 3.0 
copy_VarMeta(tA, t_season)

uA = udata(idx_A::12,:,:,:)
uB = udata(idx_B::12,:,:,:)
uC = udata(idx_C::12,:,:,:)
u_season = (uA + uB + uC) / 3.0 
copy_VarMeta(uA, u_season)

vA = vdata(idx_A::12,:,:,:)
vB = vdata(idx_B::12,:,:,:)
vC = vdata(idx_C::12,:,:,:)
v_season = (vA + vB + vC) / 3.0 
copy_VarMeta(vA, v_season)

t_clim = dim_avg_n_Wrap(t_season, 0)
u_clim = dim_avg_n_Wrap(u_season, 0)
v_clim = dim_avg_n_Wrap(v_season, 0)



R_cp = 0.286
press = conform(t_clim, level, 0)
copy_VarMeta(t_clim, press)

dT_clim_dp = center_finite_diff_n(t_clim, level,False,0,0)

sigma = (R_cp*t_clim/press) - dT_clim_dp
copy_VarMeta(t_clim, sigma)
;print(sigma)

pi = atan(1.0)*4.
ff =  2.*2.*pi/(60.*60.*24.)*sin(pi/180. * lat)
f = conform(t_clim, ff, 1)

u = regCoef_n(snow, u_season, 0, 0)
v = regCoef_n(snow, v_season, 0, 0)
t = regCoef_n(snow, t_season, 0, 0)

du_clim_dp = center_finite_diff_n(u_clim, level,False,0,0)
dv_clim_dp = center_finite_diff_n(v_clim, level,False,0,0)

dcp = f/sigma*v*t*du_clim_dp - f/sigma*u*t*dv_clim_dp
copy_VarMeta(t_clim, dcp)

dp = new(dimsizes(level)-1, "float")
dp = level(0:dimsizes(level)-2) - level(1:dimsizes(level)-1)

dcp_new = new((/dimsizes(level)-1,dimsizes(lat),dimsizes(lon)/), "float")
dcp_new = (dcp(0:dimsizes(level)-2,:,:)+dcp(1:dimsizes(level)-1,:,:))/2.0


dp_new = conform(dcp_new, dp, 0)

cp = -dim_sum_n_Wrap(dcp_new*dp_new, 0)
copy_VarMeta(t_season(0,0,:,:), cp)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMinLonF = -90
res@mpMaxLonF = 120

;res@mpCenterLonF=0

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(-1.6,1.6,17) ;(/-2.0,-1.5,-1.0,-0.5,0,0.5,1.0,1.5,2.0/)
res@cnFillColors=(/2,11,18,23,29,36,43,49,0,0,58,65,73,80,86,91,96,100/)


res@lbOrientation="horizontal"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "cp-"+season)
gsn_define_colormap(wks,"BlWhRe")

map = gsn_csm_contour_map(wks, cp, res)

resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)

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

draw(wks)
frame(wks)
