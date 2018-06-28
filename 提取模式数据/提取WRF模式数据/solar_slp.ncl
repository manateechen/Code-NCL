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

solar_slp=new((/5840,179,215/),"float")

do i=0,660
solar_slp(i,:,:)=wrf_user_getvar(solardata1,"slp",i)
end do
print("fuck once")

do i=0,1139
solar_slp(i+661,:,:)=wrf_user_getvar(solardata2,"slp",i)
end do
print("fuck twice")

do i=0,899
solar_slp(i+1801,:,:)=wrf_user_getvar(solardata3,"slp",i)
end do
print("fuck 3 times")

do i=0,1199
solar_slp(i+2701,:,:)=wrf_user_getvar(solardata4,"slp",i)
end do
print("fuck 4 times")

do i=0,1079
solar_slp(i+3901,:,:)=wrf_user_getvar(solardata5,"slp",i)
end do
print("fuck 5 times")

do i=0,858
solar_slp(i+4981,:,:)=wrf_user_getvar(solardata6,"slp",i)
end do
print("fuck 5 times")

out=addfile("solar_slp.nc","c")
out->solar_slp=solar_slp
print("fuck slp")
print("fuck off")
