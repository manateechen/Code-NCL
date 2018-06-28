load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

cor_t_file=addfile("cor_t.nc","r")
cor_r_file=addfile("cor_r.nc","r")

alpha=2.042

t_correlation_year=cor_t_file->t_correlation_year
t_correlation_spring=cor_t_file->t_correlation_spring
t_correlation_summer=cor_t_file->t_correlation_summer
t_correlation_autumn=cor_t_file->t_correlation_autumn
t_correlation_winter=cor_t_file->t_correlation_winter

t_test_t_year=cor_t_file->t_test_t_year
t_test_t_spring=cor_t_file->t_test_t_spring
t_test_t_summer=cor_t_file->t_test_t_summer
t_test_t_autumn=cor_t_file->t_test_t_autumn
t_test_t_winter=cor_t_file->t_test_t_winter

t_test_t_year=mask(t_test_t_year,t_test_t_year.lt.alpha,False)
t_test_t_spring=mask(t_test_t_spring,t_test_t_spring.lt.alpha,False)
t_test_t_summer=mask(t_test_t_summer,t_test_t_summer.lt.alpha,False)
t_test_t_autumn=mask(t_test_t_autumn,t_test_t_autumn.lt.alpha,False)
t_test_t_winter=mask(t_test_t_winter,t_test_t_winter.lt.alpha,False)

r_correlation_year=cor_r_file->r_correlation_year
r_correlation_spring=cor_r_file->r_correlation_spring
r_correlation_summer=cor_r_file->r_correlation_summer
r_correlation_autumn=cor_r_file->r_correlation_autumn
r_correlation_winter=cor_r_file->r_correlation_winter

t_test_r_year=cor_r_file->t_test_r_year
t_test_r_spring=cor_r_file->t_test_r_spring
t_test_r_summer=cor_r_file->t_test_r_summer
t_test_r_autumn=cor_r_file->t_test_r_autumn
t_test_r_winter=cor_r_file->t_test_r_winter

t_test_r_year=mask(t_test_r_year,t_test_r_year.lt.alpha,False)
t_test_r_spring=mask(t_test_r_spring,t_test_r_spring.lt.alpha,False)
t_test_r_summer=mask(t_test_r_summer,t_test_r_summer.lt.alpha,False)
t_test_r_autumn=mask(t_test_r_autumn,t_test_r_autumn.lt.alpha,False)
t_test_r_winter=mask(t_test_r_winter,t_test_r_winter.lt.alpha,False)

z=17
lev=(/1000,925,850,700,600,500,400,300,250,200,150,100,70,50,30,20,10/)

res=True
res@pmTickMarkDisplayMode="Always"         
res@gsnSpreadColors=True  
;res@gsnDraw=False
;res@gsnFrame=False
res@mpDataSetName="Earth..4"
res@mpDataBaseVersion="MediumRes"
res@mpOutlineOn=True
res@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/-1.0,-0.9,-0.8,-0.7,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0/)
res@mpLimitMode="LatLon"
res@mpMinLatF=0.0
res@mpMaxLatF=70.0
res@mpMinLonF=50
res@mpMaxLonF=180
res@cnInfoLabelOn=False

resshade=True
resshade@pmTickMarkDisplayMode="Always"         
;resshade@gsnDraw=False
;resshade@gsnFrame=False
resshade@cnFillOn=True
resshade@cnLinesOn=True
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False       
resshade@cnMonoFillColor=True        
resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/2.042,2.750/)
resshade@lbLabelBarOn=False
resshade@cnInfoLabelOn=False

plt_t_year=new(z,"graphic")
plt_t_spring=new(z,"graphic")
plt_t_summer=new(z,"graphic")
plt_t_autumn=new(z,"graphic")
plt_t_winter=new(z,"graphic")
plt_r_year=new(z,"graphic")
plt_r_spring=new(z,"graphic")
plt_r_summer=new(z,"graphic")
plt_r_autumn=new(z,"graphic")
plt_r_winter=new(z,"graphic")



do i=0,z-1
   
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

    wks=gsn_open_wks("png","cor_r_"+lev(i)+"_Annual")
    res@tiMainString="Annual Relative Humidity Correlation at "+lev(i)+"hPa"
    plt_r_year(i)=gsn_csm_contour_map_overlay(wks,r_correlation_year(i,:,:),t_test_r_year(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_r_"+lev(i)+"_Spring")
    res@tiMainString="Spring Relative Humidity Correlation at "+lev(i)+"hPa"
    plt_r_spring(i)=gsn_csm_contour_map_overlay(wks,r_correlation_spring(i,:,:),t_test_r_spring(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_r_"+lev(i)+"_Summer")
    res@tiMainString="Summer Relative Humidity Correlation at "+lev(i)+"hPa"
    plt_r_summer(i)=gsn_csm_contour_map_overlay(wks,r_correlation_summer(i,:,:),t_test_r_summer(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_r_"+lev(i)+"_Autumn")
    res@tiMainString="Autumn Relative Humidity Correlation at "+lev(i)+"hPa"
    plt_r_autumn(i)=gsn_csm_contour_map_overlay(wks,r_correlation_autumn(i,:,:),t_test_r_autumn(i,:,:),res,resshade)
    delete(wks)
    
    wks=gsn_open_wks("png","cor_r_"+lev(i)+"_Winter")
    res@tiMainString="Winter Relative Humidity Correlation at "+lev(i)+"hPa"
    plt_r_winter(i)=gsn_csm_contour_map_overlay(wks,r_correlation_winter(i,:,:),t_test_r_winter(i,:,:),res,resshade)
    delete(wks)
    
end do 
    
    
    
    