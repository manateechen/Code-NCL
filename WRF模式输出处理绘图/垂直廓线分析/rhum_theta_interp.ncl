load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

ncepfile=addfile("rhum.1998.nc","r")
ncepfile2=addfile("air.1998.nc","r")
tmp1=short2flt(ncepfile->rhum)
nceplat=ncepfile->lat
nceplon=ncepfile->lon
nceplev=ncepfile->level
rhum=tmp1(664:692,:,:,:)
copy_VarMeta(tmp1(664:692,:,:,:),rhum)
tmp1=short2flt(ncepfile2->air)
air=tmp1(664:692,:,:,:)
copy_VarMeta(tmp1(664:692,:,:,:),air)

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

rhum_1=new((/29,17,ny,nx/),"float")
rhum_2=new((/29,20,ny,nx/),"float")
air_1=new((/29,17,ny,nx/),"float")
air_2=new((/29,20,ny,nx/),"float")
rhum_1=linint2_Wrap(nceplon,nceplat(::-1),rhum(:,:,::-1,:),True,lon(ind_lon),lat(ind_lat),0)
air_1=linint2_Wrap(nceplon,nceplat(::-1),air(:,:,::-1,:),True,lon(ind_lon),lat(ind_lat),0)
z_out=(/1000.0,975.0,950.0,925.0,900.0,875.0,850.0,825.0,800.0,775.0,750.0,700.0,650.0,600.0,550.0,500.0,450.0,400.0,350.0,300.0/)
rhum_2=int2p_n_Wrap(nceplev,rhum_1,z_out,2,1)
air_2=int2p_n_Wrap(nceplev,air_1,z_out,2,1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       rhum_2(:,:,i,j)=rhum_2@_FillValue
       air_2(:,:,i,j)=air_2@_FillValue
     end if
   end do
end do
tmp_rhum=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(rhum_2,3),2),0)
tmp_air=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(air_2,3),2),0)
es=6.112*exp((17.67*(tmp_air-273.16))/(tmp_air-29.66))
q=tmp_rhum*(0.62197*es/(z_out-0.378*es))/100.0*1000.0
theta=tmp_air*(1000.0/z_out)^0.286
setfileoption("nc","Format","LargeFile")
out=addfile("sph_theta.nc","c")
out->q=q
out->theta=theta