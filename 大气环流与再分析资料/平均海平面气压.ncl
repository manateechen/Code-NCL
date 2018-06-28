load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

f=addfile("ECMWF_monthly_681905210.nc","r")

ps=f->PS
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

ps_ave = wgt_areaave(ps, gw, 1.0, 1)*4.0*3.1415926*re*re*100.0/9.8/10^18

printVarSummary(ps_ave)

res=True
res@xyLineThicknesses=5.0
res@gsnYRefLine=1
res@tiXAxisString="Month"
res@tmLabelAutoStride = True
res@gsnRightString="scale factor: 1E18"
res@gsnLeftString="unit:kg"
res@tiMainString="Monthly atmosphere mass"

wks=gsn_open_wks("png","ps")
plot=gsn_csm_xy(wks,time,ps_ave,res)
