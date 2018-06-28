load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

var  = getenv("var")
print(var)
datafile=addfile("wrfout_d01_2007-06-01_00:00:00","r")
varout=wrf_user_getvar(datafile,var,0)

out=addfile(var+".nc","c")
out->$var$=varout
