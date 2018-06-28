load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"  

f=addfile("ECMWF_monthly_681905210.nc","r")
PREH2O=f->PREH2O
lat=f->lat
lon=f->lon
gw=f->gw

time=ispan(1,12,1)

nlat=dimsizes(lat)

rad    = 4.0*atan(1.0)/180.0
re     = 6371220.0
rr     = re*rad
dlon   = abs(lon(2)-lon(1))*rr
dx     = dlon*cos(lat*rad)
dy     = new ( nlat, typeof(dx))
dy(0)  = abs(lat(2)-lat(1))*rr
dy(1:nlat-2)  = abs(lat(2:nlat-1)-lat(0:nlat-3))*rr*0.5   
dy(nlat-1)    = abs(lat(nlat-1)-lat(nlat-2))*rr                             

PREH2O_ave = wgt_areaave(PREH2O, gw, 1.0, 1)*4.0*3.1415926*re*re/10^16
printVarSummary(PREH2O_ave)

res=True
res@xyLineThicknesses=5.0
res@gsnYRefLine=1
res@tiXAxisString="Month"
res@tmLabelAutoStride = True
res@gsnRightString="scale factor: 1E16"
res@gsnLeftString="unit:kg"
res@tiMainString="Monthly water mass in atmosphere"

wks=gsn_open_wks("x11","PREH2O")
plot=gsn_csm_xy(wks,time,PREH2O_ave,res)
delete(wks)

QFLX=f->QFLX
EP=f->EP
pre=QFLX-EP

pre_ave = wgt_areaave(pre, gw, 1.0, 1)*4.0*3.1415926*re*re/10^15
res@tiMainString="Monthly precipitation rate"
res@gsnRightString="scale factor: 1E15"
wks=gsn_open_wks("x11","pre")
plot=gsn_csm_xy(wks,time,pre_ave,res)
delete(wks)

PREH2O_monave=dim_avg_n_Wrap(PREH2O_ave,0)*10^16
pre_monave=dim_avg_n_Wrap(pre_ave,0)*10^15
tt=PREH2O_monave/pre_monave
print(tt)          ;8.29429day
