load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

datafile=addfile("Precipitation.nc","r")
f1=addfile("wrfout_d01_1998-05-01_00:00:00","r")

Pre=datafile->Precipitation

pre=new((/92,579,699/),"float")

do i=0,90
  pre(i,:,:)=Pre(124+i*4+4,:,:)-Pre(124+i*4,:,:)
end do
pre(91,:,:)=Pre(491,:,:)-Pre(488,:,:)
printVarSummary(pre)

lat=wrf_user_getvar(f1,"lat",0)
lon=wrf_user_getvar(f1,"lon",0)

setfileoption("nc","Format","LargeFile")
out=addfile("dailypre.nc","c")
out->pre=pre
out->lat=lat
out->lon=lon
print("pre")
