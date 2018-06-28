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

ctl_slp=new((/5840,179,215/),"float")

do i=0,1999
ctl_slp(i,:,:)=wrf_user_getvar(ctldata1,"slp",i)
end do
print("fuck 1")

do i=0,496
ctl_slp(i+2000,:,:)=wrf_user_getvar(ctldata2,"slp",i)
end do
print("fuck 2")

do i=0,1999
ctl_slp(i+2497,:,:)=wrf_user_getvar(ctldata3,"slp",i)
end do
print("fuck 3")

do i=0,1342
ctl_slp(i+4497,:,:)=wrf_user_getvar(ctldata4,"slp",i)
end do
print("fuck 4")

out=addfile("ctl_slp.nc","c")
out->ctl_slp=ctl_slp
print("fuck slp")
print("fuck off")
