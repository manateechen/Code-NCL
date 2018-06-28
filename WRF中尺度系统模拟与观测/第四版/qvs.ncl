load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

lat1s=150
lat2s=300
lon1s=150
lon2s=390

opts=True
opts@extrapolate=False
opts@field_type="ght"

z=fspan(1.0,7.0,40)
z@units="km"

filelist=systemfunc("ls ./MOR/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist(96:120), "r")
DBZ=wrf_user_vert_interp(wrffiles,wrf_user_getvar(wrffiles,"dbz",-1),"ght_agl",z,opts)
GRAUP_VT=wrf_user_vert_interp(wrffiles,wrf_user_getvar(wrffiles,"GRAUP_VT",-1),"ght_agl",z,opts)
QV=wrf_user_vert_interp(wrffiles,wrf_user_getvar(wrffiles,"QVAPOR",-1),"ght_agl",z,opts)

file2=addfile("qvs.nc", "r")
qvs=file2->qvs

QVS=wrf_user_vert_interp(wrffiles,qvs,"ght_agl",z,opts)

qvqvs=QV/QVS

idbz=DBZ(:,:,lat1s:lat2s,lon1s:lon2s)
tmp_total=idbz
tmp_total=0

do ii=0,39
  tmp_total(:,ii,:,:)=where(idbz(:,0,:,:).ge.20,111.1,0)
end do

GRAUP_VT_tmp=GRAUP_VT(:,:,lat1s:lat2s,lon1s:lon2s)
QVS_tmp=qvqvs(:,:,lat1s:lat2s,lon1s:lon2s)

graupel_vt_total=where(tmp_total.ge.20,GRAUP_VT_tmp,0)
graupel_vt_total!0="time"
graupel_vt_total!1="level"
graupel_vt_total&level=z

qvs_total=where(tmp_total.ge.20,QVS_tmp,0)
qvs_total!0="time"
qvs_total!1="level"
qvs_total&level=z

setfileoption("nc","Format","LargeFile")
outfile=addfile("QVS_VT.nc","c")
outfile->vt=graupel_vt_total
outfile->qvqvs=qvs_total
