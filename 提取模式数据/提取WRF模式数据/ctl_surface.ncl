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

ctl_t2=new((/5840,179,215/),"float")
ctl_t2(0:1999,:,:)=ctldata1->T2(0:1999,:,:)
ctl_t2(2000:2496,:,:)=ctldata2->T2(0:496,:,:)
ctl_t2(2497:4496,:,:)=ctldata3->T2(0:1999,:,:)
ctl_t2(4497:,:,:)=ctldata4->T2(0:1342,:,:)
out=addfile("ctl_2m_T.nc","c")
out->ctl_2m_T=ctl_t2
print("fuck T")

ctl_u10=new((/5840,179,215/),"float")
ctl_u10(0:1999,:,:)=ctldata1->U10(0:1999,:,:)
ctl_u10(2000:2496,:,:)=ctldata2->U10(0:496,:,:)
ctl_u10(2497:4496,:,:)=ctldata3->U10(0:1999,:,:)
ctl_u10(4497:,:,:)=ctldata4->U10(0:1342,:,:)
out=addfile("ctl_10m_U.nc","c")
out->ctl_10m_U=ctl_u10
print("fuck U")

ctl_v10=new((/5840,179,215/),"float")
ctl_v10(0:1999,:,:)=ctldata1->V10(0:1999,:,:)
ctl_v10(2000:2496,:,:)=ctldata2->V10(0:496,:,:)
ctl_v10(2497:4496,:,:)=ctldata3->V10(0:1999,:,:)
ctl_v10(4497:,:,:)=ctldata4->V10(0:1342,:,:)
out=addfile("ctl_10m_V.nc","c")
out->ctl_10m_V=ctl_v10
print("fuck V")

irainnc=new((/5840,179,215/),"float")
rainnc=new((/5840,179,215/),"float")
irainc=new((/5840,179,215/),"float")
rainc=new((/5840,179,215/),"float")

irainnc(0:1999,:,:)=ctldata1->I_RAINNC(0:1999,:,:)
irainnc(2000:2496,:,:)=ctldata2->I_RAINNC(0:496,:,:)
irainnc(2497:4496,:,:)=ctldata3->I_RAINNC(0:1999,:,:)
irainnc(4497:,:,:)=ctldata4->I_RAINNC(0:1342,:,:)

rainnc(0:1999,:,:)=ctldata1->RAINNC(0:1999,:,:)
rainnc(2000:2496,:,:)=ctldata2->RAINNC(0:496,:,:)
rainnc(2497:4496,:,:)=ctldata3->RAINNC(0:1999,:,:)
rainnc(4497:,:,:)=ctldata4->RAINNC(0:1342,:,:)

irainc(0:1999,:,:)=ctldata1->I_RAINC(0:1999,:,:)
irainc(2000:2496,:,:)=ctldata2->I_RAINC(0:496,:,:)
irainc(2497:4496,:,:)=ctldata3->I_RAINC(0:1999,:,:)
irainc(4497:,:,:)=ctldata4->I_RAINC(0:1342,:,:)

rainc(0:1999,:,:)=ctldata1->RAINC(0:1999,:,:)
rainc(2000:2496,:,:)=ctldata2->RAINC(0:496,:,:)
rainc(2497:4496,:,:)=ctldata3->RAINC(0:1999,:,:)
rainc(4497:,:,:)=ctldata4->RAINC(0:1342,:,:)

pre=(irainnc+irainc)*100.0+rainnc+rainc
out=addfile("ctl_pre.nc","c")
out->ctl_pre=pre
print("fuck pre")
print("fuck off")
