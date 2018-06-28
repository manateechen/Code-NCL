load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

winddata1=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2007-01-01_wind","r")
winddata2=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2008-04-26_06_wind","r")
winddata3=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2010-04-01_06_wind","r")
print("fuck begin")

wind_5000m_U=new((/5840,179,215/),"float")
wind_5000m_V=new((/5840,179,215/),"float")
wind_5000m_T=new((/5840,179,215/),"float")

hgt=wrf_user_getvar(winddata1,"HGT",0)
height=wrf_user_getvar(winddata1,"height",0)
z=height-conform(height,hgt,(/1,2/))
print("fuck z")

do i=0,1920
ua1=wrf_user_getvar(winddata1,"ua",i)
va1=wrf_user_getvar(winddata1,"va",i)
tk1=wrf_user_getvar(winddata1,"tk",i)
wind_5000m_U(i,:,:)=wrf_user_intrp3d(ua1,z,"h",5000.,0.,False)
wind_5000m_V(i,:,:)=wrf_user_intrp3d(va1,z,"h",5000.,0.,False)
wind_5000m_T(i,:,:)=wrf_user_intrp3d(tk1,z,"h",5000.,0.,False)
end do
print("fuck once")

do i=0,2819
ua2=wrf_user_getvar(winddata2,"ua",i)
va2=wrf_user_getvar(winddata2,"va",i)
tk2=wrf_user_getvar(winddata2,"tk",i)
wind_5000m_U(i+1921,:,:)=wrf_user_intrp3d(ua2,z,"h",5000.,0.,False)
wind_5000m_V(i+1921,:,:)=wrf_user_intrp3d(va2,z,"h",5000.,0.,False)
wind_5000m_T(i+1921,:,:)=wrf_user_intrp3d(tk2,z,"h",5000.,0.,False)
end do
print("fuck twice")

do i=0,1098
ua3=wrf_user_getvar(winddata3,"ua",i)
va3=wrf_user_getvar(winddata3,"va",i)
tk3=wrf_user_getvar(winddata3,"tk",i)
wind_5000m_U(i+4741,:,:)=wrf_user_intrp3d(ua3,z,"h",5000.,0.,False)
wind_5000m_V(i+4741,:,:)=wrf_user_intrp3d(va3,z,"h",5000.,0.,False)
wind_5000m_T(i+4741,:,:)=wrf_user_intrp3d(tk3,z,"h",5000.,0.,False)
end do
print("fuck 3 times")

out=addfile("wind_5000m_U.nc","c")
out->wind_5000m_U=wind_5000m_U
print("fuck 100u")

out=addfile("wind_5000m_V.nc","c")
out->wind_5000m_V=wind_5000m_V
print("fuck 100v")

out=addfile("wind_5000m_T.nc","c")
out->wind_5000m_T=wind_5000m_T
print("fuck 100t")
