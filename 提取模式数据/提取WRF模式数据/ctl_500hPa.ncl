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

ctl_500hPa_G=new((/5840,179,215/),"float")
ctl_500hPa_T=new((/5840,179,215/),"float")



do i=0,1999
p1=wrf_user_getvar(ctldata1,"pressure",i)
g1=wrf_user_getvar(ctldata1,"geopotential",i)
tk1=wrf_user_getvar(ctldata1,"tk",i)
ctl_500hPa_G(i,:,:)=wrf_user_intrp3d(g1,p1,"h",500.,0.,False)
ctl_500hPa_T(i,:,:)=wrf_user_intrp3d(tk1,p1,"h",500.,0.,False)
end do
print("fuck 1")

do i=0,496
p2=wrf_user_getvar(ctldata2,"pressure",i)
g2=wrf_user_getvar(ctldata2,"geopotential",i)
tk2=wrf_user_getvar(ctldata2,"tk",i)
ctl_500hPa_G(i+2000,:,:)=wrf_user_intrp3d(g2,p2,"h",500.,0.,False)
ctl_500hPa_T(i+2000,:,:)=wrf_user_intrp3d(tk2,p2,"h",500.,0.,False)
end do
print("fuck 2")

do i=0,1999
p3=wrf_user_getvar(ctldata3,"pressure",i)
g3=wrf_user_getvar(ctldata3,"geopotential",i)
tk3=wrf_user_getvar(ctldata3,"tk",i)
ctl_500hPa_G(i+2497,:,:)=wrf_user_intrp3d(g3,p3,"h",500.,0.,False)
ctl_500hPa_T(i+2497,:,:)=wrf_user_intrp3d(tk3,p3,"h",500.,0.,False)
end do
print("fuck 3")

do i=0,1342
p4=wrf_user_getvar(ctldata4,"pressure",i)
g4=wrf_user_getvar(ctldata4,"geopotential",i)
tk4=wrf_user_getvar(ctldata4,"tk",i)
ctl_500hPa_G(i+4497,:,:)=wrf_user_intrp3d(g4,p4,"h",500.,0.,False)
ctl_500hPa_T(i+4497,:,:)=wrf_user_intrp3d(tk4,p4,"h",500.,0.,False)
end do
print("fuck 4")

out=addfile("ctl_500hPa_G.nc","c")
out->ctl_500hPa_G=ctl_500hPa_G
print("fuck 500G")

out=addfile("ctl_500hPa_T.nc","c")
out->ctl_500hPa_T=ctl_500hPa_T
print("fuck 500T")
