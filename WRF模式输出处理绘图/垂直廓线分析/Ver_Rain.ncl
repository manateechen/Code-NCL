load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

rainfile=addfile("RAIN.nc","r")

h=(/1,50,100,150,200,250,300,350,400,450,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,15500,16000,16500,17000,17500,18000,18500,19000,19500,20000/)
height=h/1000.0
rain_case=new((/13,50/),"float")
rain_case(0,:)=rainfile->QRAIN_case01
rain_case(1,:)=rainfile->QRAIN_case02
rain_case(2,:)=rainfile->QRAIN_case03
rain_case(3,:)=rainfile->QRAIN_case04
rain_case(4,:)=rainfile->QRAIN_case05
rain_case(5,:)=rainfile->QRAIN_case06
rain_case(6,:)=rainfile->QRAIN_case07
rain_case(7,:)=rainfile->QRAIN_case08
rain_case(8,:)=rainfile->QRAIN_case09
rain_case(9,:)=rainfile->QRAIN_case10
rain_case(10,:)=rainfile->QRAIN_case11
rain_case(11,:)=rainfile->QRAIN_case13
rain_case(12,:)=rainfile->QRAIN_case14


res=True
res @gsnMaximize=True
res @vpWidthF=0.40
res @vpHeightF=0.7
res @xyLineThicknessF=3.0 
res @xyLineColors=(/1,2,24,38,71,86,108,119,134,168,184,216/) 
res @xyExplicitLegendLabels = (/"case01","case02","case03","case04","case05","case06","case07","case08","case09","case10","case11","case12","case13"/)
res@pmLegendWidthF         = 0.12       
 res@pmLegendHeightF        = 0.25               
 res@lgLabelFontHeightF     = .01                 
 res@pmLegendSide           = "Top"
 res@pmLegendParallelPosF   = .80  
  res@pmLegendOrthogonalPosF = -0.4
res @pmLegendDisplayMode    = "Always"
res@tiYAxisString="km"
res@tiXAxisString=rain_case@description+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"RAIN")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,rain_case,height,res)
