load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

winddata1=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2007-01-01_wind","r")
winddata2=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2008-04-26_06_wind","r")
winddata3=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2010-04-01_06_wind","r")
print("fuck begin")

wind_slp=new((/5840,179,215/),"float")

do i=0,1920
wind_slp(i,:,:)=wrf_user_getvar(winddata1,"slp",i)
end do
print("fuck once")

do i=0,2819
wind_slp(i+1921,:,:)=wrf_user_getvar(winddata2,"slp",i)
end do
print("fuck twice")


do i=0,1098
wind_slp(i+4741,:,:)=wrf_user_getvar(winddata3,"slp",i)
end do
print("fuck 3 times")

out=addfile("wind_slp.nc","c")
out->wind_slp=wind_slp
print("fuck slp")
print("fuck off")
