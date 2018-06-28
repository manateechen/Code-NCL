load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wrffile=addfile("./wrfout/wrfout_d03_2014-05-22_06:00:00","r")
RH=wrf_user_getvar(wrffile,"rh",-1)
T=wrf_user_getvar(wrffile,"tc",-1)
print(RH(0,:,82,106))
print(T(0,:,82,106))
