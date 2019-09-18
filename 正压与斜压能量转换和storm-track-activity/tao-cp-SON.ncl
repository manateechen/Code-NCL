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


R = 290
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

ape_local = R*t*t/2.0/sigma/press

ape_new = new((/dimsizes(level)-1,dimsizes(lat),dimsizes(lon)/), "float")
ape_new = (ape_local(0:dimsizes(level)-2,:,:)+ape_local(1:dimsizes(level)-1,:,:))/2.0

ape = dim_sum_n_Wrap(ape_new*dp_new, 0)

lon = lonFlip(lon)
cp = lonFlip(cp)
ape = lonFlip(ape)
lon(0:71) = lon(0:71) - 360.0

idxLon = ind(lon.ge.-90.and.lon.le.120)

idxLat = ind(lat.ge.10.and.lat.le.90)

cp_domain = cp(idxLat,idxLon)
ape_domain = ape(idxLat,idxLon)

tao_cp = dim_sum_n_Wrap(dim_sum_n_Wrap(ape_domain, 1),0)/dim_sum_n_Wrap(dim_sum_n_Wrap(cp_domain, 1),0)/24.0/3600.0
print(tao_cp)
