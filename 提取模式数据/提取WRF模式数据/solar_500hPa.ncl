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

solar_500hPa_G=new((/5840,179,215/),"float")
solar_500hPa_T=new((/5840,179,215/),"float")



do i=0,660
p1=wrf_user_getvar(solardata1,"pressure",i)
g1=wrf_user_getvar(solardata1,"geopotential",i)
tk1=wrf_user_getvar(solardata1,"tk",i)
solar_500hPa_G(i,:,:)=wrf_user_intrp3d(g1,p1,"h",500.,0.,False)
solar_500hPa_T(i,:,:)=wrf_user_intrp3d(tk1,p1,"h",500.,0.,False)
end do
print("fuck once")

do i=0,1139
p2=wrf_user_getvar(solardata2,"pressure",i)
g2=wrf_user_getvar(solardata2,"geopotential",i)
tk2=wrf_user_getvar(solardata2,"tk",i)
solar_500hPa_G(i+661,:,:)=wrf_user_intrp3d(g2,p2,"h",500.,0.,False)
solar_500hPa_T(i+661,:,:)=wrf_user_intrp3d(tk2,p2,"h",500.,0.,False)
end do
print("fuck twice")

do i=0,899
p3=wrf_user_getvar(solardata3,"pressure",i)
g3=wrf_user_getvar(solardata3,"geopotential",i)
tk3=wrf_user_getvar(solardata3,"tk",i)
solar_500hPa_G(i+1801,:,:)=wrf_user_intrp3d(g3,p3,"h",500.,0.,False)
solar_500hPa_T(i+1801,:,:)=wrf_user_intrp3d(tk3,p3,"h",500.,0.,False)
end do
print("fuck 3 times")

do i=0,1199
p4=wrf_user_getvar(solardata4,"pressure",i)
g4=wrf_user_getvar(solardata4,"geopotential",i)
tk4=wrf_user_getvar(solardata4,"tk",i)
solar_500hPa_G(i+2701,:,:)=wrf_user_intrp3d(g4,p4,"h",500.,0.,False)
solar_500hPa_T(i+2701,:,:)=wrf_user_intrp3d(tk4,p4,"h",500.,0.,False)
end do
print("fuck 4 times")

do i=0,1079
p5=wrf_user_getvar(solardata5,"pressure",i)
g5=wrf_user_getvar(solardata5,"geopotential",i)
tk5=wrf_user_getvar(solardata5,"tk",i)
solar_500hPa_G(i+3901,:,:)=wrf_user_intrp3d(g5,p5,"h",500.,0.,False)
solar_500hPa_T(i+3901,:,:)=wrf_user_intrp3d(tk5,p5,"h",500.,0.,False)
end do
print("fuck 4 times")

do i=0,858
p6=wrf_user_getvar(solardata6,"pressure",i)
g6=wrf_user_getvar(solardata6,"geopotential",i)
tk6=wrf_user_getvar(solardata6,"tk",i)
solar_500hPa_G(i+4981,:,:)=wrf_user_intrp3d(g6,p6,"h",500.,0.,False)
solar_500hPa_T(i+4981,:,:)=wrf_user_intrp3d(tk6,p6,"h",500.,0.,False)
end do
print("fuck 4 times")

out=addfile("solar_500hPa_G.nc","c")
out->solar_500hPa_G=solar_500hPa_G
print("fuck 500G")

out=addfile("solar_500hPa_T.nc","c")
out->solar_500hPa_T=solar_500hPa_T
print("fuck 500T")
