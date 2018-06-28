load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

sphfile=addfile("SPH.nc","r")
ncep=addfile("sph_theta.nc","r")

h=(/300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,775.0,800.0,825.0,850.0,875.0,900.0,925.0,950.0,975.0,1000.0/)
height=h
sph_case=new((/14,20/),"float")
sph_case(0,:)=sphfile->SPH_case01
sph_case(1,:)=sphfile->SPH_case02
sph_case(2,:)=sphfile->SPH_case03
sph_case(3,:)=sphfile->SPH_case04
sph_case(4,:)=sphfile->SPH_case05
sph_case(5,:)=sphfile->SPH_case06
sph_case(6,:)=sphfile->SPH_case07
sph_case(7,:)=sphfile->SPH_case08
sph_case(8,:)=sphfile->SPH_case09
sph_case(9,:)=sphfile->SPH_case10
sph_case(10,:)=sphfile->SPH_case11
sph_case(11,:)=sphfile->SPH_case13
sph_case(12,:)=sphfile->SPH_case14
sph_case(13,:)=ncep->q(::-1)

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
  res@pmLegendOrthogonalPosF = -0.4
res @pmLegendDisplayMode    = "Always"
res@tiYAxisString="hPa"
res@tiXAxisString="Specific Humidity (g/Kg)"
wks=gsn_open_wks("eps" ,"SPH")
gsn_define_colormap(wks,"ncl_default")
plot=gsn_csm_xy(wks,sph_case,height,res)
