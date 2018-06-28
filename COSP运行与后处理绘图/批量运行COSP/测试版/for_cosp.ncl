load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

filepath=getenv("FILEPATH")
time=stringtoint(getenv("TIMESTEP"))
npoint=stringtoint(getenv("NPOINT"))
nlevel=stringtoint(getenv("NLEVEL"))
HYDRO=9

wrfout_file=addfile(filepath,"r")
out=addfile("test.nc","c")

XLAT=wrf_user_getvar(wrfout_file,"XLAT",time)
lat=ndtooned(XLAT)
lat!0="point"
out->lat=lat
print("-----------LAT COMPLETE-----------")
delete(XLAT)
delete(lat)

XLON=wrf_user_getvar(wrfout_file,"XLONG",time)
lon=ndtooned(XLON)
lon=where(lon.lt.0,lon+360,lon)
lon!0="point"
out->lon=lon
print("-----------LON COMPLETE-----------")
delete(XLON)
delete(lon)

LANDMASK=wrf_user_getvar(wrfout_file,"LANDMASK",time)
landmask=ndtooned(LANDMASK)
landmask!0="point"
out->landmask=landmask
print("-----------LANDMASK COMPLETE-----------")
delete(LANDMASK)
delete(landmask)

HGT=wrf_user_getvar(wrfout_file,"HGT",time)
orography=ndtooned(HGT)
orography!0="point"
out->orography=orography
print("-----------OROGRAPHY COMPLETE-----------")
delete(HGT)
delete(orography)

PSFC=wrf_user_getvar(wrfout_file,"PSFC",time)
psfc=ndtooned(PSFC)
psfc!0="point"
out->psfc=psfc
print("-----------PSFC COMPLETE-----------")
delete(PSFC)
delete(psfc)

T=wrf_user_getvar(wrfout_file,"tk",time)
T_abs=reshape(T,(/nlevel,npoint/))
T_abs!0="level"
T_abs!1="point"
out->T_abs=T_abs
print("-----------T_ABS COMPLETE-----------")
delete(T)
delete(T_abs)

QVAPOR=wrf_user_getvar(wrfout_file,"QVAPOR",time)
qv=reshape(QVAPOR,(/nlevel,npoint/))
qv=qv/(1.0+qv)
qv!0="level"
qv!1="point"
out->qv=qv
print("-----------QV COMPLETE-----------")
delete(QVAPOR)
delete(qv)

RH=wrf_user_getvar(wrfout_file,"rh",time)
rh=reshape(RH,(/nlevel,npoint/))
rh!0="level"
rh!1="point"
out->rh=rh
print("-----------RH COMPLETE-----------")
delete(RH)
delete(rh)

QCLOUD=wrf_user_getvar(wrfout_file,"QCLOUD",time)
mr_lsliq=reshape(QCLOUD,(/nlevel,npoint/))
mr_lsliq!0="level"
mr_lsliq!1="point"
out->mr_lsliq=mr_lsliq
print("-----------MR_LSLIQ COMPLETE-----------")
delete(QCLOUD)
delete(mr_lsliq)

QICE=wrf_user_getvar(wrfout_file,"QICE",time)
mr_lsice=reshape(QICE,(/nlevel,npoint/))
mr_lsice!0="level"
mr_lsice!1="point"
out->mr_lsice=mr_lsice
print("-----------MR_LSICE COMPLETE-----------")
delete(QICE)
delete(mr_lsice)

QC_CU=wrf_user_getvar(wrfout_file,"QC_CU",time)
mr_ccliq=reshape(QC_CU,(/nlevel,npoint/))
mr_ccliq!0="level"
mr_ccliq!1="point"
out->mr_ccliq=mr_ccliq
print("-----------MR_CCLIQ COMPLETE-----------")
delete(QC_CU)
delete(mr_ccliq)

QI_CU=wrf_user_getvar(wrfout_file,"QI_CU",time)
mr_ccice=reshape(QI_CU,(/nlevel,npoint/))
mr_ccice!0="level"
mr_ccice!1="point"
out->mr_ccice=mr_ccice
print("-----------MR_CCICE COMPLETE-----------")
delete(QI_CU)
delete(mr_ccice)

CLDFRA=wrf_user_getvar(wrfout_file,"CLDFRA",time)
tca=reshape(CLDFRA,(/nlevel,npoint/))
tca!0="level"
tca!1="point"
out->tca=tca
print("-----------TCA COMPLETE-----------")
delete(CLDFRA)

CF_CU_FOR_COSP=wrf_user_getvar(wrfout_file,"CF_CU_FOR_COSP",time)
cca=reshape(CF_CU_FOR_COSP,(/nlevel,npoint/))
cca!0="level"
cca!1="point"
out->cca=cca
print("-----------CCA COMPLETE-----------")
delete(CF_CU_FOR_COSP)

