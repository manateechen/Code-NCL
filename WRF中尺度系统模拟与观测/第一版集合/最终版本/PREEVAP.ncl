load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wrffile1=addfile("./wrfout/wrfout_d03_2014-05-22_06:00:00","r")

RH=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"rh",-1),0)
QRAIN=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QRAIN",-1),0)
QSNOW=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QSNOW",-1),0)
QCLOUD=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QCLOUD",-1),0)
QVAPOR=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QVAPOR",-1),0)
QGRAUP=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QGRAUP",-1),0)
QICE=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QICE",-1),0)
T=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"tc",-1),0)

LAT=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"XLAT",-1),0)
LON=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"XLONG",-1),0)

bb=277
aa=229

print(RH(:,aa,bb))
print(QRAIN(:,aa,bb))
print(QSNOW(:,aa,bb))
print(QCLOUD(:,aa,bb))
print(QVAPOR(:,aa,bb))
print(QGRAUP(:,aa,bb))
print(QICE(:,aa,bb))
print(T(:,aa,bb))
