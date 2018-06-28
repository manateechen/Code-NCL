load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

setfileoption("nc","Format","LargeFile")
out=addfile("SPH.nc","w")

f=addfile("chinamap25.nc","r")
lat=f->lat
lon=f->lon
ind_lat=ind(lat.ge.18.and.lat.le.33)
ind_lon=ind(lon.ge.106.and.lon.le.123)
map=f->map(ind_lat,ind_lon)
lat_ana=lat(ind_lat)
lon_ana=lon(ind_lon)
ny=dimsizes(ind_lat)
nx=dimsizes(ind_lon)

f1=addfile("./case05/wrfout_d02_1998-06-16_00:00:00","r")
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
z=wrf_user_getvar(f1,"pressure",-1)
z_out=(/300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,775.0,800.0,825.0,850.0,875.0,900.0,925.0,950.0,975.0,1000.0/)

ICE=wrf_user_getvar(f1,"QVAPOR",-1)
ICE_z=new((/29,20,312,234/),"float")
do j=0,28
do i=0,19
ICE_z(j,i,:,:)=wrf_user_intrp3d(ICE(j,:,:,:),z(j,:,:,:),"h",z_out(i),0.,False)
end do
end do
ICE_z=ICE_z/(1.0+ICE_z)*1000.0
copy_VarMeta(ICE(:,0:19,:,:),ICE_z)
ICE_z_h=rcm2rgrid_Wrap(xlat,xlon,ICE_z,lat(ind_lat),lon(ind_lon), 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       ICE_z_h(:,:,i,j)=ICE_z_h@_FillValue
     end if
   end do
end do
tmp=dim_avg_n_Wrap(dim_avg_n_Wrap(ICE_z_h,3),2)
ICE_Mean=dim_avg_n_Wrap(tmp,0)
out->SPH_case05=ICE_Mean
print("5")
