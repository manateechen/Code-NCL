load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

setfileoption("nc","Format","LargeFile")
out=addfile("CLOUD.nc","w")

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

f1=addfile("./case13/wrfout_d02_1998-06-16_00:00:00","r")
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
hgt=wrf_user_getvar(f1,"HGT",0)
height=wrf_user_getvar(f1,"height",0)
z=height-conform(height,hgt,(/1,2/))
z_out=(/1,50,100,150,200,250,300,350,400,450,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,15500,16000,16500,17000,17500,18000,18500,19000,19500,20000/)

ICE=wrf_user_getvar(f1,"QCLOUD",-1)
ICE_z=new((/29,50,312,234/),"float")
do j=0,28
do i=0,49
ICE_z(j,i,:,:)=wrf_user_intrp3d(ICE(j,:,:,:),z,"h",z_out(i),0.,False)
end do
end do
ICE_z=ICE_z*1E5
copy_VarMeta(ICE(:,0:49,:,:),ICE_z)
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
out->QCLOUD_case13=ICE_Mean
print("13")
