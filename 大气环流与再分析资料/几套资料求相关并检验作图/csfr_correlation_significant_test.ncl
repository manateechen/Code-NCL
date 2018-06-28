load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

cor_u_file=addfile("cor_u_csrf.nc","r")
cor_v_file=addfile("cor_v_csrf.nc","r")
cor_hgt_file=addfile("cor_hgt_csrf.nc","r")
cor_t_file=addfile("cor_t_csrf.nc","r")
cor_rh_file=addfile("cor_rh_csrf.nc","r")

alpha=2.042

u_correlation_year=cor_u_file->u_correlation_year
u_correlation_spring=cor_u_file->u_correlation_spring
u_correlation_summer=cor_u_file->u_correlation_summer
u_correlation_autumn=cor_u_file->u_correlation_autumn
u_correlation_winter=cor_u_file->u_correlation_winter
printVarSummary(u_correlation_year)

t_test_u_year=cor_u_file->t_test_u_year
t_test_u_spring=cor_u_file->t_test_u_spring
t_test_u_summer=cor_u_file->t_test_u_summer
t_test_u_autumn=cor_u_file->t_test_u_autumn
t_test_u_winter=cor_u_file->t_test_u_winter
printVarSummary(t_test_u_year)

t_test_u_year=mask(t_test_u_year,t_test_u_year.lt.alpha,False)
t_test_u_spring=mask(t_test_u_spring,t_test_u_spring.lt.alpha,False)
t_test_u_summer=mask(t_test_u_summer,t_test_u_summer.lt.alpha,False)
t_test_u_autumn=mask(t_test_u_autumn,t_test_u_autumn.lt.alpha,False)
t_test_u_winter=mask(t_test_u_winter,t_test_u_winter.lt.alpha,False)
printVarSummary(t_test_u_year)

v_correlation_year=cor_v_file->v_correlation_year
v_correlation_spring=cor_v_file->v_correlation_spring
v_correlation_summer=cor_v_file->v_correlation_summer
v_correlation_autumn=cor_v_file->v_correlation_autumn
v_correlation_winter=cor_v_file->v_correlation_winter
printVarSummary(v_correlation_year)

t_test_v_year=cor_v_file->t_test_v_year
t_test_v_spring=cor_v_file->t_test_v_spring
t_test_v_summer=cor_v_file->t_test_v_summer
t_test_v_autumn=cor_v_file->t_test_v_autumn
t_test_v_winter=cor_v_file->t_test_v_winter
printVarSummary(t_test_v_year)

t_test_v_year=mask(t_test_v_year,t_test_v_year.lt.alpha,False)
t_test_v_spring=mask(t_test_v_spring,t_test_v_spring.lt.alpha,False)
t_test_v_summer=mask(t_test_v_summer,t_test_v_summer.lt.alpha,False)
t_test_v_autumn=mask(t_test_v_autumn,t_test_v_autumn.lt.alpha,False)
t_test_v_winter=mask(t_test_v_winter,t_test_v_winter.lt.alpha,False)
printVarSummary(t_test_v_year)

hgt_correlation_year=cor_hgt_file->hgt_correlation_year
hgt_correlation_spring=cor_hgt_file->hgt_correlation_spring
hgt_correlation_summer=cor_hgt_file->hgt_correlation_summer
hgt_correlation_autumn=cor_hgt_file->hgt_correlation_autumn
hgt_correlation_winter=cor_hgt_file->hgt_correlation_winter
printVarSummary(hgt_correlation_year)

t_test_hgt_year=cor_hgt_file->t_test_hgt_year
t_test_hgt_spring=cor_hgt_file->t_test_hgt_spring
t_test_hgt_summer=cor_hgt_file->t_test_hgt_summer
t_test_hgt_autumn=cor_hgt_file->t_test_hgt_autumn
t_test_hgt_winter=cor_hgt_file->t_test_hgt_winter
printVarSummary(t_test_hgt_year)

t_test_hgt_year=mask(t_test_hgt_year,t_test_hgt_year.lt.alpha,False)
t_test_hgt_spring=mask(t_test_hgt_spring,t_test_hgt_spring.lt.alpha,False)
t_test_hgt_summer=mask(t_test_hgt_summer,t_test_hgt_summer.lt.alpha,False)
t_test_hgt_autumn=mask(t_test_hgt_autumn,t_test_hgt_autumn.lt.alpha,False)
t_test_hgt_winter=mask(t_test_hgt_winter,t_test_hgt_winter.lt.alpha,False)
printVarSummary(t_test_hgt_year)

