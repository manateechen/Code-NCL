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

LWUPB=new((/5840,179,215/),"float")
LWUPB(0:660,:,:)=solardata1->LWUPB(0:660,:,:)
LWUPB(661:1800,:,:)=solardata2->LWUPB(0:1139,:,:)
LWUPB(1801:2700,:,:)=solardata3->LWUPB(0:899,:,:)
LWUPB(2701:3900,:,:)=solardata4->LWUPB(0:1199,:,:)
LWUPB(3901:4980,:,:)=solardata5->LWUPB(0:1079,:,:)
LWUPB(4981:5839,:,:)=solardata6->LWUPB(0:858,:,:)
out=addfile("solar_LWUPB.nc","c")
out->solar_LWUPB=LWUPB
print("fuck LWUPB")
