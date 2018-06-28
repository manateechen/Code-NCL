load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

f = addfile("climate_pre.nc","r")
lat=f->lat
lon=f->lon
ind_lat=ind(lat.ge.27.and.lat.le.33)
ind_lon=ind(lon.ge.106.and.lon.le.120)
tmp=f->pre
climate_pre=tmp(15:21,ind_lat,ind_lon)
ny=dimsizes(ind_lat)
nx=dimsizes(ind_lon)
delete(tmp)

f1=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")
rainnc1 = wrf_user_getvar(f1,"RAINNC",-1)
irainnc1 = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc1 = wrf_user_getvar(f1,"RAINC",-1)
irainc1 = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
pre1=tmp(0:6,:,:)
do i=0,6
    pre1(i,:,:)=tmp(i*4+4,:,:)-tmp(i*4,:,:)
end do
copy_VarMeta(rainnc1(0:6,:,:),pre1)
printVarSummary(pre1)
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)
pre1@lat2d = xlat
pre1@lon2d = xlon
pre_new1=new((/7,ny,nx/),"float")
pre_new1=rcm2rgrid_Wrap(xlat,xlon,pre1,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new1)

f2=addfile("./case02/wrfout_d02_1998-06-16_00:00:00","r")
rainnc2 = wrf_user_getvar(f2,"RAINNC",-1)
irainnc2 = wrf_user_getvar(f2,"I_RAINNC",-1)
rainc2 = wrf_user_getvar(f2,"RAINC",-1)
irainc2 = wrf_user_getvar(f2,"I_RAINC",-1)
tmp=(irainnc2+irainc2)*100.0+rainnc2+rainc2
pre2=tmp(0:6,:,:)
do i=0,6
    pre2(i,:,:)=tmp(i*4+4,:,:)-tmp(i*4,:,:)
end do
copy_VarMeta(rainnc2(0:6,:,:),pre2)
printVarSummary(pre2)
xlat = wrf_user_getvar(f2,"XLAT",0)
xlon = wrf_user_getvar(f2,"XLONG",0)
pre2@lat2d = xlat
pre2@lon2d = xlon
pre_new2=new((/7,ny,nx/),"float")
pre_new2=rcm2rgrid_Wrap(xlat,xlon,pre2,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new2)

f3=addfile("./case03/wrfout_d02_1998-06-16_00:00:00","r")
rainnc3 = wrf_user_getvar(f3,"RAINNC",-1)
irainnc3 = wrf_user_getvar(f3,"I_RAINNC",-1)
rainc3 = wrf_user_getvar(f3,"RAINC",-1)
irainc3 = wrf_user_getvar(f3,"I_RAINC",-1)
tmp=(irainnc3+irainc3)*100.0+rainnc3+rainc3
pre3=tmp(0:6,:,:)
do i=0,6
    pre3(i,:,:)=tmp(i*4+4,:,:)-tmp(i*4,:,:)
end do
copy_VarMeta(rainnc3(0:6,:,:),pre3)
printVarSummary(pre3)
xlat = wrf_user_getvar(f3,"XLAT",0)
xlon = wrf_user_getvar(f3,"XLONG",0)
pre3@lat2d = xlat
pre3@lon2d = xlon
pre_new3=new((/7,ny,nx/),"float")
pre_new3=rcm2rgrid_Wrap(xlat,xlon,pre3,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new3)

f4=addfile("./case04/wrfout_d02_1998-06-16_00:00:00","r")
rainnc4 = wrf_user_getvar(f4,"RAINNC",-1)
rainc4 = wrf_user_getvar(f4,"RAINC",-1)
tmp=rainnc4+rainc4
pre4=tmp(0:6,:,:)
do i=0,6
    pre4(i,:,:)=tmp(i*4+4,:,:)-tmp(i*4,:,:)
end do
copy_VarMeta(rainnc4(0:6,:,:),pre4)
printVarSummary(pre4)
xlat = wrf_user_getvar(f4,"XLAT",0)
xlon = wrf_user_getvar(f4,"XLONG",0)
pre4@lat2d = xlat
pre4@lon2d = xlon
pre_new4=new((/7,ny,nx/),"float")
pre_new4=rcm2rgrid_Wrap(xlat,xlon,pre4,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new4)

f5=addfile("./case05/wrfout_d02_1998-06-16_00:00:00","r")
rainnc5 = wrf_user_getvar(f5,"RAINNC",-1)
irainnc5 = wrf_user_getvar(f5,"I_RAINNC",-1)
rainc5 = wrf_user_getvar(f5,"RAINC",-1)
irainc5 = wrf_user_getvar(f5,"I_RAINC",-1)
tmp=(irainnc5+irainc5)*100.0+rainnc5+rainc5
pre5=tmp(0:6,:,:)
do i=0,6
    pre5(i,:,:)=tmp(i*4+4,:,:)-tmp(i*4,:,:)
end do
copy_VarMeta(rainnc5(0:6,:,:),pre5)
printVarSummary(pre5)
xlat = wrf_user_getvar(f5,"XLAT",0)
xlon = wrf_user_getvar(f5,"XLONG",0)
pre5@lat2d = xlat
pre5@lon2d = xlon
pre_new5=new((/7,ny,nx/),"float")
pre_new5=rcm2rgrid_Wrap(xlat,xlon,pre5,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new5)

f6=addfile("./case06/wrfout_d02_1998-06-16_00:00:00","r")
rainnc6 = wrf_user_getvar(f6,"RAINNC",-1)
irainnc6 = wrf_user_getvar(f6,"I_RAINNC",-1)
rainc6 = wrf_user_getvar(f6,"RAINC",-1)
irainc6 = wrf_user_getvar(f6,"I_RAINC",-1)
tmp=(irainnc6+irainc6)*100.0+rainnc6+rainc6
pre6=tmp(0:6,:,:)
do i=0,6
    pre6(i,:,:)=tmp(i*4+4,:,:)-tmp(i*4,:,:)
end do
copy_VarMeta(rainnc6(0:6,:,:),pre6)
printVarSummary(pre6)
xlat = wrf_user_getvar(f6,"XLAT",0)
xlon = wrf_user_getvar(f6,"XLONG",0)
pre6@lat2d = xlat
pre6@lon2d = xlon
pre_new6=new((/7,ny,nx/),"float")
pre_new6=rcm2rgrid_Wrap(xlat,xlon,pre6,lat(ind_lat),lon(ind_lon), 1)
printVarSummary(pre_new6)
