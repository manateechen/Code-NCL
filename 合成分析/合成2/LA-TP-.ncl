load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"


; SON
season = "SON"
idx_A = 8
idx_B = 9
idx_C = 10

system("rm -rf LA-TP-.nc")

yearstart = 1979
yearend = 2017
nyear = yearend - yearstart + 1

mylev = 200

hgtfile = addfile("/home/qqf/Documents/PhD-Working/mypaper/ncfile/ncep2nc/hgt.mon.mean.nc","r")
uwindfile = addfile("/home/qqf/Documents/PhD-Working/mypaper/ncfile/ncep2nc/uwnd.mon.mean.nc","r")
vwindfile = addfile("/home/qqf/Documents/PhD-Working/mypaper/ncfile/ncep2nc/vwnd.mon.mean.nc","r")

hgts = short2flt(hgtfile->hgt)
uwinds = short2flt(uwindfile->uwnd)
vwinds = short2flt(vwindfile->vwnd)



lat_wind = hgtfile->lat
lon_wind = hgtfile->lon
year=calendar_decode2(hgtfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))
level_wind = hgtfile->level
lev_wind = ind(level_wind.eq.mylev)
ll = ind(level_wind.eq.850)

hgt = hgts(year_idx,lev_wind,:,:)
uwind= uwinds(year_idx,ll,:,:)
vwind = vwinds(year_idx,ll,:,:)

hA = hgt(idx_A::12,:,:)
hB = hgt(idx_B::12,:,:)
hC = hgt(idx_C::12,:,:)
hgt_season = dtrend_leftdim((hA + hB + hC) / 3.0 ,False)
copy_VarMeta(hC,hgt_season)

uA = uwind(idx_A::12,:,:)
uB = uwind(idx_B::12,:,:)
uC = uwind(idx_C::12,:,:)
uwind_season = dtrend_leftdim((uA + uB + uC) / 3.0 ,False)
copy_VarMeta(uC,uwind_season)

vA = vwind(idx_A::12,:,:)
vB = vwind(idx_B::12,:,:)
vC = vwind(idx_C::12,:,:)
vwind_season = dtrend_leftdim((vA + vB + vC) / 3.0 ,False)
copy_VarMeta(vC,vwind_season)

high_ind = (/5,9,20,21,28,31,37,38/)
n_high = dimsizes(high_ind)

hgt_high = hgt_season(high_ind,:,:)
hgt_high_ave = dim_avg_n_Wrap(hgt_high,0)-dim_avg_n_Wrap(hgt_season,0)
copy_VarMeta(hgt_season(0,:,:),hgt_high_ave)

uwnd_high = uwind_season(high_ind,:,:)
uwnd_high_ave = dim_avg_n_Wrap(uwnd_high,0)-dim_avg_n_Wrap(uwind_season,0)
 copy_VarMeta(uwind_season(0,:,:),uwnd_high_ave)

vwnd_high = vwind_season(high_ind,:,:)
vwnd_high_ave = dim_avg_n_Wrap(vwnd_high,0)-dim_avg_n_Wrap(vwind_season,0)
 copy_VarMeta(vwind_season(0,:,:),vwnd_high_ave)

out = addfile("LA-TP-.nc","c")
out->hgt_high_ave = hgt_high_ave
out->uwnd_high_ave = uwnd_high_ave
out->vwnd_high_ave = vwnd_high_ave
