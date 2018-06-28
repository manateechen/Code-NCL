load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

setfileoption("nc","Format","LargeFile")
out=addfile("AnaAveTemp.nc","c")

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
out->climate_pre=clipre

ensemble=clipre
ensemble=0.0

f1=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case01_T2=T2_new

f1=addfile("./case02/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case02_T2=T2_new

f1=addfile("./case03/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case03_T2=T2_new

f1=addfile("./case04/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case04_T2=T2_new

f1=addfile("./case05/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case05_T2=T2_new

f1=addfile("./case06/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case06_T2=T2_new

f1=addfile("./case07/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case07_T2=T2_new

f1=addfile("./case08/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case08_T2=T2_new

f1=addfile("./case09/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case09_T2=T2_new

f1=addfile("./case10/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case10_T2=T2_new

f1=addfile("./case11/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case11_T2=T2_new

f1=addfile("./case13/wrfout_d02_1998-06-16_00:00:00","r")
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
out->case13_T2=T2_new

f1=addfile("./case14/wrfout_d02_1998-06-16_00:00:00","r")
T2=dim_avg_n_Wrap(f1->T2,0)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
T2@lat2d = xlat
T2@lon2d = xlon
T2_new=rcm2rgrid_Wrap(xlat,xlon,T2-273.15,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+T2_new
printVarSummary(T2_new)
copy_VarMeta(T2_new,ensemble)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       T2_new(i,j)=T2_new@_FillValue
     end if
   end do
end do
out->case14_T2=T2_new

print("ERA")
f2=addfile("erauvt.nc","r")
eratmp=short2flt(f2->t2m)
ERATemp=eratmp-273.15
copy_VarMeta(eratmp,ERATemp)
Ts=dim_sum_n_Wrap(ERATemp(60:88,:,:),0)
printVarSummary(Ts)
latitude=f2->latitude
longitude=f2->longitude
T_new=linint2_Wrap(longitude,latitude(::-1),Ts(::-1,:),True,lon(ind_lon),lat(ind_lat),0)
printVarSummary(T_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       T_new(i,j)=T_new@_FillValue
     end if
   end do
end do
out->era_T2m=T_new

tmpen=ensemble
ensemble=ensemble/13.0
copy_VarMeta(clipre,ensemble)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       ensemble(i,j)=ensemble@_FillValue
     end if
   end do
end do
out->ensemble=ensemble










