load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

graupfile=addfile("GRAUP.nc","r")

h=(/1,50,100,150,200,250,300,350,400,450,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,15500,16000,16500,17000,17500,18000,18500,19000,19500,20000/)
height=h/1000.0
graup_case=new((/13,50/),"float")
graup_case(0,:)=graupfile->QGRAUP_case01
graup_case(1,:)=graupfile->QGRAUP_case02
graup_case(2,:)=graupfile->QGRAUP_case03
graup_case(3,:)=graupfile->QGRAUP_case04
graup_case(4,:)=graupfile->QGRAUP_case05
graup_case(5,:)=graupfile->QGRAUP_case06
graup_case(6,:)=graupfile->QGRAUP_case07
graup_case(7,:)=graupfile->QGRAUP_case08
graup_case(8,:)=graupfile->QGRAUP_case09
graup_case(9,:)=graupfile->QGRAUP_case10
graup_case(10,:)=graupfile->QGRAUP_case11
graup_case(11,:)=graupfile->QGRAUP_case13
graup_case(12,:)=graupfile->QGRAUP_case14


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
res@tiXAxisString=graup_case@description+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"GRAUP")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,graup_case,height,res)
