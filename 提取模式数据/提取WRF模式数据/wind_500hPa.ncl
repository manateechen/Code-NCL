load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

winddata1=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2007-01-01_wind","r")
winddata2=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2008-04-26_06_wind","r")
winddata3=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2010-04-01_06_wind","r")
print("fuck begin")

wind_500hPa_G=new((/5840,179,215/),"float")
wind_500hPa_T=new((/5840,179,215/),"float")



do i=0,1920
p1=wrf_user_getvar(winddata1,"pressure",i)
g1=wrf_user_getvar(winddata1,"geopotential",i)
tk1=wrf_user_getvar(winddata1,"tk",i)
wind_500hPa_G(i,:,:)=wrf_user_intrp3d(g1,p1,"h",500.,0.,False)
wind_500hPa_T(i,:,:)=wrf_user_intrp3d(tk1,p1,"h",500.,0.,False)
end do
print("fuck once")

do i=0,2819
p2=wrf_user_getvar(winddata2,"pressure",i)
g2=wrf_user_getvar(winddata2,"geopotential",i)
tk2=wrf_user_getvar(winddata2,"tk",i)
wind_500hPa_G(i+1921,:,:)=wrf_user_intrp3d(g2,p2,"h",500.,0.,False)
wind_500hPa_T(i+1921,:,:)=wrf_user_intrp3d(tk2,p2,"h",500.,0.,False)
end do
print("fuck twice")

do i=0,1098
p3=wrf_user_getvar(winddata3,"pressure",i)
g3=wrf_user_getvar(winddata3,"geopotential",i)
tk3=wrf_user_getvar(winddata3,"tk",i)
wind_500hPa_G(i+4741,:,:)=wrf_user_intrp3d(g3,p3,"h",500.,0.,False)
wind_500hPa_T(i+4741,:,:)=wrf_user_intrp3d(tk3,p3,"h",500.,0.,False)
end do
print("fuck 3 times")

out=addfile("wind_500hPa_G.nc","c")
out->wind_500hPa_G=wind_500hPa_G
print("fuck 500G")

out=addfile("wind_500hPa_T.nc","c")
out->wind_500hPa_T=wind_500hPa_T
print("fuck 500T")
