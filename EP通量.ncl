; Draw EP Flux and its divergence or acceleration
; QQF
; 2014.12.22

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"      	
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"           
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl" 

datafile=addfile("20080710_00Z_T85LR_ECMWF_876601148.nc","r")

u_hybrid=datafile->U
v_hybrid=datafile->V
t_hybrid=datafile->T
PS=datafile->PS      ;Pa    
P0=datafile->P0      ;Pa
hyam=datafile->hyam
hybm=datafile->hybm
lat=datafile->lat
lon=datafile->lon
lev=datafile->lev
PHIS=datafile->PHIS
nlev=dimsizes(lev)
nlat=dimsizes(lat)
nlon=dimsizes(lon)

p_level=10^fspan(0,3,61) 
n_plev=dimsizes(p_level)
intyp=3
kxtrp=True
tbot=t_hybrid(:,nlev-1,:,:)

sf=5

varflag=1
T=vinth2p_ecmwf(t_hybrid,hyam,hybm,p_level,PS,intyp,P0/100.0,1,kxtrp,varflag,tbot,PHIS)
varflg = 0
U=vinth2p_ecmwf(u_hybrid,hyam,hybm,p_level,PS,intyp,P0/100.0,1,kxtrp,varflag,tbot,PHIS)
V=vinth2p_ecmwf(v_hybrid,hyam,hybm,p_level,PS,intyp,P0/100.0,1,kxtrp,varflag,tbot,PHIS)

R=287.0
Cp=1.005*(10^3)
theta=T*(1000.0/conform(T,p_level,1))^(R/Cp)
copy_VarMeta(T,theta)

theta_zonal_mean=dim_avg_n_Wrap(theta,3)                        ;0 is time, 1 is level, 2 is lat, 3 is lon
Theta_p=center_finite_diff_n(theta_zonal_mean,p_level*100.0,False,0,1)
copy_VarMeta(theta_zonal_mean,Theta_p)

u_zonal_mean=dim_avg_n_Wrap(U,3)
v_zonal_mean=dim_avg_n_Wrap(V,3)

u_zonal_anomaly=dim_rmvmean_n_Wrap(U,3)
v_zonal_anomaly=dim_rmvmean_n_Wrap(V,3)
theta_zonal_anomaly=dim_rmvmean_n_Wrap(theta,3)

uv=u_zonal_anomaly*v_zonal_anomaly
copy_VarMeta(u_zonal_anomaly,uv)
uv_zonal_mean=dim_avg_n_Wrap(uv,3)

vtheta=v_zonal_anomaly*theta_zonal_anomaly
copy_VarMeta(theta_zonal_anomaly,vtheta)
vtheta_zonal_mean=dim_avg_n_Wrap(vtheta,3)

a=6.37122e06
pi=3.14159265358979
phi=lat*pi/180.0
a_cos_phi=a*cos(phi)
a_sin_phi=a*sin(phi)
omega=7.2921e-5
f=2.0*omega*sin(phi)

latfac=a_cos_phi*cos(phi)

F_phi=-uv_zonal_mean*conform(uv_zonal_mean,latfac,2)
copy_VarMeta(uv_zonal_mean,F_phi)
F_p=conform(vtheta_zonal_mean,f*a_cos_phi,2)*vtheta_zonal_mean/Theta_p
copy_VarMeta(vtheta_zonal_mean,F_p)

EP_div_phi=center_finite_diff_n(F_phi,a_sin_phi,False,0,2)
copy_VarMeta(F_phi,EP_div_phi)
EP_div_p=center_finite_diff_n(F_p,p_level*100.0,False,0,1)
copy_VarMeta(F_p,EP_div_p)
EP_div=EP_div_phi+EP_div_p
copy_VarMeta(F_p,EP_div)

dudt=86400.0*EP_div/conform(EP_div,a*cos(phi),2) 
copy_VarMeta(EP_div,dudt)

F_p=F_p*conform(F_p,cos(phi),2)   
F_phi=F_phi/a

F_p=F_p/1.0e5
F_phi=F_phi/pi

