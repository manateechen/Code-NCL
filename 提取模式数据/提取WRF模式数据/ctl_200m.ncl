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

ctl_200m_U=new((/5840,179,215/),"float")
ctl_200m_V=new((/5840,179,215/),"float")
ctl_200m_T=new((/5840,179,215/),"float")

hgt=wrf_user_getvar(ctldata1,"HGT",0)
height=wrf_user_getvar(ctldata1,"height",0)
z=height-conform(height,hgt,(/1,2/))

do i=0,1999
ua1=wrf_user_getvar(ctldata1,"ua",i)
va1=wrf_user_getvar(ctldata1,"va",i)
tk1=wrf_user_getvar(ctldata1,"tk",i)
ctl_200m_U(i,:,:)=wrf_user_intrp3d(ua1,z,"h",200.,0.,False)
ctl_200m_V(i,:,:)=wrf_user_intrp3d(va1,z,"h",200.,0.,False)
ctl_200m_T(i,:,:)=wrf_user_intrp3d(tk1,z,"h",200.,0.,False)
end do
print("fuck 1")

do i=0,496
ua2=wrf_user_getvar(ctldata2,"ua",i)
va2=wrf_user_getvar(ctldata2,"va",i)
tk2=wrf_user_getvar(ctldata2,"tk",i)
ctl_200m_U(i+2000,:,:)=wrf_user_intrp3d(ua2,z,"h",200.,0.,False)
ctl_200m_V(i+2000,:,:)=wrf_user_intrp3d(va2,z,"h",200.,0.,False)
ctl_200m_T(i+2000,:,:)=wrf_user_intrp3d(tk2,z,"h",200.,0.,False)
end do
print("fuck 2")

do i=0,1999
ua3=wrf_user_getvar(ctldata3,"ua",i)
va3=wrf_user_getvar(ctldata3,"va",i)
tk3=wrf_user_getvar(ctldata3,"tk",i)
ctl_200m_U(i+2497,:,:)=wrf_user_intrp3d(ua3,z,"h",200.,0.,False)
ctl_200m_V(i+2497,:,:)=wrf_user_intrp3d(va3,z,"h",200.,0.,False)
ctl_200m_T(i+2497,:,:)=wrf_user_intrp3d(tk3,z,"h",200.,0.,False)
end do
print("fuck 3")

do i=0,1342
ua4=wrf_user_getvar(ctldata4,"ua",i)
va4=wrf_user_getvar(ctldata4,"va",i)
tk4=wrf_user_getvar(ctldata4,"tk",i)
ctl_200m_U(i+4497,:,:)=wrf_user_intrp3d(ua4,z,"h",200.,0.,False)
ctl_200m_V(i+4497,:,:)=wrf_user_intrp3d(va4,z,"h",200.,0.,False)
ctl_200m_T(i+4497,:,:)=wrf_user_intrp3d(tk4,z,"h",200.,0.,False)
end do
print("fuck 4")

out=addfile("ctl_200m_U.nc","c")
out->ctl_200m_U=ctl_200m_U
print("fuck 200u")

out=addfile("ctl_200m_V.nc","c")
out->ctl_200m_V=ctl_200m_V
print("fuck 200v")

out=addfile("ctl_200m_T.nc","c")
out->ctl_200m_T=ctl_200m_T
print("fuck 200t")
