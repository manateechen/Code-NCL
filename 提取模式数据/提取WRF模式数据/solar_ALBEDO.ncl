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

ALBEDO=new((/5840,179,215/),"float")
ALBEDO(0:660,:,:)=solardata1->ALBEDO(0:660,:,:)
ALBEDO(661:1800,:,:)=solardata2->ALBEDO(0:1139,:,:)
ALBEDO(1801:2700,:,:)=solardata3->ALBEDO(0:899,:,:)
ALBEDO(2701:3900,:,:)=solardata4->ALBEDO(0:1199,:,:)
ALBEDO(3901:4980,:,:)=solardata5->ALBEDO(0:1079,:,:)
ALBEDO(4981:5839,:,:)=solardata6->ALBEDO(0:858,:,:)
out=addfile("solar_ALBEDO.nc","c")
out->solar_ALBEDO=ALBEDO
print("fuck ALBEDO")
