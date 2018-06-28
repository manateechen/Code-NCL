load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"                                                      
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

lat1s=150
lat2s=300
lon1s=150
lon2s=390

opts=True
opts@extrapolate=False
opts@field_type="ght"

z=fspan(0.1,18.0,30)
z@units="km"

filelist=systemfunc("ls ./wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist(96:120), "r")

GRAUP_MELT=wrf_user_vert_interp(wrffiles,wrf_user_getvar(wrffiles,"GRAUP_MELT",-1),"ght_agl",z,opts)
graup_melt=GRAUP_MELT(:,:,lat1s:lat2s,lon1s:lon2s)

GRAUP_N0=wrf_user_vert_interp(wrffiles,wrf_user_getvar(wrffiles,"GRAUP_N0",-1),"ght_agl",z,opts)
graup_n0=GRAUP_N0(:,:,lat1s:lat2s,lon1s:lon2s)

GRAUP_LAMB=wrf_user_vert_interp(wrffiles,wrf_user_getvar(wrffiles,"GRAUP_LAMB",-1),"ght_agl",z,opts)
graup_lamb=GRAUP_LAMB(:,:,lat1s:lat2s,lon1s:lon2s)

DBZ=wrf_user_vert_interp(wrffiles,wrf_user_getvar(wrffiles,"dbz",-1),"ght_agl",z,opts)
dbz=DBZ(:,:,lat1s:lat2s,lon1s:lon2s)

graup_melt=where(dbz.gt.20, graup_melt, graup_melt@_FillValue)
graup_n0=where(dbz.gt.20, graup_n0, graup_n0@_FillValue)
graup_lamb=where(dbz.gt.20, graup_lamb, graup_lamb@_FillValue)

out=addfile("graup.nc", "c")
out->graup_melt=graup_melt
out->graup_n0=graup_n0
out->graup_lamb=graup_lamb

