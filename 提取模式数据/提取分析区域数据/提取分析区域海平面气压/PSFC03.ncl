load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

setfileoption("nc","Format","LargeFile")
out=addfile("AnaAvePSFC.nc","w")

f = addfile("chinamap25.nc","r")
lat=f->lat
lon=f->lon
ind_lat=ind(lat.ge.18.and.lat.le.33)
ind_lon=ind(lon.ge.106.and.lon.le.123)
map=f->map(ind_lat,ind_lon)
lat_ana=lat(ind_lat)
lon_ana=lon(ind_lon)
ny=dimsizes(ind_lat)
nx=dimsizes(ind_lon)
out->lat=lat_ana
out->lon=lon_ana

f1=addfile("./case03/wrfout_d02_1998-06-16_00:00:00","r")
slp=wrf_user_getvar(f1,"slp",-1)
T2=dim_avg_n_Wrap(slp,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(T2_new)
out->case03_slp=T2_new