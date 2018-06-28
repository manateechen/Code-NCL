load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

setfileoption("nc","Format","LargeFile")
out=addfile("AnaAve500HGT.nc","c")

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

f0=addfile("climate_tm.nc","r")
clipre=dim_avg_n_Wrap(f0->tm(15:21,ind_lat,ind_lon),0)
printVarSummary(clipre)
;out->climate_pre=clipre

ensemble=clipre
ensemble=0.0

f1=addfile("./case01/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case01_HGT=T2_new

f1=addfile("./case02/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(T2_new)
out->case02_HGT=T2_new

f1=addfile("./case03/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case03_HGT=T2_new

f1=addfile("./case04/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case04_HGT=T2_new

f1=addfile("./case05/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case05_HGT=T2_new

f1=addfile("./case06/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case06_HGT=T2_new

f1=addfile("./case07/wrfpress_d02_1998-06-16_00:00:00","r")
T2=dim_avg_n_Wrap(f1->T2,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2-273.15,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       T2_new(i,j)=T2_new@_FillValue
     end if
   end do
end do
out->case07_HGT=T2_new

f1=addfile("./case08/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case08_HGT=T2_new

f1=addfile("./case09/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case09_HGT=T2_new

f1=addfile("./case10/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case10_HGT=T2_new

f1=addfile("./case11/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case11_HGT=T2_new

f1=addfile("./case13/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
out->case13_HGT=T2_new

f1=addfile("./case14/wrfpress_d02_1998-06-16_00:00:00","r")
HGT=wrf_user_getvar(f1,"GHT_PL",-1)
T2=dim_avg_n_Wrap(HGT,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
copy_VarMeta(T2_new,ensemble)
out->case14_HGT=T2_new

tmpen=ensemble
ensemble=ensemble/13.0
copy_VarMeta(clipre,ensemble)
out->ensemble=ensemble
