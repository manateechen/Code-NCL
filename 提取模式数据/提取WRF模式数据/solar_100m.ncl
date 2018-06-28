load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

solardata1=addfile("/home3_hn/qianqf/solar_test/wrfout_d01_2007-01-01_00:00:00","r")
solardata2=addfile("/home3_hn/qianqf/solar_test/wrfout_d01_2007-06-15_06:00:00","r")
solardata3=addfile("/home3_hn/qianqf/solar_test/wrfout_d01_2008-03-27_06:00:00","r")
solardata4=addfile("/home3_hn/qianqf/solar_test/wrfout_d01_2008-11-07_06:00:00","r")
solardata5=addfile("/home3_hn/qianqf/solar_test/wrfout_d01_2009-09-03_06:00:00","r")
solardata6=addfile("/home3_hn/qianqf/solar_test/wrfout_d01_2010-05-31_06:00:00","r")
print("fuck begin")

solar_100m_U=new((/5840,179,215/),"float")
solar_100m_V=new((/5840,179,215/),"float")
solar_100m_T=new((/5840,179,215/),"float")

hgt=wrf_user_getvar(solardata1,"HGT",0)
height=wrf_user_getvar(solardata1,"height",0)
z=height-conform(height,hgt,(/1,2/))
print("fuck z")

do i=0,660
ua1=wrf_user_getvar(solardata1,"ua",i)
va1=wrf_user_getvar(solardata1,"va",i)
tk1=wrf_user_getvar(solardata1,"tk",i)
solar_100m_U(i,:,:)=wrf_user_intrp3d(ua1,z,"h",100.,0.,False)
solar_100m_V(i,:,:)=wrf_user_intrp3d(va1,z,"h",100.,0.,False)
solar_100m_T(i,:,:)=wrf_user_intrp3d(tk1,z,"h",100.,0.,False)
end do
print("fuck once")

do i=0,1139
ua2=wrf_user_getvar(solardata2,"ua",i)
va2=wrf_user_getvar(solardata2,"va",i)
tk2=wrf_user_getvar(solardata2,"tk",i)
solar_100m_U(i+661,:,:)=wrf_user_intrp3d(ua2,z,"h",100.,0.,False)
solar_100m_V(i+661,:,:)=wrf_user_intrp3d(va2,z,"h",100.,0.,False)
solar_100m_T(i+661,:,:)=wrf_user_intrp3d(tk2,z,"h",100.,0.,False)
end do
print("fuck twice")


do i=0,899
ua3=wrf_user_getvar(solardata3,"ua",i)
va3=wrf_user_getvar(solardata3,"va",i)
tk3=wrf_user_getvar(solardata3,"tk",i)
solar_100m_U(i+1801,:,:)=wrf_user_intrp3d(ua3,z,"h",100.,0.,False)
solar_100m_V(i+1801,:,:)=wrf_user_intrp3d(va3,z,"h",100.,0.,False)
solar_100m_T(i+1801,:,:)=wrf_user_intrp3d(tk3,z,"h",100.,0.,False)
end do
print("fuck 3 times")

do i=0,1199
ua4=wrf_user_getvar(solardata4,"ua",i)
va4=wrf_user_getvar(solardata4,"va",i)
tk4=wrf_user_getvar(solardata4,"tk",i)
solar_100m_U(i+2701,:,:)=wrf_user_intrp3d(ua4,z,"h",100.,0.,False)
solar_100m_V(i+2701,:,:)=wrf_user_intrp3d(va4,z,"h",100.,0.,False)
solar_100m_T(i+2701,:,:)=wrf_user_intrp3d(tk4,z,"h",100.,0.,False)
end do
print("fuck 4 times")

do i=0,1079
ua5=wrf_user_getvar(solardata5,"ua",i)
va5=wrf_user_getvar(solardata5,"va",i)
tk5=wrf_user_getvar(solardata5,"tk",i)
solar_100m_U(i+3901,:,:)=wrf_user_intrp3d(ua5,z,"h",100.,0.,False)
solar_100m_V(i+3901,:,:)=wrf_user_intrp3d(va5,z,"h",100.,0.,False)
solar_100m_T(i+3901,:,:)=wrf_user_intrp3d(tk5,z,"h",100.,0.,False)
end do
print("fuck 5 times")

do i=0,858
ua6=wrf_user_getvar(solardata6,"ua",i)
va6=wrf_user_getvar(solardata6,"va",i)
tk6=wrf_user_getvar(solardata6,"tk",i)
solar_100m_U(i+4981,:,:)=wrf_user_intrp3d(ua6,z,"h",100.,0.,False)
solar_100m_V(i+4981,:,:)=wrf_user_intrp3d(va6,z,"h",100.,0.,False)
solar_100m_T(i+4981,:,:)=wrf_user_intrp3d(tk6,z,"h",100.,0.,False)
end do
print("fuck 5 times")

out=addfile("solar_100m_U.nc","c")
out->solar_100m_U=solar_100m_U
print("fuck 100u")

out=addfile("solar_100m_V.nc","c")
out->solar_100m_V=solar_100m_V
print("fuck 100v")

out=addfile("solar_100m_T.nc","c")
out->solar_100m_T=solar_100m_T
print("fuck 100t")

