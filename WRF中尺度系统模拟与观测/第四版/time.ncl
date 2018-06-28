load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"                   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wks=gsn_open_wks("eps" ,"time")
gsn_define_colormap(wks,"ncl_default")
ncfile=addfile("time.nc","r")

t2=ncfile->t2
rain=ncfile->rain

time=ispan(0,1440,10)
time@description="Time"
time@long_name="Time"
time@calendar="standard"
time@units="minutes since 2014-05-21 12:00:00"

res=True
res@gsnFrame           = False 
res@gsnDraw              = False
res@trXMaxF=1440
res@tmXTOn      = False
res@pmLegendDisplayMode    = "Never"
res@xyLineThicknessF   = 3.0
res@vpWidthF           = 0.6
res@vpHeightF          = 0.13
res@tiMainString=" "
res@tiMainFontHeightF = 0.015
res@tiMainOffsetYF=-0.005

restick           = True
restick@ttmFormat = "%D %H:%M"
restick@ttmMajorStride=24
time_axis_labels(time,res,restick)

plot = new(14,graphic)

res@trYMinF=20
res@trYMaxF=30
res@tiMainString="MOR"
plot(0) = gsn_csm_xy(wks,time,t2(0,:),res)
res@trYMinF=0
res@trYMaxF=20
plot(1) = gsn_csm_xy(wks,time,rain(0,:),res)

res@trYMinF=20
res@trYMaxF=30
res@tiMainString="MOR_H" 
plot(2) = gsn_csm_xy(wks,time,t2(1,:),res)
res@trYMinF=0
res@trYMaxF=20
plot(3) = gsn_csm_xy(wks,time,rain(1,:),res)

res@trYMinF=20
res@trYMaxF=30
res@tiMainString="WDM6" 
plot(4) = gsn_csm_xy(wks,time,t2(2,:),res)
res@trYMinF=0
res@trYMaxF=20
plot(5) = gsn_csm_xy(wks,time,rain(2,:),res)

res@trYMinF=20
res@trYMaxF=30
res@tiMainString="WDM6_H" 
plot(6) = gsn_csm_xy(wks,time,t2(3,:),res)
res@trYMinF=0
res@trYMaxF=20
plot(7) = gsn_csm_xy(wks,time,rain(3,:),res)

res@trYMinF=20
res@trYMaxF=30
res@tiMainString="WSM6" 
plot(8) = gsn_csm_xy(wks,time,t2(4,:),res)
res@trYMinF=0
res@trYMaxF=20
plot(9) = gsn_csm_xy(wks,time,rain(4,:),res)

res@trYMinF=20
res@trYMaxF=30
res@tiMainString="LIN" 
plot(10) = gsn_csm_xy(wks,time,t2(5,:),res)
res@trYMinF=0
res@trYMaxF=20
plot(11) = gsn_csm_xy(wks,time,rain(5,:),res)

res@trYMinF=20
res@trYMaxF=30
res@tiMainString="THO" 
plot(12) = gsn_csm_xy(wks,time,t2(6,:),res)
res@trYMinF=0
res@trYMaxF=20
plot(13) = gsn_csm_xy(wks,time,rain(6,:),res)

gsn_panel(wks,plot,(/7,2/),False)  
