load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

infile = addfile(root+"hgt.2017.nc", "r")
Cfile = addfile(root+"hgt.day.1981-2010.ltm.nc", "r")

hgt_day = infile->hgt(181:242,11,:,:)
hgt_clim = Cfile->hgt(181:242,11,:,:)

lat = infile->lat
lon = infile->lon

day = hgt_day / 10.0
copy_VarMeta(hgt_day, day)

clim = hgt_clim/10.0
copy_VarMeta(hgt_clim, clim)

lat_idx = ind(lat.ge.0.and.lat.le.50)
lon_idx = ind(lon.ge.30.and.lon.le.150)

lat_array = day(0,lat_idx,lon_idx)
lon_array = day(0,lat_idx,lon_idx)

lat_array = conform(lat_array, lat(lat_idx), 0)
lon_array = conform(lon_array, lon(lon_idx), 1)

;day = where(day.ge.1666, day, day@_FillValue)
;clim = where(clim.ge.1666, clim, clim@_FillValue)

day_lat = new(62, "float")
day_lon = new(62, "float")
clim_lat = new(62, "float")
clim_lon = new(62, "float")


do ii = 0, dimsizes(day(:,0,0))-1
tmpLat = where(day(ii,lat_idx,lon_idx).ge.1684, lat_array, lat_array@_FillValue)
tmpLon = where(day(ii,lat_idx,lon_idx).ge.1684, lon_array, lon_array@_FillValue)

CtmpLat = where(clim(ii,lat_idx,lon_idx).ge.1684, lat_array, lat_array@_FillValue)
CtmpLon = where(clim(ii,lat_idx,lon_idx).ge.1684, lon_array, lon_array@_FillValue)

oned_tmp_lat = ndtooned(tmpLat)
oned_tmp_lon = ndtooned(tmpLon)
oned_Ctmp_lat = ndtooned(CtmpLat)
oned_Ctmp_lon = ndtooned(CtmpLon)
oned_tmp_lat@_FillValue = lat_array@_FillValue
oned_tmp_lon@_FillValue = lat_array@_FillValue
oned_Ctmp_lat@_FillValue = lat_array@_FillValue
oned_Ctmp_lon@_FillValue = lat_array@_FillValue

day_lat(ii) = dim_avg_n_Wrap(ndtooned(tmpLat),0)
day_lon(ii) = dim_max_n_Wrap(ndtooned(tmpLon),0)

clim_lat(ii) = dim_avg_n_Wrap(ndtooned(CtmpLat),0)
clim_lon(ii) = dim_max_n_Wrap(ndtooned(CtmpLon),0)

delete(tmpLat)
delete(tmpLon)
delete(CtmpLat)
delete(CtmpLon)
delete(oned_tmp_lat)
delete(oned_tmp_lon)
delete(oned_Ctmp_lat)
delete(oned_Ctmp_lon)
end do

asciiwrite("./daylat.txt", day_lat)
asciiwrite("./daylon.txt", day_lon)
asciiwrite("./climlat.txt", clim_lat)
asciiwrite("./climlon.txt", clim_lon)