load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

setfileoption("nc","Format","LargeFile")
out=addfile("AnaTotPre.nc","c")

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

f0=addfile("climate_pre.nc","r")
clipre=dim_sum_n_Wrap(f0->pre(15:21,ind_lat,ind_lon),0)
printVarSummary(clipre)
out->climate_pre=clipre

ensemble=clipre
ensemble=0.0

f1=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
ensemble=ensemble+pre_new
printVarSummary(pre_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case01_pre=pre_new

f1=addfile("./case02/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case02_pre=pre_new

f1=addfile("./case03/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case03_pre=pre_new


f1=addfile("./case04/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
tmp=rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case04_pre=pre_new

f1=addfile("./case05/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case05_pre=pre_new

f1=addfile("./case06/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
tmp=rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case06_pre=pre_new

f1=addfile("./case07/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case07_pre=pre_new


f1=addfile("./case08/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
tmp=rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case08_pre=pre_new


f1=addfile("./case09/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case09_pre=pre_new


f1=addfile("./case10/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case10_pre=pre_new


f1=addfile("./case11/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case11_pre=pre_new



f1=addfile("./case13/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case13_pre=pre_new


f1=addfile("./case14/wrfout_d02_1998-06-16_00:00:00","r")
rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc
pre=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),pre)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre@lat2d = xlat
pre@lon2d = xlon
pre_new=rcm2rgrid_Wrap(xlat,xlon,pre,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new)
ensemble=ensemble+pre_new
copy_VarMeta(pre_new,ensemble)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->case14_pre=pre_new

print("ERA")
f2=addfile("erapre.nc","r")
eratmp=short2flt(f2->tp)
PRE=eratmp*1000
copy_VarMeta(eratmp,PRE)
pres=dim_sum_n_Wrap(PRE(29:43,:,:),0)
printVarSummary(pres)
latitude=f2->latitude
longitude=f2->longitude
pre_new=linint2_Wrap(longitude,latitude(::-1),pres(::-1,:),True,lon(ind_lon),lat(ind_lat),0)
printVarSummary(pre_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_new(i,j)=pre_new@_FillValue
     end if
   end do
end do
out->era_pre=pre_new

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










