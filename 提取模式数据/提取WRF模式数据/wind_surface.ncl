load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

winddata1=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2007-01-01_wind","r")
winddata2=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2008-04-26_06_wind","r")
winddata3=addfile("/home3_hn/qianqf/wind_test/wrfout_d01_2010-04-01_06_wind","r")
print("fuck begin")

T2=new((/5840,179,215/),"float")
T2(0:1920,:,:)=winddata1->T2(0:1920,:,:)
T2(1921:4740,:,:)=winddata2->T2(0:2819,:,:)
T2(4741:5839,:,:)=winddata3->T2(0:1098,:,:)
out=addfile("wind_2m_T.nc","c")
out->wind_2m_T=T2
print("fuck T")

U10=new((/5840,179,215/),"float")
U10(0:1920,:,:)=winddata1->U10(0:1920,:,:)
U10(1921:4740,:,:)=winddata2->U10(0:2819,:,:)
U10(4741:5839,:,:)=winddata3->U10(0:1098,:,:)
out=addfile("wind_10m_U.nc","c")
out->wind_10m_U=U10
print("fuck U")

V10=new((/5840,179,215/),"float")
V10(0:1920,:,:)=winddata1->V10(0:1920,:,:)
V10(1921:4740,:,:)=winddata2->V10(0:2819,:,:)
V10(4741:5839,:,:)=winddata3->V10(0:1098,:,:)
out=addfile("wind_10m_V.nc","c")
out->wind_10m_V=V10
print("fuck V")

irainnc=new((/5840,179,215/),"float")
rainnc=new((/5840,179,215/),"float")
irainc=new((/5840,179,215/),"float")
rainc=new((/5840,179,215/),"float")
pre=new((/5840,179,215/),"float")
irainnc(0:1920,:,:)=winddata1->I_RAINNC(0:1920,:,:)
irainnc(1921:4740,:,:)=winddata2->I_RAINNC(0:2819,:,:)
irainnc(4741:5839,:,:)=winddata3->I_RAINNC(0:1098,:,:)
rainnc(0:1920,:,:)=winddata1->RAINNC(0:1920,:,:)
rainnc(1921:4740,:,:)=winddata2->RAINNC(0:2819,:,:)
rainnc(4741:5839,:,:)=winddata3->RAINNC(0:1098,:,:)
irainc(0:1920,:,:)=winddata1->I_RAINC(0:1920,:,:)
irainc(1921:4740,:,:)=winddata2->I_RAINC(0:2819,:,:)
irainc(4741:5839,:,:)=winddata3->I_RAINC(0:1098,:,:)
rainc(0:1920,:,:)=winddata1->RAINC(0:1920,:,:)
rainc(1921:4740,:,:)=winddata2->RAINC(0:2819,:,:)
rainc(4741:5839,:,:)=winddata3->RAINC(0:1098,:,:)
pre=(irainnc+irainc)*100.0+rainnc+rainc

out=addfile("wind_pre.nc","c")
out->wind_pre=pre
print("fuck pre")
print("fuck off")
