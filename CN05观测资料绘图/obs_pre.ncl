load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

data=addfile("/home/QQF/CN05.1-OBS/CN05.1_Pre_1961_2012_daily_025x025.nc","r")
time=data->time
tm=data->pre(6574:,:,:)
tm&time=time(6574:)
printVarSummary(tm)
;copy_VarCoords(data->tm(0:6574,:,:),tm)
lat=data->lat
lon=data->lon

tm_mon=calculate_monthly_values(tm, "avg", 0, False)
tm_spring=month_to_season(tm_mon,"MAM")
tm_summer=month_to_season(tm_mon,"JJA")
tm_autumn=month_to_season(tm_mon,"SON")

setfileoption("nc","Format","LargeFile")
out=addfile("pre_mon.nc","c")
out->pre_mon=tm_mon
out->lat=lat
out->lon=lon

out1=addfile("pre_spring.nc","c")
out1->pre_spring=tm_spring
out1->lat=lat
out1->lon=lon

out2=addfile("pre_summer.nc","c")
out2->pre_summer=tm_summer
out2->lat=lat
out2->lon=lon

out3=addfile("pre_autumn.nc","c")
out3->pre_autumn=tm_autumn
out3->lat=lat
out3->lon=lon

