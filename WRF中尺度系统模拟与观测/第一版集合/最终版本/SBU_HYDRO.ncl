load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

wrff1=addfile("./SBU/wrfout_d03_2014-05-22_06:00:00","r")
xlat = wrf_user_getvar(wrff1,"XLAT",0)
xlon = wrf_user_getvar(wrff1,"XLONG",0)

QRAIN=wrf_user_getvar(wrff1,"QRAIN",-1)
QSNOW=wrf_user_getvar(wrff1,"QSNOW",-1)
QCLOUD=wrf_user_getvar(wrff1,"QCLOUD",-1)
QICE=wrf_user_getvar(wrff1,"QICE",-1)
z_out=wrf_user_getvar(wrff1,"ZNU",0)

nz=dimsizes(z_out)
for_line=new((/4,nz/),"float")

for_line(0,:)=QRAIN(0,:,251,230)
for_line(1,:)=QSNOW(0,:,251,230)
for_line(2,:)=QCLOUD(0,:,251,230)
for_line(3,:)=QICE(0,:,251,230)

for_line=for_line*1E5

res=True
res@gsnMaximize=True
res@vpWidthF=0.40
res@vpHeightF=0.7
res@xyLineThicknessF=3.0 
res@xyLineColors=(/1,38,108,216/) 
res@xyExplicitLegendLabels = (/"QRAIN","QSNOW","QCLOUD","QICE"/)
res@pmLegendWidthF         = 0.12       
res@pmLegendHeightF        = 0.15               
res@lgLabelFontHeightF     = .01                 
res@pmLegendSide           = "Top"
res@pmLegendParallelPosF   = .80  
res@pmLegendOrthogonalPosF = -0.35
res@pmLegendDisplayMode    = "Always"
res@tiYAxisString="eta"
res@tiXAxisString="units: 10~S~-2~N~g/kg"
res@tiMainString="2014-05-22_06:00:00"
res@trYReverse=True

wks = gsn_open_wks("eps", "SBU_HYDRO")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,for_line,z_out,res)

