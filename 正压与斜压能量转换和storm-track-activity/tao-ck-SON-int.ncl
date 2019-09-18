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

ufile = addfile("../ncfile/ncep2nc/uwnd.mon.mean.nc","r")
vfile = addfile("../ncfile/ncep2nc/vwnd.mon.mean.nc","r")

lat_wind = ufile->lat
lon_wind = ufile->lon
year=calendar_decode2(ufile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))
level = ufile->level


uwnds = short2flt(ufile->uwnd(year_idx,:,:,:))
vwnds = short2flt(vfile->vwnd(year_idx,:,:,:))




uA = uwnds(idx_A::12,:,:,:)
uB = uwnds(idx_B::12,:,:,:)
uC = uwnds(idx_C::12,:,:,:)
u_season = (uA + uB + uC) / 3.0 

vA = vwnds(idx_A::12,:,:,:)
vB = vwnds(idx_B::12,:,:,:)
vC = vwnds(idx_C::12,:,:,:)
v_season = (vA + vB + vC) / 3.0 

rc_u = regCoef_n(snow, u_season, 0, 0)
rc_v = regCoef_n(snow, v_season, 0, 0)

copy_VarMeta(uA(0,:,:,:),rc_u)
copy_VarMeta(vA(0,:,:,:),rc_v)

uwnd_season_clim = dim_avg_n_Wrap(u_season, 0)
vwnd_season_clim = dim_avg_n_Wrap(v_season, 0)

re=6378388
pi = atan(1.0)*4.
dudx = center_finite_diff_n(uwnd_season_clim, lon_wind*pi/180.*re, True,0,2)
dvdx = center_finite_diff_n(vwnd_season_clim, lon_wind*pi/180.*re, True,0,2)
dudy = center_finite_diff_n(uwnd_season_clim, lat_wind*pi/180.*re, True,0,1)
dvdy = center_finite_diff_n(vwnd_season_clim, lat_wind*pi/180.*re, True,0,1)

ckk = (rc_v*rc_v-rc_u*rc_u)/2.0*(dudx-dvdy)-rc_u*rc_v*(dudy+dvdx)

kee = (rc_u*rc_u + rc_v*rc_v)/2.0

dp = new(dimsizes(level)-1, "float")
dp = level(0:dimsizes(level)-2) - level(1:dimsizes(level)-1)

ckk_new = new((/dimsizes(level)-1,dimsizes(lat_wind),dimsizes(lon_wind)/), "float")
ckk_new = (ckk(0:dimsizes(level)-2,:,:)+ckk(1:dimsizes(level)-1,:,:))/2.0

kee_new = new((/dimsizes(level)-1,dimsizes(lat_wind),dimsizes(lon_wind)/), "float")
kee_new = (kee(0:dimsizes(level)-2,:,:)+kee(1:dimsizes(level)-1,:,:))/2.0

dp_new = conform(ckk_new, dp, 0)

ck = dim_sum_n_Wrap(ckk_new*dp_new, 0)
ke = dim_sum_n_Wrap(kee_new*dp_new, 0)

lon_wind = lonFlip(lon_wind)
ck = lonFlip(ck)
ke = lonFlip(ke)
lon_wind(0:71) = lon_wind(0:71) - 360.0

idxLon = ind(lon_wind.ge.-100.and.lon_wind.le.0)
idxLat = ind(lat_wind.ge.10.and.lat_wind.le.80)

ck_domain = ck(idxLat,idxLon)
ke_domain = ke(idxLat,idxLon)
londomain = lon_wind(idxLon)
latdomain = lat_wind(idxLat)

tao = dim_sum_n_Wrap(dim_sum_n_Wrap(ke, 1),0)/dim_sum_n_Wrap(dim_sum_n_Wrap(ck, 1),0)/24.0/3600.0
print(tao)