load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

FERfile=addfile("./FER/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
LINfile=addfile("./LIN/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
WDMfile=addfile("./WDM/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
WSMfile=addfile("./WSM/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
MORfile=addfile("./MOR/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
SBUfile=addfile("./SBU/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
NSSLfile=addfile("./NSSL/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
THOfile=addfile("./THO/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
SBU_NEWfile=addfile("./SBU_NEW01/wrfout/wrfout_d03_2014-05-22_06:00:00","r")

opts=True
opts@extrapolate=False
opts@field_type="ght"

npoints=500
z=fspan(0.1,20,npoints)
z@units="km"

nlines=9
;;;;;;;;;;;;;;;;;;;;;;;;; FER  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=247
bb=271
cc=229
dd=232
ee=247
ff=271
tmp=wrf_user_getvar(FERfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(FERfile,tmp,"ght_agl",z,opts),0)
FER_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("FER_RH")

tmp=wrf_user_getvar(FERfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(FERfile,tmp,"ght_agl",z,opts),0)
FER_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("FER_QRAIN")

tmp=wrf_user_getvar(FERfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(FERfile,tmp,"ght_agl",z,opts),0)
FER_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("FER_QSNOW")

tmp=wrf_user_getvar(FERfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(FERfile,tmp,"ght_agl",z,opts),0)
FER_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("FER_QCLOUD")

tmp=wrf_user_getvar(FERfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(FERfile,tmp,"ght_agl",z,opts),0)
FER_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("FER_QVAPOR")

tmp=wrf_user_getvar(FERfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(FERfile,tmp,"ght_agl",z,opts),0)
FER_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("FER_T")

FER_TOTAL_ICE=FER_QSNOW
print("FER_TOTAL_ICE")

FER_TOTAL=FER_QRAIN+FER_QSNOW+FER_QCLOUD
print("FER_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; LIN  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=225
bb=239
cc=224
dd=262
ee=247
ff=238
tmp=wrf_user_getvar(LINfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_RH")

tmp=wrf_user_getvar(LINfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_QRAIN")

tmp=wrf_user_getvar(LINfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_QSNOW")

tmp=wrf_user_getvar(LINfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_QCLOUD")

tmp=wrf_user_getvar(LINfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_QVAPOR")

tmp=wrf_user_getvar(LINfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_QGRAUP")

tmp=wrf_user_getvar(LINfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_ICE")

tmp=wrf_user_getvar(LINfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_T")

LIN_TOTAL_ICE=LIN_QSNOW+LIN_QGRAUP+LIN_QICE
print("LIN_TOTAL_ICE")

LIN_TOTAL=LIN_QSNOW+LIN_QGRAUP+LIN_QICE+LIN_QRAIN+LIN_QCLOUD
print("LIN_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; MOR  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=265
bb=268
cc=265
dd=248
ee=226
ff=262
tmp=wrf_user_getvar(MORfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_RH")

tmp=wrf_user_getvar(MORfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_QRAIN")

tmp=wrf_user_getvar(MORfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_QSNOW")

tmp=wrf_user_getvar(MORfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_QCLOUD")

tmp=wrf_user_getvar(MORfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_QVAPOR")

tmp=wrf_user_getvar(MORfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_QGRAUP")

tmp=wrf_user_getvar(MORfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_ICE")

tmp=wrf_user_getvar(MORfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_T")

MOR_TOTAL_ICE=MOR_QSNOW+MOR_QGRAUP+MOR_QICE
print("MOR_TOTAL_ICE")

MOR_TOTAL=MOR_QSNOW+MOR_QGRAUP+MOR_QICE+MOR_QRAIN+MOR_QCLOUD
print("MOR_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; NSSL  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=247
bb=265
cc=247
dd=232
ee=265
ff=265
tmp=wrf_user_getvar(NSSLfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_RH")

tmp=wrf_user_getvar(NSSLfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_QRAIN")

tmp=wrf_user_getvar(NSSLfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_QSNOW")

tmp=wrf_user_getvar(NSSLfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_QCLOUD")

tmp=wrf_user_getvar(NSSLfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_QVAPOR")

tmp=wrf_user_getvar(NSSLfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_QGRAUP")

tmp=wrf_user_getvar(NSSLfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_ICE")

tmp=wrf_user_getvar(NSSLfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(NSSLfile,tmp,"ght_agl",z,opts),0)
NSSL_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("NSSL_T")

NSSL_TOTAL_ICE=NSSL_QSNOW+NSSL_QGRAUP+NSSL_QICE
print("NSSL_TOTAL_ICE")

NSSL_TOTAL=NSSL_QSNOW+NSSL_QGRAUP+NSSL_QICE+NSSL_QRAIN+NSSL_QCLOUD
print("NSSL_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; SBU  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=265
bb=232
cc=254
dd=216
ee=265
ff=216
tmp=wrf_user_getvar(SBUfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_RH")

tmp=wrf_user_getvar(SBUfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_QRAIN")

tmp=wrf_user_getvar(SBUfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_QSNOW")

tmp=wrf_user_getvar(SBUfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_QCLOUD")

tmp=wrf_user_getvar(SBUfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_QVAPOR")

tmp=wrf_user_getvar(SBUfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_ICE")

tmp=wrf_user_getvar(SBUfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_T")

SBU_TOTAL_ICE=SBU_QSNOW+SBU_QICE
print("SBU_TOTAL_ICE")

SBU_TOTAL=SBU_QSNOW+SBU_QICE+SBU_QRAIN+SBU_QCLOUD
print("SBU_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; THO  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=233
bb=232
cc=247
dd=249
ee=229
ff=216
tmp=wrf_user_getvar(THOfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_RH")

tmp=wrf_user_getvar(THOfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_QRAIN")

tmp=wrf_user_getvar(THOfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_QSNOW")

tmp=wrf_user_getvar(THOfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_QCLOUD")

tmp=wrf_user_getvar(THOfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_QVAPOR")

tmp=wrf_user_getvar(THOfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_QGRAUP")

tmp=wrf_user_getvar(THOfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_ICE")

tmp=wrf_user_getvar(THOfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_T")

THO_TOTAL_ICE=THO_QSNOW+THO_QGRAUP+THO_QICE
print("THO_TOTAL_ICE")

THO_TOTAL=THO_QSNOW+THO_QGRAUP+THO_QICE+THO_QRAIN+THO_QCLOUD
print("THO_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; WDM  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=233
bb=249
cc=214
dd=265
ee=229
ff=281
tmp=wrf_user_getvar(WDMfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_RH")

tmp=wrf_user_getvar(WDMfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_QRAIN")

tmp=wrf_user_getvar(WDMfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_QSNOW")

tmp=wrf_user_getvar(WDMfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_QCLOUD")

tmp=wrf_user_getvar(WDMfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_QVAPOR")

tmp=wrf_user_getvar(WDMfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_QGRAUP")

tmp=wrf_user_getvar(WDMfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_ICE")

tmp=wrf_user_getvar(WDMfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WDMfile,tmp,"ght_agl",z,opts),0)
WDM_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WDM_T")

WDM_TOTAL_ICE=WDM_QSNOW+WDM_QGRAUP+WDM_QICE
print("WDM_TOTAL_ICE")

WDM_TOTAL=WDM_QSNOW+WDM_QGRAUP+WDM_QICE+WDM_QRAIN+WDM_QCLOUD
print("WDM_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; WSM  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=211
bb=249
cc=229
dd=265
ee=201
ff=232
tmp=wrf_user_getvar(WSMfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_RH")

tmp=wrf_user_getvar(WSMfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_QRAIN")

tmp=wrf_user_getvar(WSMfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_QSNOW")

tmp=wrf_user_getvar(WSMfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_QCLOUD")

tmp=wrf_user_getvar(WSMfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_QVAPOR")

tmp=wrf_user_getvar(WSMfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_QGRAUP")

tmp=wrf_user_getvar(WSMfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_ICE")

tmp=wrf_user_getvar(WSMfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(WSMfile,tmp,"ght_agl",z,opts),0)
WSM_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("WSM_T")

WSM_TOTAL_ICE=WSM_QSNOW+WSM_QGRAUP+WSM_QICE
print("WSM_TOTAL_ICE")

WSM_TOTAL=WSM_QSNOW+WSM_QGRAUP+WSM_QICE+WSM_QRAIN+WSM_QCLOUD
print("WSM_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; SBU_NEW  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=247
bb=216
cc=257
dd=216
ee=247
ff=265
tmp=wrf_user_getvar(SBU_NEWfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_RH")

tmp=wrf_user_getvar(SBU_NEWfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_QRAIN")

tmp=wrf_user_getvar(SBU_NEWfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_QSNOW")

tmp=wrf_user_getvar(SBU_NEWfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_QCLOUD")

tmp=wrf_user_getvar(SBU_NEWfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_QVAPOR")

tmp=wrf_user_getvar(SBU_NEWfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_ICE")

tmp=wrf_user_getvar(SBU_NEWfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_T")

SBU_NEW_TOTAL_ICE=SBU_NEW_QSNOW+SBU_NEW_QICE
print("SBU_NEW_TOTAL_ICE")

SBU_NEW_TOTAL=SBU_NEW_QSNOW+SBU_NEW_QICE+SBU_NEW_QRAIN+SBU_NEW_QCLOUD
print("SBU_NEW_TOTAL")
;;;;;;;;;;;;;;;;;;;;;;;;; combine  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RH=new((/9,npoints/),"float")
RH(0,:)=FER_RH
RH(1,:)=LIN_RH
RH(2,:)=MOR_RH
RH(3,:)=NSSL_RH
RH(4,:)=SBU_RH
RH(5,:)=THO_RH
RH(6,:)=WDM_RH
RH(7,:)=WSM_RH
RH(8,:)=SBU_NEW_RH

QRAIN=new((/9,npoints/),"float")
QRAIN(0,:)=FER_QRAIN
QRAIN(1,:)=LIN_QRAIN
QRAIN(2,:)=MOR_QRAIN
QRAIN(3,:)=NSSL_QRAIN
QRAIN(4,:)=SBU_QRAIN
QRAIN(5,:)=THO_QRAIN
QRAIN(6,:)=WDM_QRAIN
QRAIN(7,:)=WSM_QRAIN
QRAIN(8,:)=SBU_NEW_QRAIN
QRAIN=QRAIN*1E5

QSNOW=new((/9,npoints/),"float")
QSNOW(0,:)=FER_QSNOW
QSNOW(1,:)=LIN_QSNOW
QSNOW(2,:)=MOR_QSNOW
QSNOW(3,:)=NSSL_QSNOW
QSNOW(4,:)=SBU_QSNOW
QSNOW(5,:)=THO_QSNOW
QSNOW(6,:)=WDM_QSNOW
QSNOW(7,:)=WSM_QSNOW
QSNOW(8,:)=SBU_NEW_QSNOW
QSNOW=QSNOW*1E5

QCLOUD=new((/9,npoints/),"float")
QCLOUD(0,:)=FER_QCLOUD
QCLOUD(1,:)=LIN_QCLOUD
QCLOUD(2,:)=MOR_QCLOUD
QCLOUD(3,:)=NSSL_QCLOUD
QCLOUD(4,:)=SBU_QCLOUD
QCLOUD(5,:)=THO_QCLOUD
QCLOUD(6,:)=WDM_QCLOUD
QCLOUD(7,:)=WSM_QCLOUD
QCLOUD(8,:)=SBU_NEW_QCLOUD
QCLOUD=QCLOUD*1E5

QVAPOR=new((/9,npoints/),"float")
QVAPOR(0,:)=FER_QVAPOR
QVAPOR(1,:)=LIN_QVAPOR
QVAPOR(2,:)=MOR_QVAPOR
QVAPOR(3,:)=NSSL_QVAPOR
QVAPOR(4,:)=SBU_QVAPOR
QVAPOR(5,:)=THO_QVAPOR
QVAPOR(6,:)=WDM_QVAPOR
QVAPOR(7,:)=WSM_QVAPOR
QVAPOR(8,:)=SBU_NEW_QVAPOR
QVAPOR=QVAPOR*1E5

T=new((/9,npoints/),"float")
T(0,:)=FER_T
T(1,:)=LIN_T
T(2,:)=MOR_T
T(3,:)=NSSL_T
T(4,:)=SBU_T
T(5,:)=THO_T
T(6,:)=WDM_T
T(7,:)=WSM_T
T(8,:)=SBU_NEW_T

QICE=new((/8,npoints/),"float")
QICE(0,:)=LIN_QICE
QICE(1,:)=MOR_QICE
QICE(2,:)=NSSL_QICE
QICE(3,:)=SBU_QICE
QICE(4,:)=THO_QICE
QICE(5,:)=WDM_QICE
QICE(6,:)=WSM_QICE
QICE(7,:)=SBU_NEW_QICE
QICE=QICE*1E5

QGRAUP=new((/6,npoints/),"float")
QGRAUP(0,:)=LIN_QGRAUP
QGRAUP(1,:)=MOR_QGRAUP
QGRAUP(2,:)=NSSL_QGRAUP
QGRAUP(3,:)=THO_QGRAUP
QGRAUP(4,:)=WDM_QGRAUP
QGRAUP(5,:)=WSM_QGRAUP
QGRAUP=QGRAUP*1E5

QTOTAL_ICE=new((/9,npoints/),"float")
QTOTAL_ICE(0,:)=FER_TOTAL_ICE
QTOTAL_ICE(1,:)=LIN_TOTAL_ICE
QTOTAL_ICE(2,:)=MOR_TOTAL_ICE
QTOTAL_ICE(3,:)=NSSL_TOTAL_ICE
QTOTAL_ICE(4,:)=SBU_TOTAL_ICE
QTOTAL_ICE(5,:)=THO_TOTAL_ICE
QTOTAL_ICE(6,:)=WDM_TOTAL_ICE
QTOTAL_ICE(7,:)=WSM_TOTAL_ICE
QTOTAL_ICE(8,:)=SBU_NEW_TOTAL_ICE
QTOTAL_ICE=QTOTAL_ICE*1E5

QTOTAL=new((/9,npoints/),"float")
QTOTAL(0,:)=FER_TOTAL
QTOTAL(1,:)=LIN_TOTAL
QTOTAL(2,:)=MOR_TOTAL
QTOTAL(3,:)=NSSL_TOTAL
QTOTAL(4,:)=SBU_TOTAL
QTOTAL(5,:)=THO_TOTAL
QTOTAL(6,:)=WDM_TOTAL
QTOTAL(7,:)=WSM_TOTAL
QTOTAL(8,:)=SBU_NEW_TOTAL
QTOTAL=QTOTAL*1E5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  draw pic ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
res=True
res@gsnMaximize=True
res@vpWidthF=0.40
res@vpHeightF=0.7
res@xyLineThicknessF=3.0 
res@tiYAxisString="km"
res@trYMinF  = 0
res@trYMaxF  =  20.0

;; RH
res@xyLineColors=(/1,2,34,66,98,255,162,194,226/) 
res@xyDashPatterns	 = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="Relative Humidity (%)"
wks=gsn_open_wks("eps" ,"RH")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,RH,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("RH")

;; T
res @xyLineColors=(/1,2,34,66,98,255,162,194,226/) 
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="Temperature (Celsius)"
wks=gsn_open_wks("eps" ,"T")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,T,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("T")

;; SNOW
res @xyLineColors=(/1,2,34,66,98,255,162,194,226/) 
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="SNOW "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"SNOW")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QSNOW,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("SNOW")

;; RAIN
res @xyLineColors=(/1,2,34,66,98,255,162,194,226/) 
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="RAIN "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"RAIN")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QRAIN,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("RAIN")

;; CLOUD
res @xyLineColors=(/1,2,34,66,98,255,162,194,226/) 
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="CLOUD "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"CLOUD")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QCLOUD,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("CLOUD")

;; VAPOR
res @xyLineColors=(/1,2,34,66,98,255,162,194,226/)
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="VAPOR "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"VAPOR")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QVAPOR,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("VAPOR")

;; ICE
res @xyLineColors=(/2,34,66,98,255,162,194,226/)
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0/)
res@tiXAxisString="ICE "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"ICE")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QICE,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("ICE")

;; GRAUP
res @xyLineColors=(/2,34,66,255,162,194/)
res@xyDashPatterns       = (/0,0,0,0,0,0/)
res@tiXAxisString="GRAUP "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"GRAUP")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QGRAUP,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("GRAUP")

;; TOTAL ICE
res @xyLineColors=(/1,2,34,66,98,255,162,194,226/) 
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="TOTAL ICE "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"TOTAL_ICE")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QTOTAL_ICE,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("QTOTAL_ICE")

;; TOTAL
res @xyLineColors=(/1,2,34,66,98,255,162,194,226/) 
res@xyDashPatterns       = (/0,0,0,0,0,0,0,0,0/)
res@tiXAxisString="TOTAL "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"TOTAL")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QTOTAL,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
print("QTOTAL")

print("ALL COMPLETE")