TAUCLDI=wrf_user_getvar(wrfout_file,"TAUCLDI",time)
TAUCLDC=wrf_user_getvar(wrfout_file,"TAUCLDC",time)
TAUCLD=TAUCLDI+TAUCLDC
delete(TAUCLDI)
delete(TAUCLDC)
taucld=reshape(TAUCLD,(/nlevel,npoint/))
convective_stratus_diff=cca-(tca-cca)
dtau_s=cca
dtau_s=0
dtau_s=where(convective_stratus_diff.le.0,taucld,0)
dtau_s!0="level"
dtau_s!1="point"
dtau_c=cca
dtau_c=0
dtau_c=where(convective_stratus_diff.gt.0,taucld,0)
dtau_c!0="level"
dtau_c!1="point"
out->dtau_s=dtau_s
out->dtau_c=dtau_c
print("-----------DTAU_S & DTAU_C COMPLETE-----------")
delete(tca)
delete(cca)
delete(TAUCLD)
delete(convective_stratus_diff)
delete(dtau_s)
delete(dtau_c)

TSK=wrf_user_getvar(wrfout_file,"TSK",time)
skt=reshape(TSK,(/npoint/))
skt!0="point"
out->skt=skt
print("-----------SKT COMPLETE-----------")
delete(skt)
delete(TSK)

COSZEN=wrf_user_getvar(wrfout_file,"COSZEN",time)
coszen=reshape(COSZEN,(/npoint/))
sunlit=coszen
sunlit=0
sunlit=where(coszen.ge.0,1,0)
sunlit!0="point"
out->sunlit=sunlit
print("-----------SUNLIT COMPLETE-----------")
delete(COSZEN)
delete(coszen)
delete(sunlit)

EMISS=wrf_user_getvar(wrfout_file,"EMISS",time)
emsfc_lw=reshape(EMISS,(/npoint/))
emsfc_lw!0="point"
out->emsfc_lw=emsfc_lw
print("-----------EMSFC_LW COMPLETE-----------")
delete(EMISS)
delete(emsfc_lw)

HEIGHT=wrf_user_getvar(wrfout_file,"height",time)
height_half=reshape(HEIGHT,(/nlevel,npoint/))
height_half!0="level"
height_half!1="point"
out->height_half=height_half
print("-----------HEIGHT_HALF COMPLETE-----------")
delete(HEIGHT)
delete(height_half)

PH=wrf_user_getvar(wrfout_file,"PH",time)
PHB=wrf_user_getvar(wrfout_file,"PHB",time)
HEIGHT=(PH+PHB)/9.81
height=reshape(HEIGHT(1:,:,:),(/nlevel,npoint/))
height!0="level"
height!1="point"
out->height=height
print("-----------HEIGHT COMPLETE-----------")
delete(PH)
delete(PHB)
delete(HEIGHT)
delete(height)

P=wrf_user_getvar(wrfout_file,"p",time)
phalf=reshape(P,(/nlevel,npoint/))
phalf!0="level"
phalf!1="point"
pfull=phalf
pfull(:nlevel-2,:)=0.5*(phalf(:nlevel-2,:)+phalf(1:nlevel-1,:))
pfull(nlevel-1,:)=wrfout_file->P_TOP(time)
pfull!0="level"
pfull!1="point"
out->phalf=phalf
out->pfull=pfull
print("-----------PHALF & PFULL COMPLETE-----------")
delete(P)
delete(phalf)
delete(pfull)

Reff=new((/HYDRO,nlevel,npoint/),"float")
RE_C_FOR_COSP=wrf_user_getvar(wrfout_file,"RE_C_FOR_COSP",time)
Reff(0,:,:)=reshape(RE_C_FOR_COSP,(/nlevel,npoint/))
delete(RE_C_FOR_COSP)
RE_I_FOR_COSP=wrf_user_getvar(wrfout_file,"RE_I_FOR_COSP",time)
Reff(1,:,:)=reshape(RE_I_FOR_COSP,(/nlevel,npoint/))
delete(RE_I_FOR_COSP)
RE_R_FOR_COSP=wrf_user_getvar(wrfout_file,"RE_R_FOR_COSP",time)
Reff(2,:,:)=reshape(RE_R_FOR_COSP,(/nlevel,npoint/))
delete(RE_R_FOR_COSP)
RE_S_FOR_COSP=wrf_user_getvar(wrfout_file,"RE_S_FOR_COSP",time)
Reff(3,:,:)=reshape(RE_S_FOR_COSP,(/nlevel,npoint/))
delete(RE_S_FOR_COSP)
RE_C_CV=wrf_user_getvar(wrfout_file,"RE_C_CV",time)
Reff(4,:,:)=reshape(RE_C_CV,(/nlevel,npoint/))
delete(RE_C_CV)
RE_I_CV=wrf_user_getvar(wrfout_file,"RE_I_CV",time)
Reff(5,:,:)=reshape(RE_I_CV,(/nlevel,npoint/))
delete(RE_I_CV)
Reff(6,:,:)=0
Reff(7,:,:)=0
RE_G_FOR_COSP=wrf_user_getvar(wrfout_file,"RE_G_FOR_COSP",time)
Reff(8,:,:)=reshape(RE_G_FOR_COSP,(/nlevel,npoint/))
delete(RE_G_FOR_COSP)
Reff!0="hydro"
Reff!1="level"
Reff!2="point"
out->Reff=Reff
print("-----------Reff COMPLETE-----------")
delete(Reff)
