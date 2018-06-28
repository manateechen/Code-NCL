load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

lat=23.7167
lon=113.0830

out_t2=new((/7,145/),"float")
out_rain=new((/7,145/),"float")

filelist=systemfunc("ls ./MOR/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist, "r")
XLAT=wrf_user_getvar(wrffiles,"XLAT",0)
XLON=wrf_user_getvar(wrffiles,"XLONG",0)
T2=rcm2points_Wrap(XLAT,XLON,wrf_user_getvar(wrffiles,"T2",-1),lat,lon,0)
RAINC=wrf_user_getvar(wrffiles,"RAINC",-1)
RAINNC=wrf_user_getvar(wrffiles,"RAINNC",-1)
RAIN=rcm2points_Wrap(XLAT,XLON,RAINC+RAINNC,lat,lon,0)
rain=new((/145,1/),"float")
do ii=1,143
    rain(ii,:)=RAIN(ii+1,:)-RAIN(ii,:)
end do
rain(0,:)=0
out_t2(0,:)=T2(:,0)-273.15
out_rain(0,:)=rain(:,0)

filelist=systemfunc("ls ./MOR_H/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist, "r")
XLAT=wrf_user_getvar(wrffiles,"XLAT",0)
XLON=wrf_user_getvar(wrffiles,"XLONG",0)
T2=rcm2points_Wrap(XLAT,XLON,wrf_user_getvar(wrffiles,"T2",-1),lat,lon,0)
RAINC=wrf_user_getvar(wrffiles,"RAINC",-1)
RAINNC=wrf_user_getvar(wrffiles,"RAINNC",-1)
RAIN=rcm2points_Wrap(XLAT,XLON,RAINC+RAINNC,lat,lon,0)
rain=new((/145,1/),"float")
do ii=1,143
    rain(ii,:)=RAIN(ii+1,:)-RAIN(ii,:)
end do
rain(0,:)=0
out_t2(1,:)=T2(:,0)-273.15
out_rain(1,:)=rain(:,0)

filelist=systemfunc("ls ./WDM6/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist, "r")
XLAT=wrf_user_getvar(wrffiles,"XLAT",0)
XLON=wrf_user_getvar(wrffiles,"XLONG",0)
T2=rcm2points_Wrap(XLAT,XLON,wrf_user_getvar(wrffiles,"T2",-1),lat,lon,0)
RAINC=wrf_user_getvar(wrffiles,"RAINC",-1)
RAINNC=wrf_user_getvar(wrffiles,"RAINNC",-1)
RAIN=rcm2points_Wrap(XLAT,XLON,RAINC+RAINNC,lat,lon,0)
rain=new((/145,1/),"float")
do ii=1,143
    rain(ii,:)=RAIN(ii+1,:)-RAIN(ii,:)
end do
rain(0,:)=0
out_t2(2,:)=T2(:,0)-273.15
out_rain(2,:)=rain(:,0)

filelist=systemfunc("ls ./WDM6_H/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist, "r")
XLAT=wrf_user_getvar(wrffiles,"XLAT",0)
XLON=wrf_user_getvar(wrffiles,"XLONG",0)
T2=rcm2points_Wrap(XLAT,XLON,wrf_user_getvar(wrffiles,"T2",-1),lat,lon,0)
RAINC=wrf_user_getvar(wrffiles,"RAINC",-1)
RAINNC=wrf_user_getvar(wrffiles,"RAINNC",-1)
RAIN=rcm2points_Wrap(XLAT,XLON,RAINC+RAINNC,lat,lon,0)
rain=new((/145,1/),"float")
do ii=1,143
    rain(ii,:)=RAIN(ii+1,:)-RAIN(ii,:)
end do
rain(0,:)=0
out_t2(3,:)=T2(:,0)-273.15
out_rain(3,:)=rain(:,0)

filelist=systemfunc("ls ./WSM6/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist, "r")
XLAT=wrf_user_getvar(wrffiles,"XLAT",0)
XLON=wrf_user_getvar(wrffiles,"XLONG",0)
T2=rcm2points_Wrap(XLAT,XLON,wrf_user_getvar(wrffiles,"T2",-1),lat,lon,0)
RAINC=wrf_user_getvar(wrffiles,"RAINC",-1)
RAINNC=wrf_user_getvar(wrffiles,"RAINNC",-1)
RAIN=rcm2points_Wrap(XLAT,XLON,RAINC+RAINNC,lat,lon,0)
rain=new((/145,1/),"float")
do ii=1,143
    rain(ii,:)=RAIN(ii+1,:)-RAIN(ii,:)
end do
rain(0,:)=0
out_t2(4,:)=T2(:,0)-273.15
out_rain(4,:)=rain(:,0)

filelist=systemfunc("ls ./LIN/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist, "r")
XLAT=wrf_user_getvar(wrffiles,"XLAT",0)
XLON=wrf_user_getvar(wrffiles,"XLONG",0)
T2=rcm2points_Wrap(XLAT,XLON,wrf_user_getvar(wrffiles,"T2",-1),lat,lon,0)
RAINC=wrf_user_getvar(wrffiles,"RAINC",-1)
RAINNC=wrf_user_getvar(wrffiles,"RAINNC",-1)
RAIN=rcm2points_Wrap(XLAT,XLON,RAINC+RAINNC,lat,lon,0)
rain=new((/145,1/),"float")
do ii=1,143
    rain(ii,:)=RAIN(ii+1,:)-RAIN(ii,:)
end do
rain(0,:)=0
out_t2(5,:)=T2(:,0)-273.15
out_rain(5,:)=rain(:,0)

filelist=systemfunc("ls ./THO/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist, "r")
XLAT=wrf_user_getvar(wrffiles,"XLAT",0)
XLON=wrf_user_getvar(wrffiles,"XLONG",0)
T2=rcm2points_Wrap(XLAT,XLON,wrf_user_getvar(wrffiles,"T2",-1),lat,lon,0)
RAINC=wrf_user_getvar(wrffiles,"RAINC",-1)
RAINNC=wrf_user_getvar(wrffiles,"RAINNC",-1)
RAIN=rcm2points_Wrap(XLAT,XLON,RAINC+RAINNC,lat,lon,0)
rain=new((/145,1/),"float")
do ii=1,143
    rain(ii,:)=RAIN(ii+1,:)-RAIN(ii,:)
end do
rain(0,:)=0
out_t2(6,:)=T2(:,0)-273.15
out_rain(6,:)=rain(:,0)

out=addfile("time.nc","c")
out->t2=out_t2
out->rain=out_rain