load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

setfileoption("nc","Format","LargeFile")
out=addfile("AnaPBLH.nc","c")

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

f1=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case01_PBLH=PBLH_out

f1=addfile("./case02/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case02_PBLH=PBLH_out

f1=addfile("./case03/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case03_PBLH=PBLH_out

f1=addfile("./case04/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case04_PBLH=PBLH_out

f1=addfile("./case05/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case05_PBLH=PBLH_out

f1=addfile("./case06/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case06_PBLH=PBLH_out

f1=addfile("./case07/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case07_PBLH=PBLH_out

f1=addfile("./case08/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case08_PBLH=PBLH_out

f1=addfile("./case09/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case09_PBLH=PBLH_out

f1=addfile("./case10/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case10_PBLH=PBLH_out

f1=addfile("./case11/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case11_PBLH=PBLH_out

f1=addfile("./case13/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case13_PBLH=PBLH_out

f1=addfile("./case14/wrfout_d02_1998-06-16_00:00:00","r")
PBLH=f1->PBLH
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
PBLH_new=rcm2rgrid_Wrap(xlat,xlon,PBLH,lat(ind_lat),lon(ind_lon), 1)
ensemble=PBLH_new+ensemble
printVarSummary(PBLH_new)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       PBLH_new(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(PBLH_new,2),1)
printVarSummary(PBLH_out)
out->case14_PBLH=PBLH_out

do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       ensemble(:,i,j)=PBLH_new@_FillValue
     end if
   end do
end do
ensemble=ensemble/13.0
PBLH_out=dim_avg_n_Wrap(dim_avg_n_Wrap(ensemble,2),1)
printVarSummary(PBLH_out)
out->ensemble_PBLH=PBLH_out