load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl" 

data=addfile("/home/QQF/CN05.1-OBS/CN05.1_Pre_1961_2012_daily_025x025.nc","r")
time=data->time
lat=data->lat
lon=data->lon
pre=data->pre(13665:13756,:,:)

setfileoption("nc","Format","LargeFile")
out=addfile("pre_monthly.nc","c")
out->pre=pre
out->lat=lat
out->lon=lon