load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

LINfile=addfile("./LIN/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
MORfile=addfile("./MOR/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
SBUfile=addfile("./SBU/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
THOfile=addfile("./THO/wrfout/wrfout_d03_2014-05-22_06:00:00","r")
SBU_NEWfile=addfile("./SBU_NEW01/wrfout/wrfout_d03_2014-05-22_06:00:00","r")

opts=True
opts@extrapolate=False
opts@field_type="ght"

npoints=500
z=fspan(0.1,20,npoints)
z@units="km"

nlines=9
;;;;;;;;;;;;;;;;;;;;;;;;; LIN  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=193
bb=229
cc=196
dd=252
ee=211
ff=270
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
aa=186
bb=229
cc=212
dd=265
ee=229
ff=277
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
;;;;;;;;;;;;;;;;;;;;;;;;; SBU  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=246
bb=229
cc=248
dd=237
ee=265
ff=258
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
aa=229
bb=252
cc=233
dd=262
ee=232
ff=259
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
;;;;;;;;;;;;;;;;;;;;;;;;; SBU_NEW  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=231
bb=233
cc=265
dd=248
ee=232
ff=276
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

;;;;;;;;;;;;;;;;;;;;;;;;; LIN stratriform ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=225
bb=239
cc=224
dd=262
ee=247
ff=238
tmp=wrf_user_getvar(LINfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_RH")

tmp=wrf_user_getvar(LINfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_QRAIN")

tmp=wrf_user_getvar(LINfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_QSNOW")

tmp=wrf_user_getvar(LINfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_QCLOUD")

tmp=wrf_user_getvar(LINfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_QVAPOR")

tmp=wrf_user_getvar(LINfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_QGRAUP")

tmp=wrf_user_getvar(LINfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_ICE")

tmp=wrf_user_getvar(LINfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(LINfile,tmp,"ght_agl",z,opts),0)
LIN_STRA_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("LIN_STRA_T")

LIN_STRA_TOTAL_ICE=LIN_STRA_QSNOW+LIN_STRA_QGRAUP+LIN_STRA_QICE
print("LIN_STRA_TOTAL_ICE")

LIN_STRA_TOTAL=LIN_STRA_QSNOW+LIN_STRA_QGRAUP+LIN_STRA_QICE+LIN_STRA_QRAIN+LIN_STRA_QCLOUD
print("LIN_STRA_TOTAL")

;;;;;;;;;;;;;;;;;;;;;;;;; MOR  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=265
bb=268
cc=265
dd=248
ee=226
ff=262
tmp=wrf_user_getvar(MORfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_RH")

tmp=wrf_user_getvar(MORfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_QRAIN")

tmp=wrf_user_getvar(MORfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_QSNOW")

tmp=wrf_user_getvar(MORfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_QCLOUD")

tmp=wrf_user_getvar(MORfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_QVAPOR")

tmp=wrf_user_getvar(MORfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_QGRAUP")

tmp=wrf_user_getvar(MORfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_ICE")

tmp=wrf_user_getvar(MORfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(MORfile,tmp,"ght_agl",z,opts),0)
MOR_STRA_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("MOR_STRA_T")

MOR_STRA_TOTAL_ICE=MOR_STRA_QSNOW+MOR_STRA_QGRAUP+MOR_STRA_QICE
print("MOR_STRA_TOTAL_ICE")

MOR_STRA_TOTAL=MOR_STRA_QSNOW+MOR_STRA_QGRAUP+MOR_STRA_QICE+MOR_STRA_QRAIN+MOR_STRA_QCLOUD
print("MOR_STRA_TOTAL")

;;;;;;;;;;;;;;;;;;;;;;;;; SBU  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=265
bb=232
cc=254
dd=216
ee=265
ff=216
tmp=wrf_user_getvar(SBUfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_STRA_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_STRA_RH")

tmp=wrf_user_getvar(SBUfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_STRA_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_STRA_QRAIN")

tmp=wrf_user_getvar(SBUfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_STRA_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_STRA_QSNOW")

tmp=wrf_user_getvar(SBUfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_STRA_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_STRA_QCLOUD")

tmp=wrf_user_getvar(SBUfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_STRA_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_STRA_QVAPOR")

tmp=wrf_user_getvar(SBUfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_STRA_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_STRA_ICE")

tmp=wrf_user_getvar(SBUfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBUfile,tmp,"ght_agl",z,opts),0)
SBU_STRA_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_STRA_T")

SBU_STRA_TOTAL_ICE=SBU_STRA_QSNOW+SBU_STRA_QICE
print("SBU_STRA_TOTAL_ICE")

SBU_STRA_TOTAL=SBU_STRA_QSNOW+SBU_STRA_QICE+SBU_STRA_QRAIN+SBU_STRA_QCLOUD
print("SBU_STRA_TOTAL")

;;;;;;;;;;;;;;;;;;;;;;;;; THO  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=233
bb=232
cc=247
dd=249
ee=229
ff=216
tmp=wrf_user_getvar(THOfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_RH")

tmp=wrf_user_getvar(THOfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_QRAIN")

tmp=wrf_user_getvar(THOfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_QSNOW")

tmp=wrf_user_getvar(THOfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_QCLOUD")

tmp=wrf_user_getvar(THOfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_QVAPOR")

tmp=wrf_user_getvar(THOfile,"QGRAUP",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_QGRAUP=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_QGRAUP")

tmp=wrf_user_getvar(THOfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_ICE")

tmp=wrf_user_getvar(THOfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(THOfile,tmp,"ght_agl",z,opts),0)
THO_STRA_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("THO_STRA_T")

THO_STRA_TOTAL_ICE=THO_STRA_QSNOW+THO_STRA_QGRAUP+THO_STRA_QICE
print("THO_STRA_TOTAL_ICE")

THO_STRA_TOTAL=THO_STRA_QSNOW+THO_STRA_QGRAUP+THO_STRA_QICE+THO_STRA_QRAIN+THO_STRA_QCLOUD
print("THO_STRA_TOTAL")

;;;;;;;;;;;;;;;;;;;;;;;;; SBU_NEW  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aa=247
bb=216
cc=257
dd=216
ee=247
ff=265
tmp=wrf_user_getvar(SBU_NEWfile,"rh",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_STRA_RH=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_STRA_RH")

tmp=wrf_user_getvar(SBU_NEWfile,"QRAIN",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_STRA_QRAIN=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_STRA_QRAIN")

tmp=wrf_user_getvar(SBU_NEWfile,"QSNOW",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_STRA_QSNOW=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_STRA_QSNOW")

tmp=wrf_user_getvar(SBU_NEWfile,"QCLOUD",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_STRA_QCLOUD=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_STRA_QCLOUD")

tmp=wrf_user_getvar(SBU_NEWfile,"QVAPOR",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_STRA_QVAPOR=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_STRA_QVAPOR")

tmp=wrf_user_getvar(SBU_NEWfile,"QICE",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_STRA_QICE=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_STRA_ICE")

tmp=wrf_user_getvar(SBU_NEWfile,"tc",-1)
tmp1=dim_avg_n_Wrap(wrf_user_vert_interp(SBU_NEWfile,tmp,"ght_agl",z,opts),0)
SBU_NEW_STRA_T=(tmp1(:,aa,bb)+tmp1(:,cc,dd)+tmp1(:,ee,ff))/3.0
print("SBU_NEW_STRA_T")

SBU_NEW_STRA_TOTAL_ICE=SBU_NEW_STRA_QSNOW+SBU_NEW_STRA_QICE
print("SBU_NEW_STRA_TOTAL_ICE")

SBU_NEW_STRA_TOTAL=SBU_NEW_STRA_QSNOW+SBU_NEW_STRA_QICE+SBU_NEW_STRA_QRAIN+SBU_NEW_STRA_QCLOUD
print("SBU_NEW_STRA_TOTAL")


;;;;;;;;;;;;;;;;;;;;;;;;; combine  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RH=new((/10,npoints/),"float")
RH(0,:)=LIN_RH
RH(1,:)=MOR_RH
RH(2,:)=SBU_RH
RH(3,:)=THO_RH
RH(4,:)=SBU_NEW_RH
RH(5,:)=LIN_STRA_RH
RH(6,:)=MOR_STRA_RH
RH(7,:)=SBU_STRA_RH
RH(8,:)=THO_STRA_RH
RH(9,:)=SBU_NEW_STRA_RH

QRAIN=new((/10,npoints/),"float")
QRAIN(0,:)=LIN_QRAIN
QRAIN(1,:)=MOR_QRAIN
QRAIN(2,:)=SBU_QRAIN
QRAIN(3,:)=THO_QRAIN
QRAIN(4,:)=SBU_NEW_QRAIN
QRAIN(5,:)=LIN_STRA_QRAIN
QRAIN(6,:)=MOR_STRA_QRAIN
QRAIN(7,:)=SBU_STRA_QRAIN
QRAIN(8,:)=THO_STRA_QRAIN
QRAIN(9,:)=SBU_NEW_STRA_QRAIN
QRAIN=QRAIN*1E5

QSNOW=new((/10,npoints/),"float")
QSNOW(0,:)=LIN_QSNOW
QSNOW(1,:)=MOR_QSNOW
QSNOW(2,:)=SBU_QSNOW
QSNOW(3,:)=THO_QSNOW
QSNOW(4,:)=SBU_NEW_QSNOW
QSNOW(5,:)=LIN_STRA_QSNOW
QSNOW(6,:)=MOR_STRA_QSNOW
QSNOW(7,:)=SBU_STRA_QSNOW
QSNOW(8,:)=THO_STRA_QSNOW
QSNOW(9,:)=SBU_NEW_STRA_QSNOW
QSNOW=QSNOW*1E5

QCLOUD=new((/10,npoints/),"float")
QCLOUD(0,:)=LIN_QCLOUD
QCLOUD(1,:)=MOR_QCLOUD
QCLOUD(2,:)=SBU_QCLOUD
QCLOUD(3,:)=THO_QCLOUD
QCLOUD(4,:)=SBU_NEW_QCLOUD
QCLOUD(5,:)=LIN_STRA_QCLOUD
QCLOUD(6,:)=MOR_STRA_QCLOUD
QCLOUD(7,:)=SBU_STRA_QCLOUD
QCLOUD(8,:)=THO_STRA_QCLOUD
QCLOUD(9,:)=SBU_NEW_STRA_QCLOUD
QCLOUD=QCLOUD*1E5

QVAPOR=new((/10,npoints/),"float")
QVAPOR(0,:)=LIN_QVAPOR
QVAPOR(1,:)=MOR_QVAPOR
QVAPOR(2,:)=SBU_QVAPOR
QVAPOR(3,:)=THO_QVAPOR
QVAPOR(4,:)=SBU_NEW_QVAPOR
QVAPOR(5,:)=LIN_STRA_QVAPOR
QVAPOR(6,:)=MOR_STRA_QVAPOR
QVAPOR(7,:)=SBU_STRA_QVAPOR
QVAPOR(8,:)=THO_STRA_QVAPOR
QVAPOR(9,:)=SBU_NEW_STRA_QVAPOR
QVAPOR=QVAPOR*1E5

T=new((/10,npoints/),"float")
T(0,:)=LIN_T
T(1,:)=MOR_T
T(2,:)=SBU_T
T(3,:)=THO_T
T(4,:)=SBU_NEW_T
T(5,:)=LIN_STRA_T
T(6,:)=MOR_STRA_T
T(7,:)=SBU_STRA_T
T(8,:)=THO_STRA_T
T(9,:)=SBU_NEW_STRA_T

QICE=new((/10,npoints/),"float")
QICE(0,:)=LIN_QICE
QICE(1,:)=MOR_QICE
QICE(2,:)=SBU_QICE
QICE(3,:)=THO_QICE
QICE(4,:)=SBU_NEW_QICE
QICE(5,:)=LIN_STRA_QICE
QICE(6,:)=MOR_STRA_QICE
QICE(7,:)=SBU_STRA_QICE
QICE(8,:)=THO_STRA_QICE
QICE(9,:)=SBU_NEW_STRA_QICE
QICE=QICE*1E5

QGRAUP=new((/6,npoints/),"float")
QGRAUP(0,:)=LIN_QGRAUP
QGRAUP(1,:)=MOR_QGRAUP
QGRAUP(2,:)=THO_QGRAUP
QGRAUP(3,:)=LIN_STRA_QGRAUP
QGRAUP(4,:)=MOR_STRA_QGRAUP
QGRAUP(5,:)=THO_STRA_QGRAUP
QGRAUP=QGRAUP*1E5

QTOTAL_ICE=new((/10,npoints/),"float")
QTOTAL_ICE(0,:)=LIN_TOTAL_ICE
QTOTAL_ICE(1,:)=MOR_TOTAL_ICE
QTOTAL_ICE(2,:)=SBU_TOTAL_ICE
QTOTAL_ICE(3,:)=THO_TOTAL_ICE
QTOTAL_ICE(4,:)=SBU_NEW_TOTAL_ICE
QTOTAL_ICE(5,:)=LIN_STRA_TOTAL_ICE
QTOTAL_ICE(6,:)=MOR_STRA_TOTAL_ICE
QTOTAL_ICE(7,:)=SBU_STRA_TOTAL_ICE
QTOTAL_ICE(8,:)=THO_STRA_TOTAL_ICE
QTOTAL_ICE(9,:)=SBU_NEW_STRA_TOTAL_ICE
QTOTAL_ICE=QTOTAL_ICE*1E5

QTOTAL=new((/10,npoints/),"float")
QTOTAL(0,:)=LIN_TOTAL
QTOTAL(1,:)=MOR_TOTAL
QTOTAL(2,:)=SBU_TOTAL
QTOTAL(3,:)=THO_TOTAL
QTOTAL(4,:)=SBU_NEW_TOTAL
QTOTAL(5,:)=LIN_STRA_TOTAL
QTOTAL(6,:)=MOR_STRA_TOTAL
QTOTAL(7,:)=SBU_STRA_TOTAL
QTOTAL(8,:)=THO_STRA_TOTAL
QTOTAL(9,:)=SBU_NEW_STRA_TOTAL
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
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns	 = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="Relative Humidity (%)"
wks=gsn_open_wks("eps" ,"RH")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,RH,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("RH")

;; T
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="Temperature (Celsius)"
wks=gsn_open_wks("eps" ,"T")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,T,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("T")

;; SNOW
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="SNOW "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"SNOW")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QSNOW,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("SNOW")

;; RAIN
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="RAIN "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"RAIN")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QRAIN,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("RAIN")

;; CLOUD
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="CLOUD "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"CLOUD")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QCLOUD,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("CLOUD")

;; VAPOR
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="VAPOR "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"VAPOR")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QVAPOR,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("VAPOR")

;; ICE
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="ICE "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"ICE")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QICE,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("ICE")

;; GRAUP
res @xyLineColors=(/2,34,255,2,34,255/)
res@xyDashPatterns       = (/0,0,0,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4/)
res@tiXAxisString="GRAUP "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"GRAUP")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QGRAUP,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("GRAUP")

;; TOTAL ICE
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="TOTAL ICE "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"TOTAL_ICE")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QTOTAL_ICE,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("QTOTAL_ICE")

;; TOTAL
res@xyLineColors=(/2,34,98,255,226,2,34,98,255,226/)
res@xyDashPatterns       = (/0,0,0,0,0,1,1,1,1,1/)
res@xyLineThicknesses=(/4,4,4,4,4,4,4,4,4,4/)
res@tiXAxisString="TOTAL "+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"TOTAL")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,QTOTAL,z,res)
delete(res@xyLineColors)
delete(res@xyDashPatterns)
delete(res@xyLineThicknesses)
print("QTOTAL")

print("ALL COMPLETE")
