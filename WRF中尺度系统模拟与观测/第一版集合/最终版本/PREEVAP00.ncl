load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wrffile1=addfile("./SBU/wrfout_d03_2014-05-22_06:00:00","r")
wrffile2=addfile("./MOR/wrfout_d03_2014-05-22_06:00:00","r")
wrffile3=addfile("./SBU_VT/wrfout_d03_2014-05-22_06:00:00","r")
wrffile4=addfile("./SBU_NEW/wrfout_d03_2014-05-22_06:00:00","r")
wrffile5=addfile("./SBU_NEW01/wrfout_d03_2014-05-22_06:00:00","r")

PREEVAP_SBU=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"PREEVAP",-1),0)
PREEVAP_MOR=dim_avg_n_Wrap(wrf_user_getvar(wrffile2,"PREEVAP",-1),0)
PREEVAP_SBU_VT=dim_avg_n_Wrap(wrf_user_getvar(wrffile3,"PREEVAP",-1),0)
PREEVAP_SBU_NEW=dim_avg_n_Wrap(wrf_user_getvar(wrffile4,"PREEVAP",-1),0)
PREEVAP_SBU_NEW01=dim_avg_n_Wrap(wrf_user_getvar(wrffile5,"PREEVAP",-1),0)

RH_SBU=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"rh",-1),0)
RH_MOR=dim_avg_n_Wrap(wrf_user_getvar(wrffile2,"rh",-1),0)
RH_SBU_VT=dim_avg_n_Wrap(wrf_user_getvar(wrffile3,"rh",-1),0)
RH_SBU_NEW=dim_avg_n_Wrap(wrf_user_getvar(wrffile4,"rh",-1),0)
RH_SBU_NEW01=dim_avg_n_Wrap(wrf_user_getvar(wrffile5,"rh",-1),0)

VT_SBU=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"VT_RAIN",-1),0)
VT_MOR=dim_avg_n_Wrap(wrf_user_getvar(wrffile2,"VT_RAIN",-1),0)
VT_SBU_VT=dim_avg_n_Wrap(wrf_user_getvar(wrffile3,"VT_RAIN",-1),0)
VT_SBU_NEW=dim_avg_n_Wrap(wrf_user_getvar(wrffile4,"VT_RAIN",-1),0)
VT_SBU_NEW01=dim_avg_n_Wrap(wrf_user_getvar(wrffile5,"VT_RAIN",-1),0)

QRAIN_SBU=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QRAIN",-1),0)
QRAIN_MOR=dim_avg_n_Wrap(wrf_user_getvar(wrffile2,"QRAIN",-1),0)
QRAIN_SBU_VT=dim_avg_n_Wrap(wrf_user_getvar(wrffile3,"QRAIN",-1),0)
QRAIN_SBU_NEW=dim_avg_n_Wrap(wrf_user_getvar(wrffile4,"QRAIN",-1),0)
QRAIN_SBU_NEW01=dim_avg_n_Wrap(wrf_user_getvar(wrffile5,"QRAIN",-1),0)

QSNOW_SBU=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"QSNOW",-1),0)
QSNOW_MOR=dim_avg_n_Wrap(wrf_user_getvar(wrffile2,"QSNOW",-1),0)
QSNOW_SBU_VT=dim_avg_n_Wrap(wrf_user_getvar(wrffile3,"QSNOW",-1),0)
QSNOW_SBU_NEW=dim_avg_n_Wrap(wrf_user_getvar(wrffile4,"QSNOW",-1),0)
QSNOW_SBU_NEW01=dim_avg_n_Wrap(wrf_user_getvar(wrffile5,"QSNOW",-1),0)

T_SBU=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"tc",-1),0)
T_MOR=dim_avg_n_Wrap(wrf_user_getvar(wrffile2,"tc",-1),0)
T_SBU_VT=dim_avg_n_Wrap(wrf_user_getvar(wrffile3,"tc",-1),0)
T_SBU_NEW=dim_avg_n_Wrap(wrf_user_getvar(wrffile4,"tc",-1),0)
T_SBU_NEW01=dim_avg_n_Wrap(wrf_user_getvar(wrffile5,"tc",-1),0)

LAT=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"XLAT",-1),0)
LON=dim_avg_n_Wrap(wrf_user_getvar(wrffile1,"XLONG",-1),0)

aa=251
bb=230
cc=181
dd=225
ee=247
ff=249
gg=243
hh=240
ii=233
jj=233 ;234

print(PREEVAP_SBU(:,aa,bb))
print(PREEVAP_MOR(:,cc,dd))
print(PREEVAP_SBU_VT(:,ee,ff))
print(PREEVAP_SBU_NEW(:,gg,hh))
print(PREEVAP_SBU_NEW01(:,ii,jj))

print(RH_SBU(:,aa,bb))
print(RH_MOR(:,cc,dd))
print(RH_SBU_VT(:,ee,ff))
print(RH_SBU_NEW(:,gg,hh))
print(RH_SBU_NEW01(:,ii,jj))

print(VT_SBU(:,aa,bb))
print(VT_MOR(:,cc,dd))
print(VT_SBU_VT(:,ee,ff))
print(VT_SBU_NEW(:,gg,hh))
print(VT_SBU_NEW01(:,ii,jj))

print(QRAIN_SBU(:,aa,bb))
print(QRAIN_MOR(:,cc,dd))
print(QRAIN_SBU_VT(:,ee,ff))
print(QRAIN_SBU_NEW(:,gg,hh))
print(QRAIN_SBU_NEW01(:,ii,jj))

print(QSNOW_SBU(:,aa,bb))
print(QSNOW_MOR(:,cc,dd))
print(QSNOW_SBU_VT(:,ee,ff))
print(QSNOW_SBU_NEW(:,gg,hh))
print(QSNOW_SBU_NEW01(:,ii,jj))

print(T_SBU(:,aa,bb))
print(T_MOR(:,cc,dd))
print(T_SBU_VT(:,ee,ff))
print(T_SBU_NEW(:,gg,hh))
print(T_SBU_NEW01(:,ii,jj))

print(LAT(aa,bb))
print(LON(aa,bb))
print(LAT(cc,dd))
print(LON(cc,dd))
print(LAT(ee,ff))
print(LON(ee,ff))
print(LAT(gg,hh))
print(LON(gg,hh))
print(LAT(ii,jj))
print(LON(ii,jj))