t_correlation_year=cor_t_file->t_correlation_year
t_correlation_spring=cor_t_file->t_correlation_spring
t_correlation_summer=cor_t_file->t_correlation_summer
t_correlation_autumn=cor_t_file->t_correlation_autumn
t_correlation_winter=cor_t_file->t_correlation_winter
printVarSummary(t_correlation_year)

t_test_t_year=cor_t_file->t_test_t_year
t_test_t_spring=cor_t_file->t_test_t_spring
t_test_t_summer=cor_t_file->t_test_t_summer
t_test_t_autumn=cor_t_file->t_test_t_autumn
t_test_t_winter=cor_t_file->t_test_t_winter
printVarSummary(t_test_t_year)

t_test_t_year=mask(t_test_t_year,t_test_t_year.lt.alpha,False)
t_test_t_spring=mask(t_test_t_spring,t_test_t_spring.lt.alpha,False)
t_test_t_summer=mask(t_test_t_summer,t_test_t_summer.lt.alpha,False)
t_test_t_autumn=mask(t_test_t_autumn,t_test_t_autumn.lt.alpha,False)
t_test_t_winter=mask(t_test_t_winter,t_test_t_winter.lt.alpha,False)
printVarSummary(t_test_t_year)

rh_correlation_year=cor_rh_file->rh_correlation_year
rh_correlation_spring=cor_rh_file->rh_correlation_spring
rh_correlation_summer=cor_rh_file->rh_correlation_summer
rh_correlation_autumn=cor_rh_file->rh_correlation_autumn
rh_correlation_winter=cor_rh_file->rh_correlation_winter
printVarSummary(rh_correlation_year)

t_test_rh_year=cor_rh_file->t_test_rh_year
t_test_rh_spring=cor_rh_file->t_test_rh_spring
t_test_rh_summer=cor_rh_file->t_test_rh_summer
t_test_rh_autumn=cor_rh_file->t_test_rh_autumn
t_test_rh_winter=cor_rh_file->t_test_rh_winter
printVarSummary(t_test_rh_year)

t_test_rh_year=mask(t_test_rh_year,t_test_rh_year.lt.alpha,False)
t_test_rh_spring=mask(t_test_rh_spring,t_test_rh_spring.lt.alpha,False)
t_test_rh_summer=mask(t_test_rh_summer,t_test_rh_summer.lt.alpha,False)
t_test_rh_autumn=mask(t_test_rh_autumn,t_test_rh_autumn.lt.alpha,False)
t_test_rh_winter=mask(t_test_rh_winter,t_test_rh_winter.lt.alpha,False)
printVarSummary(t_test_rh_year)

z=17
lev=(/10,20,30,50,70,100,150,200,250,300,400,500,600,700,850,925,1000/)
lev_rh=(/100,150,200,250,300,400,500,600,700,850,925,1000/)

res=True
res@pmTickMarkDisplayMode="Always"         
res@gsnSpreadColors=True  
res@mpDataSetName="Earth..4"
res@mpDataBaseVersion="MediumRes"
res@mpOutlineOn=True
res@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 

res@mpLimitMode="LatLon"
res@mpMinLatF=0.0
res@mpMaxLatF=70.0
res@mpMinLonF=50
res@mpMaxLonF=180


res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
;res@cnLevelSelectionMode="ExplicitLevels"
;res@cnLevels=(/-1.0,-0.9,-0.8,-0.7,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0/)

res@cnInfoLabelOn=False

resshade=True
resshade@pmTickMarkDisplayMode="Always"         
resshade@cnFillOn=True
resshade@cnLinesOn=True
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False       
resshade@cnMonoFillColor=True        
resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/2.042,2.750/)
;resshade@lbLabelBarOn=False
resshade@cnInfoLabelOn=False

;resshade@mpLimitMode="LatLon"
;resshade@mpMinLatF=0.0
;resshade@mpMaxLatF=70.0
;resshade@mpMinLonF=50
;resshade@mpMaxLonF=180


