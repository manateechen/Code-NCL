load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"

f1=addfile("arctic_mintmp50mb.merra.19970101_20140630.nc","r")
f2=addfile("nh61_avgu10mb.merra.19970101_20140630.nc","r")
f3=addfile("northpole_avgtmp10mb.merra.19970101_20140630.nc","r")
f4=addfile("sibhigh_avgprmsl.merra.19970101_20140630.nc","r")

f1_t=f1->t
f1_time=f1->time

f2_u=f2->u
f2_time=f2->time

f3_t=f3->t
f3_time=f3->time

f4_slp=f4->slp
f4_time=f4->time

res=True
res @gsnMaximize=True
res @vpWidthF=0.75
res @vpHeightF=0.3
res @trXMaxF=153336

restick = True
restick@ttmFormat = "%Y"

time_axis_labels(f1_time,res,restick)
wks   = gsn_open_wks ("eps","arctic")
plot  = gsn_csm_xy (wks,f1_time,f1_t(:,0,0,0),res)
delete(wks)

time_axis_labels(f2_time,res,restick)
wks   = gsn_open_wks ("eps","nh61")
plot  = gsn_csm_xy (wks,f2_time,f2_u(:,0,0,0),res)
delete(wks)

time_axis_labels(f3_time,res,restick)
wks   = gsn_open_wks ("eps","northpole")
plot  = gsn_csm_xy (wks,f3_time,f3_t(:,0,0,0),res)
delete(wks)

time_axis_labels(f4_time,res,restick)
res@tiYAxisString="Sea-level pressure"
wks   = gsn_open_wks ("eps","sibhigh")
plot  = gsn_csm_xy (wks,f4_time,f4_slp(:,0,0)/100.0,res)
delete(wks)