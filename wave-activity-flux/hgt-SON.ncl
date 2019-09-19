load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"



; SON
season = "SON"
idx_A = 8
idx_B = 9
idx_C = 10

system("rm -rf " + season + ".nc")

yearstart = 1979
yearend = 1994
nyear = yearend - yearstart + 1

ttestval = 2.120

mylev = 200

snow = asciiread("./sst.txt",(/nyear/),"float")

hgtfile = addfile("../ncfile/ncep2nc/hgt.mon.mean.nc","r")

hgts = short2flt(hgtfile->hgt)


lat_wind = hgtfile->lat
lon_wind = hgtfile->lon
year=calendar_decode2(hgtfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))
level_wind = hgtfile->level
lev_wind = ind(level_wind.eq.mylev)

hgt = hgts(year_idx,lev_wind,:,:)

hgt_season = (hgt(idx_A::12,:,:) + hgt(idx_B::12,:,:) + hgt(idx_C::12,:,:)) / 3.0 

rc_hgt = regCoef_n(snow, hgt_season, 0, 0)

tval_hgt = reshape(abs(rc_hgt@tval),(/dimsizes(rc_hgt(:,0)),dimsizes(rc_hgt(0,:))/))

copy_VarMeta(hgt(0,:,:),rc_hgt)

copy_VarMeta(hgt(0,:,:),tval_hgt)

out=addfile(season+".nc","c")
out->hgt_clim = dim_avg_n_Wrap(hgt_season, 0)
out->hgt_anom = rc_hgt
out->mylev = mylev

