load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

icefile=addfile("ICE.nc","r")

h=(/1,50,100,150,200,250,300,350,400,450,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,15500,16000,16500,17000,17500,18000,18500,19000,19500,20000/)
height=h/1000.0
ice_case=new((/13,50/),"float")
ice_case(0,:)=icefile->QICE_case01
ice_case(1,:)=icefile->QICE_case02
ice_case(2,:)=icefile->QICE_case03
ice_case(3,:)=icefile->QICE_case04
ice_case(4,:)=icefile->QICE_case05
ice_case(5,:)=icefile->QICE_case06
ice_case(6,:)=icefile->QICE_case07
ice_case(7,:)=icefile->QICE_case08
ice_case(8,:)=icefile->QICE_case09
ice_case(9,:)=icefile->QICE_case10
ice_case(10,:)=icefile->QICE_case11
ice_case(11,:)=icefile->QICE_case13
ice_case(12,:)=icefile->QICE_case14


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
  res@pmLegendOrthogonalPosF = -1.0
res @pmLegendDisplayMode    = "Always"
res@tiYAxisString="km"
res@tiXAxisString=ice_case@description+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"ICE")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,ice_case,height,res)
