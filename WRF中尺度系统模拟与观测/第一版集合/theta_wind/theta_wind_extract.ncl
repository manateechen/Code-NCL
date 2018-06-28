load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

scheme="SBU_EVAP5"
filenames=systemfunc("ls ./"+scheme+"/wrfout/wrfout_d03_*:00:00")
print(filenames)
schemefile=addfiles(filenames,"r")
ListSetType (schemefile, "cat")

XLAT=schemefile[0]->XLAT(0,:,:)
XLONG=schemefile[0]->XLONG(0,:,:)
printVarSummary(XLAT)
printVarSummary(XLONG)

lat=23.7167
lon=113.083

theta=wrf_user_getvar(schemefile,"theta",-1)
printVarSummary(theta)
uwind=wrf_user_getvar(schemefile,"ua",-1)
printVarSummary(uwind)
vwind=wrf_user_getvar(schemefile,"va",-1)
printVarSummary(vwind)

opts=True
opts@extrapolate=False
opts@field_type="ght"

npoints=61
z=fspan(0,3,npoints)
z@units="km"

theta_v=wrf_user_vert_interp(schemefile,theta,"ght_msl",z,opts)
printVarSummary(theta_v)
uwind_v=wrf_user_vert_interp(schemefile,uwind,"ght_msl",z,opts)
printVarSummary(uwind_v)
vwind_v=wrf_user_vert_interp(schemefile,vwind,"ght_msl",z,opts)
printVarSummary(vwind_v)
delete(opts)

opt=2

theta_point=rcm2points_Wrap(XLAT,XLONG,theta_v,lat,lon,opt)
printVarSummary(theta_point)
uwind_point=rcm2points_Wrap(XLAT,XLONG,uwind_v,lat,lon,opt)
printVarSummary(uwind_point)
vwind_point=rcm2points_Wrap(XLAT,XLONG,vwind_v,lat,lon,opt)
printVarSummary(vwind_point)

out=addfile(scheme+".nc","c")
out->theta_point=theta_point
out->uwind_point=uwind_point
out->vwind_point=vwind_point