rhofac=sqrt(1000.0/p_level)
F_p=F_p*conform(F_p,rhofac,1)
F_phi=F_phi*conform(F_phi,rhofac,1)

strat1 = new(n_plev,float)
strat1=1
ind_100=ind(p_level.le.100)
strat1(ind_100)=sf
stratmask=conform(F_p,strat1,1)
F_p=F_p*stratmask
F_phi=F_phi*stratmask

res_vec_int=True
res_vec_int @gsnDraw=False               
res_vec_int @gsnFrame=False 
res_vec_int @gsnSpreadColors=True	
res_vec_int @gsnLeftString=""
res_vec_int @gsnYAxisIrregular2Log = True
res_vec_int @pmLabelBarDisplayMode="Always"       
res_vec_int @pmLabelBarWidthF=0.08        
res_vec_int @lbPerimOn=False       
res_vec_int @lbLabelBarOn=False
res_vec_int @trYReverse=True              
res_vec_int @tiMainString="EP Flux"		    
res_vec_int @tiMainFontHeightF=0.0185
res_vec_int @tiXAxisString="latitude"         
res_vec_int @tiYAxisString="pressure (mb)  log-scale"         
res_vec_int @tiXAxisFontHeightF=0.0185
res_vec_int @tiYAxisFontHeightF=0.0185
res_vec_int @vpWidthF=0.60
res_vec_int @vpHeightF=0.35 
res_vec_int @vcRefMagnitudeF=200             
res_vec_int @vcRefLengthF=0.05              
res_vec_int @vcMonoLineArrowColor=False              
res_vec_int @vcLevelSelectionMode="ManualLevels"
res_vec_int @vcLevelSpacingF=25.0
res_vec_int @vcMinLevelValF=0.0
res_vec_int @vcMaxLevelValF=400.0
res_vec_int @vcRefAnnoOn=True        
 
res_con_int=True
res_con_int @gsnContourLineThicknessesScale=0.5
res_con_int @gsnYAxisIrregular2Log = True
res_con_int @gsnDraw=False
res_con_int @gsnFrame=False
res_con_int @gsnLeftString=""
res_con_int @gsnContourZeroLineThicknessF = 0.0
res_con_int @gsnContourPosLineDashPattern = 1
res_con_int @trYReverse=True   
res_con_int @vpWidthF=0.60
res_con_int @vpHeightF=0.35 
res_con_int @cnSmoothingOn=True
res_con_int @cnLineLabelsOn=False

res=True
res @gsnDraw=False
res @gsnFrame=False
res @gsnLeftString=""
res @gsnContourNegLineDashPattern = 1
res @trYReverse=True   
res @vpWidthF=0.60
res @vpHeightF=0.35 
res @cnLineLabelsOn=False
res @cnSmoothingOn=True
res @cnLineThicknessF=3.0
res @cnInfoLabelOn   = False

opt = True
opt @gsnShadeLow = 184                    
opt @gsnShadeHigh= 49

wksvec_int=gsn_open_wks("eps","EP Flux")
gsn_define_colormap(wksvec_int,"rainbow") 
plotvec = gsn_csm_vector(wksvec_int,F_phi(time|0,lev_p|20:n_plev-1,lat|0:nlat-1:4),F_p(time|0,lev_p|20:n_plev-1,lat|0:nlat-1:4),res_vec_int) 
res_con_int @cnLevelSpacingF        =   200     
plotvec2 = gsn_csm_contour(wksvec_int,EP_div(time|0,lev_p|20:n_plev-1,lat|0:nlat-1:4),res_con_int)  
plotvec2s = gsn_contour_shade(plotvec2,-200,100,opt)  
plotvec3 = gsn_csm_contour(wksvec_int,u_zonal_mean(time|0,lev_p|20:n_plev-1,lat|0:nlat-1:4),res) 
overlay(plotvec2,plotvec3)
overlay(plotvec2,plotvec)
draw(plotvec2)

restxt = True 
restxt @txFontHeightF = 0.01    
restxt @txJust        = "CenterLeft" 
gsn_text_ndc(wksvec_int, "Qian Qifeng, GC Homework",0.12,0.37,restxt) 
frame(wksvec_int)