plt_u_year=new(z,"graphic")
plt_u_spring=new(z,"graphic")
plt_u_summer=new(z,"graphic")
plt_u_autumn=new(z,"graphic")
plt_u_winter=new(z,"graphic")
plt_v_year=new(z,"graphic")
plt_v_spring=new(z,"graphic")
plt_v_summer=new(z,"graphic")
plt_v_autumn=new(z,"graphic")
plt_v_winter=new(z,"graphic")
plt_hgt_year=new(z,"graphic")
plt_hgt_spring=new(z,"graphic")
plt_hgt_summer=new(z,"graphic")
plt_hgt_autumn=new(z,"graphic")
plt_hgt_winter=new(z,"graphic")
plt_t_year=new(z,"graphic")
plt_t_spring=new(z,"graphic")
plt_t_summer=new(z,"graphic")
plt_t_autumn=new(z,"graphic")
plt_t_winter=new(z,"graphic")
plt_rh_year=new(z,"graphic")
plt_rh_spring=new(z,"graphic")
plt_rh_summer=new(z,"graphic")
plt_rh_autumn=new(z,"graphic")
plt_rh_winter=new(z,"graphic")

do i=0,z-1
    
    wks=gsn_open_wks("png","cor_u_"+lev(i)+"_Annual")
    res@tiMainString="Auunal U Wind Component Correlation at "+lev(i)+"hPa"
    plt_u_year(i)=gsn_csm_contour_map_overlay(wks,u_correlation_year(i,:,:),t_test_u_year(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_u_"+lev(i)+"_Spring")
    res@tiMainString="Spring U Wind Component Correlation at "+lev(i)+"hPa"
    plt_u_spring(i)=gsn_csm_contour_map_overlay(wks,u_correlation_spring(i,:,:),t_test_u_spring(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_u_"+lev(i)+"_Summer")
    res@tiMainString="Summer U Wind Component Correlation at "+lev(i)+"hPa"
    plt_u_summer(i)=gsn_csm_contour_map_overlay(wks,u_correlation_summer(i,:,:),t_test_u_summer(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_u_"+lev(i)+"_Autumn")
    res@tiMainString="Autumn U Wind Component Correlation at "+lev(i)+"hPa"
    plt_u_autumn(i)=gsn_csm_contour_map_overlay(wks,u_correlation_autumn(i,:,:),t_test_u_autumn(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_u_"+lev(i)+"_Winter")
    res@tiMainString="Winter U Wind Component Correlation at "+lev(i)+"hPa"
    plt_u_winter(i)=gsn_csm_contour_map_overlay(wks,u_correlation_winter(i,:,:),t_test_u_winter(i,:,:),res,resshade)
    delete(wks)

    wks=gsn_open_wks("png","cor_v_"+lev(i)+"_Annual")
    res@tiMainString="Auunal V Wind Component Correlation at "+lev(i)+"hPa"
    plt_v_year(i)=gsn_csm_contour_map_overlay(wks,v_correlation_year(i,:,:),t_test_v_year(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_v_"+lev(i)+"_Spring")
    res@tiMainString="Spring V Wind Component Correlation at "+lev(i)+"hPa"
    plt_v_spring(i)=gsn_csm_contour_map_overlay(wks,v_correlation_spring(i,:,:),t_test_v_spring(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_v_"+lev(i)+"_Summer")
    res@tiMainString="Summer V Wind Component Correlation at "+lev(i)+"hPa"
    plt_v_summer(i)=gsn_csm_contour_map_overlay(wks,v_correlation_summer(i,:,:),t_test_v_summer(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_v_"+lev(i)+"_Autumn")
    res@tiMainString="Autumn V Wind Component Correlation at "+lev(i)+"hPa"
    plt_v_autumn(i)=gsn_csm_contour_map_overlay(wks,v_correlation_autumn(i,:,:),t_test_v_autumn(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_v_"+lev(i)+"_Winter")
    res@tiMainString="Winter V Wind Component Correlation at "+lev(i)+"hPa"
    plt_v_winter(i)=gsn_csm_contour_map_overlay(wks,v_correlation_winter(i,:,:),t_test_v_winter(i,:,:),res,resshade)
    delete(wks)
 
    wks=gsn_open_wks("png","cor_hgt_"+lev(i)+"_Annual")
    res@tiMainString="Auunal Geopotential Height Correlation at "+lev(i)+"hPa"
    plt_hgt_year(i)=gsn_csm_contour_map_overlay(wks,hgt_correlation_year(i,:,:),t_test_hgt_year(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_hgt_"+lev(i)+"_Spring")
    res@tiMainString="Spring Geopotential Height Correlation at "+lev(i)+"hPa"
    plt_hgt_spring(i)=gsn_csm_contour_map_overlay(wks,hgt_correlation_spring(i,:,:),t_test_hgt_spring(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_hgt_"+lev(i)+"_Summer")
    res@tiMainString="Summer Geopotential Height Correlation at "+lev(i)+"hPa"
    plt_hgt_summer(i)=gsn_csm_contour_map_overlay(wks,hgt_correlation_summer(i,:,:),t_test_hgt_summer(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_hgt_"+lev(i)+"_Autumn")
    res@tiMainString="Autumn Geopotential Height Correlation at "+lev(i)+"hPa"
    plt_hgt_autumn(i)=gsn_csm_contour_map_overlay(wks,hgt_correlation_autumn(i,:,:),t_test_hgt_autumn(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_hgt_"+lev(i)+"_Winter")
    res@tiMainString="Winter Geopotential Height Correlation at "+lev(i)+"hPa"
    plt_hgt_winter(i)=gsn_csm_contour_map_overlay(wks,hgt_correlation_winter(i,:,:),t_test_hgt_winter(i,:,:),res,resshade)
    delete(wks)
 
    wks=gsn_open_wks("png","cor_t_"+lev(i)+"_Annual")
    res@tiMainString="Auunal Temperature Correlation at "+lev(i)+"hPa"
    plt_t_year(i)=gsn_csm_contour_map_overlay(wks,t_correlation_year(i,:,:),t_test_t_year(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_t_"+lev(i)+"_Spring")
    res@tiMainString="Spring Temperature Correlation at "+lev(i)+"hPa"
    plt_t_spring(i)=gsn_csm_contour_map_overlay(wks,t_correlation_spring(i,:,:),t_test_t_spring(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_t_"+lev(i)+"_Summer")
    res@tiMainString="Summer Temperature Correlation at "+lev(i)+"hPa"
    plt_t_summer(i)=gsn_csm_contour_map_overlay(wks,t_correlation_summer(i,:,:),t_test_t_summer(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_t_"+lev(i)+"_Autumn")
    res@tiMainString="Autumn Temperature Correlation at "+lev(i)+"hPa"
    plt_t_autumn(i)=gsn_csm_contour_map_overlay(wks,t_correlation_autumn(i,:,:),t_test_t_autumn(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_t_"+lev(i)+"_Winter")
    res@tiMainString="Winter Temperature Correlation at "+lev(i)+"hPa"
    plt_t_winter(i)=gsn_csm_contour_map_overlay(wks,t_correlation_winter(i,:,:),t_test_t_winter(i,:,:),res,resshade)
    delete(wks)
   
    wks=gsn_open_wks("png","cor_rh_"+lev_rh(i)+"_Annual")
    res@tiMainString="Auunal Relative Humidity Correlation at "+lev_rh(i)+"hPa"
    plt_rh_year(i)=gsn_csm_contour_map_overlay(wks,rh_correlation_year(i,:,:),t_test_rh_year(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_rh_"+lev_rh(i)+"_Spring")
    res@tiMainString="Spring Relative Humidity Correlation at "+lev_rh(i)+"hPa"
    plt_rh_spring(i)=gsn_csm_contour_map_overlay(wks,rh_correlation_spring(i,:,:),t_test_rh_spring(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_rh_"+lev_rh(i)+"_Summer")
    res@tiMainString="Summer Relative Humidity Correlation at "+lev_rh(i)+"hPa"
    plt_rh_summer(i)=gsn_csm_contour_map_overlay(wks,rh_correlation_summer(i,:,:),t_test_rh_summer(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_rh_"+lev_rh(i)+"_Autumn")
    res@tiMainString="Autumn Relative Humidity Correlation at "+lev_rh(i)+"hPa"
    plt_rh_autumn(i)=gsn_csm_contour_map_overlay(wks,rh_correlation_autumn(i,:,:),t_test_rh_autumn(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_rh_"+lev_rh(i)+"_Winter")
    res@tiMainString="Winter Relative Humidity Correlation at "+lev_rh(i)+"hPa"
    plt_rh_winter(i)=gsn_csm_contour_map_overlay(wks,rh_correlation_winter(i,:,:),t_test_rh_winter(i,:,:),res,resshade)
    delete(wks)
  
end do    
    