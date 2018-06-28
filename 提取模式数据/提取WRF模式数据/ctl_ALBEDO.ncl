load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

ctldata1=addfile("/home3_hn/qianqf/control_test/wrfout_d01_2007-01-01_00:00:00","r")
ctldata2=addfile("/home3_hn/qianqf/control_test/wrfout_d01_2008-05-16_00:00:00","r")
ctldata3=addfile("/home3_hn/qianqf/control_test/wrfout_d01_2008-09-17_06:00:00","r")
ctldata4=addfile("/home3_hn/qianqf/control_test/wrfout_d01_2010-01-30_06:00:00","r")
print("fuck begin")

ctl_ALBEDO=new((/5840,179,215/),"float")
ctl_ALBEDO(0:1999,:,:)=ctldata1->ALBEDO(0:1999,:,:)
ctl_ALBEDO(2000:2496,:,:)=ctldata2->ALBEDO(0:496,:,:)
ctl_ALBEDO(2497:4496,:,:)=ctldata3->ALBEDO(0:1999,:,:)
ctl_ALBEDO(4497:,:,:)=ctldata4->ALBEDO(0:1342,:,:)
out=addfile("ctl_ALBEDO.nc","c")
out->ctl_ALBEDO=ctl_ALBEDO
print("fuck T")
