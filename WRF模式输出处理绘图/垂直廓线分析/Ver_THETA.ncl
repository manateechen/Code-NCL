load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

thetafile=addfile("THETA.nc","r")
ncep=addfile("sph_theta.nc","r")

h=(/300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,775.0,800.0,825.0,850.0,875.0,900.0,925.0,950.0,975.0,1000.0/)
height=h
theta_case=new((/14,20/),"float")
theta_case(0,:)=thetafile->THETA_case01
theta_case(1,:)=thetafile->THETA_case02
theta_case(2,:)=thetafile->THETA_case03
theta_case(3,:)=thetafile->THETA_case04
theta_case(4,:)=thetafile->THETA_case05
theta_case(5,:)=thetafile->THETA_case06
theta_case(6,:)=thetafile->THETA_case07
theta_case(7,:)=thetafile->THETA_case08
theta_case(8,:)=thetafile->THETA_case09
theta_case(9,:)=thetafile->THETA_case10
theta_case(10,:)=thetafile->THETA_case11
theta_case(11,:)=thetafile->THETA_case13
theta_case(12,:)=thetafile->THETA_case14
theta_case(13,:)=ncep->theta(::-1)

res=True
res @gsnMaximize=True
res @vpWidthF=0.40
res @vpHeightF=0.7
res @xyLineThicknessF=3.0 
res @xyLineColors=(/1,2,24,38,71,86,108,119,134,168,184,216/) 
res @xyExplicitLegendLabels = (/"Simulation01","Simulation02","Simulation03","Simulation04","Simulation05","Simulation06","Simulation07","Simulation08","Simulation09","Simulation10","Simulation11","Simulation12","Simulation13","NCEP-DOE"/)
res@trYReverse=True
res@pmLegendWidthF         = 0.12       
 res@pmLegendHeightF        = 0.25               
 res@lgLabelFontHeightF     = .01                 
 res@pmLegendSide           = "Top"
 res@pmLegendParallelPosF   = .80  
  res@pmLegendOrthogonalPosF = -1.0
res @pmLegendDisplayMode    = "Always"
res@tiYAxisString="hPa"
res@tiXAxisString=theta_case@description
wks=gsn_open_wks("eps" ,"THETA")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,theta_case,height,res)
