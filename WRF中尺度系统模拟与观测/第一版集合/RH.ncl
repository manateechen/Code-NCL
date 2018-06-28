load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

wrff1=addfile("wrfout_d03_2013-05-10_23:50:00","r")
xlat = wrf_user_getvar(wrff1,"XLAT",0)
xlon = wrf_user_getvar(wrff1,"XLONG",0)

rh=wrf_user_getvar(wrff1,"rh",-1)

zz=(/1,50,100,150,200,250,300,350,400,450,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,15500,16000,16500,17000,17500,18000,18500,19000,19500,20000/) ;unit:m
z_out=zz/1000.0

opts=True
opts@extrapolate=True

RH=wrf_user_vert_interp(wrff1,rh,"ght_agl",z_out,opts)

lat=21.7
lon=118.0

nz=dimsizes(zz)
for_line=new(nz,"float")

tmp=rcm2points_Wrap(xlat,xlon,RH,lat,lon,0)
for_line=tmp(0,:,0)

res=True
res@gsnMaximize=True
res@vpWidthF=0.40
res@vpHeightF=0.7
res@xyLineThicknessF=3.0 
;res@xyLineColors=(/1,38,108,216/) 
;res@xyExplicitLegendLabels = (/"QRAIN","QSNOW","QCLOUD","QICE"/)
;res@pmLegendWidthF         = 0.12       
;res@pmLegendHeightF        = 0.15               
res@lgLabelFontHeightF     = .01                 
;res@pmLegendSide           = "Top"
;res@pmLegendParallelPosF   = .80  
;res@pmLegendOrthogonalPosF = -0.35
;res@pmLegendDisplayMode    = "Always"
res@tiYAxisString="km"
res@tiXAxisString="units: %"
res@tiMainString="2013-05-10_23:50:00"
res@gsnLeftString="lat: "+lat+"N; lon: "+lon+"E"

wks = gsn_open_wks("eps", "2013-05-10_23:50:00")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,for_line,z_out,res)

