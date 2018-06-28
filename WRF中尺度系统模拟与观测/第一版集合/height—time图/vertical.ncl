load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

wrff1=addfile("/home2_hn/QQF/MCS/2014/SBU_YSU/wrfout/wrfout_d03_2014-05-23_17:50:00","r")
xlat = wrf_user_getvar(wrff1,"XLAT",0)
xlon = wrf_user_getvar(wrff1,"XLONG",0)

wa=wrf_user_getvar(wrff1,"wa",-1)

zz=(/1, 2, 3, 5, 7, 10, 20, 30, 50, 70, 100, 125, 150, 175, 200, 225, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 775, 800, 825, 850, 875, 900, 925, 950, 975, 1000/) ;unit:hpa

opts=True
opts@extrapolate=True

lat=24.0                                                                                                               
lon=110.0  

wa_ver=wrf_user_vert_interp(wrff1,wa,"pressure",zz,opts) 
wa_point=rcm2points_Wrap(xlat,xlon,wa_ver,lat,lon,0)
printVarSummary(wa_point)

out = addfile("2014-05-23_17:50:00.nc","c")
out->wa=wa_point(0,:,0)
