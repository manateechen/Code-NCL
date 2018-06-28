load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

wrfout_d04=addfile("./wrfout_d04_2013-07-06_00:00:00","r")
T2_d04=wrf_user_getvar(wrfout_d04,"T2",-1)
xlat=wrf_user_getvar(wrfout_d04, "XLAT", 0)
xlon=wrf_user_getvar(wrfout_d04, "XLONG", 0)

filepath="data.txt"
nlines=5
ncols=80
dat=asciiread(filepath,(/nlines,ncols/),"float")

lat=dat(0,:)
lon=dat(1,:)

T2=rcm2points_Wrap(xlat, xlon, T2_d04, lat, lon, 0)
printVarSummary(T2)

do ii=0,ncols-1
    filename = "station-lat-"+lat(ii)+"-lon-"+lon(ii)
    asciiwrite(filename, T2(:,ii))
end do