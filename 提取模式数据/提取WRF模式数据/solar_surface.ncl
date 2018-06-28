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

T2=new((/5840,179,215/),"float")
T2(0:660,:,:)=solardata1->T2(0:660,:,:)
T2(661:1800,:,:)=solardata2->T2(0:1139,:,:)
T2(1801:2700,:,:)=solardata3->T2(0:899,:,:)
T2(2701:3900,:,:)=solardata4->T2(0:1199,:,:)
T2(3901:4980,:,:)=solardata5->T2(0:1079,:,:)
T2(4981:5839,:,:)=solardata6->T2(0:858,:,:)
out=addfile("solar_2m_T.nc","c")
out->solar_2m_T=T2
print("fuck T")

U10=new((/5840,179,215/),"float")
U10(0:660,:,:)=solardata1->U10(0:660,:,:)
U10(661:1800,:,:)=solardata2->U10(0:1139,:,:)
U10(1801:2700,:,:)=solardata3->U10(0:899,:,:)
U10(2701:3900,:,:)=solardata4->U10(0:1199,:,:)
U10(3901:4980,:,:)=solardata5->U10(0:1079,:,:)
U10(4981:5839,:,:)=solardata6->U10(0:858,:,:)
out=addfile("solar_10m_U.nc","c")
out->solar_10m_U=U10
print("fuck U")

V10=new((/5840,179,215/),"float")
V10(0:660,:,:)=solardata1->V10(0:660,:,:)
V10(661:1800,:,:)=solardata2->V10(0:1139,:,:)
V10(1801:2700,:,:)=solardata3->V10(0:899,:,:)
V10(2701:3900,:,:)=solardata4->V10(0:1199,:,:)
V10(3901:4980,:,:)=solardata5->V10(0:1079,:,:)
V10(4981:5839,:,:)=solardata6->V10(0:858,:,:)
out=addfile("solar_10m_V.nc","c")
out->solar_10m_V=V10
print("fuck V")

irainnc=new((/5840,179,215/),"float")
rainnc=new((/5840,179,215/),"float")
irainc=new((/5840,179,215/),"float")
rainc=new((/5840,179,215/),"float")
pre=new((/5840,179,215/),"float")

irainnc(0:660,:,:)=solardata1->I_RAINNC(0:660,:,:)
irainnc(661:1800,:,:)=solardata2->I_RAINNC(0:1139,:,:)
irainnc(1801:2700,:,:)=solardata3->I_RAINNC(0:899,:,:)
irainnc(2701:3900,:,:)=solardata4->I_RAINNC(0:1199,:,:)
irainnc(3901:4980,:,:)=solardata5->I_RAINNC(0:1079,:,:)
irainnc(4981:5839,:,:)=solardata6->I_RAINNC(0:858,:,:)

rainnc(0:660,:,:)=solardata1->RAINNC(0:660,:,:)
rainnc(661:1800,:,:)=solardata2->RAINNC(0:1139,:,:)
rainnc(1801:2700,:,:)=solardata3->RAINNC(0:899,:,:)
rainnc(2701:3900,:,:)=solardata4->RAINNC(0:1199,:,:)
rainnc(3901:4980,:,:)=solardata5->RAINNC(0:1079,:,:)
rainnc(4981:5839,:,:)=solardata6->RAINNC(0:858,:,:)

irainc(0:660,:,:)=solardata1->I_RAINC(0:660,:,:)
irainc(661:1800,:,:)=solardata2->I_RAINC(0:1139,:,:)
irainc(1801:2700,:,:)=solardata3->I_RAINC(0:899,:,:)
irainc(2701:3900,:,:)=solardata4->I_RAINC(0:1199,:,:)
irainc(3901:4980,:,:)=solardata5->I_RAINC(0:1079,:,:)
irainc(4981:5839,:,:)=solardata6->I_RAINC(0:858,:,:)

rainc(0:660,:,:)=solardata1->RAINC(0:660,:,:)
rainc(661:1800,:,:)=solardata2->RAINC(0:1139,:,:)
rainc(1801:2700,:,:)=solardata3->RAINC(0:899,:,:)
rainc(2701:3900,:,:)=solardata4->RAINC(0:1199,:,:)
rainc(3901:4980,:,:)=solardata5->RAINC(0:1079,:,:)
rainc(4981:5839,:,:)=solardata6->RAINC(0:858,:,:)

pre=(irainnc+irainc)*100.0+rainnc+rainc

out=addfile("solar_pre.nc","c")
out->solar_pre=pre
print("fuck pre")
print("fuck off")
