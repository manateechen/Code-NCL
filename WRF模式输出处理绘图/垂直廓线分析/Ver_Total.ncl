load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

cloudfile=addfile("CLOUD.nc","r")
graupfile=addfile("GRAUP.nc","r")
icefile=addfile("ICE.nc","r")
rainfile=addfile("RAIN.nc","r")
snowfile=addfile("SNOW.nc","r")
vaporfile=addfile("VAPOR.nc","r")

h=(/1,50,100,150,200,250,300,350,400,450,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,15500,16000,16500,17000,17500,18000,18500,19000,19500,20000/)
height=h/1000.0

cloud_case=new((/13,50/),"float")
cloud_case(0,:)=cloudfile->QCLOUD_case01
cloud_case(1,:)=cloudfile->QCLOUD_case02
cloud_case(2,:)=cloudfile->QCLOUD_case03
cloud_case(3,:)=cloudfile->QCLOUD_case04
cloud_case(4,:)=cloudfile->QCLOUD_case05
cloud_case(5,:)=cloudfile->QCLOUD_case06
cloud_case(6,:)=cloudfile->QCLOUD_case07
cloud_case(7,:)=cloudfile->QCLOUD_case08
cloud_case(8,:)=cloudfile->QCLOUD_case09
cloud_case(9,:)=cloudfile->QCLOUD_case10
cloud_case(10,:)=cloudfile->QCLOUD_case11
cloud_case(11,:)=cloudfile->QCLOUD_case13
cloud_case(12,:)=cloudfile->QCLOUD_case14

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

snow_case=new((/13,50/),"float")
snow_case(0,:)=snowfile->QSNOW_case01
snow_case(1,:)=snowfile->QSNOW_case02
snow_case(2,:)=snowfile->QSNOW_case03
snow_case(3,:)=snowfile->QSNOW_case04
snow_case(4,:)=snowfile->QSNOW_case05
snow_case(5,:)=snowfile->QSNOW_case06
snow_case(6,:)=snowfile->QSNOW_case07
snow_case(7,:)=snowfile->QSNOW_case08
snow_case(8,:)=snowfile->QSNOW_case09
snow_case(9,:)=snowfile->QSNOW_case10
snow_case(10,:)=snowfile->QSNOW_case11
snow_case(11,:)=snowfile->QSNOW_case13
snow_case(12,:)=snowfile->QSNOW_case14

total=new((/13,50/),"float")
total=cloud_case+graup_case+ice_case+rain_case+snow_case

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
res@tiXAxisString="Total Cloud"+"(10~S~-2~N~g/kg)"
wks=gsn_open_wks("eps" ,"Total")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,total,height,res)
