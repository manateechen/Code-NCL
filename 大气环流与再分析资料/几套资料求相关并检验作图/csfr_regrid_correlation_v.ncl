load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

dir="/home/qianqf/CFSR/"
csfr_file_namelist=systemfunc("ls "+dir)
print(csfr_file_namelist)
csfr_file_multi=addfiles(dir+csfr_file_namelist,"r")
ListSetType (csfr_file_multi, "join")
printVarSummary(csfr_file_multi)

csfr_lat=csfr_file_multi[0]->lat_0
csfr_lon=csfr_file_multi[0]->lon_0
csfr_lev_all=csfr_file_multi[0]->lv_ISBL0
lev_ind=ind(csfr_lev_all.eq.100000.or.csfr_lev_all.eq.92500.or.csfr_lev_all.eq.85000.or.csfr_lev_all.eq.70000.or.csfr_lev_all.eq.60000.or.csfr_lev_all.eq.50000.or.csfr_lev_all.eq.40000.or.csfr_lev_all.eq.30000.or.csfr_lev_all.eq.25000.or.csfr_lev_all.eq.20000.or.csfr_lev_all.eq.15000.or.csfr_lev_all.eq.10000.or.csfr_lev_all.eq.7000.or.csfr_lev_all.eq.5000.or.csfr_lev_all.eq.3000.or.csfr_lev_all.eq.2000.or.csfr_lev_all.eq.1000)
csfr_lev=csfr_lev_all(lev_ind)
print(csfr_lev)

csfr_v=csfr_file_multi[:]->VGRD_P8_L100_GLL0(:,lev_ind,:,:)
printVarSummary(csfr_v)

era_file=addfile("ERA-UV.nc","r")
v_era=(era_file->v(0:371,:,:,:))*0.002142944680542627-0.3266940309340213
copy_VarCoords(era_file->v(0:371,:,:,:),v_era)
lat_era=era_file->latitude
lon_era=era_file->longitude

v_csfr_interp=linint2_Wrap(csfr_lon,csfr_lat(72:0),csfr_v,True,lon_era,lat_era(240:0),0)
printVarSummary(v_csfr_interp)

csfr_v_spring_ave=month_to_season(v_csfr_interp,"MAM")
csfr_v_summer_ave=month_to_season(v_csfr_interp,"JJA")
csfr_v_autumn_ave=month_to_season(v_csfr_interp,"SON")
csfr_v_winter_ave=month_to_season(v_csfr_interp,"DJF")
csfr_v_year_ave=(csfr_v_spring_ave+csfr_v_summer_ave+csfr_v_autumn_ave+csfr_v_winter_ave)/4.0
copy_VarCoords(csfr_v_spring_ave,csfr_v_year_ave)
printVarSummary(csfr_v_year_ave)

era_v_spring_ave=month_to_season(v_era,"MAM")
era_v_summer_ave=month_to_season(v_era,"JJA")
era_v_autumn_ave=month_to_season(v_era,"SON")
era_v_winter_ave=month_to_season(v_era,"DJF")
era_v_year_ave=(era_v_spring_ave+era_v_summer_ave+era_v_autumn_ave+era_v_winter_ave)/4.0
copy_VarCoords(era_v_spring_ave,era_v_year_ave)
printVarSummary(era_v_year_ave)

reorder_v_csfr_year=csfr_v_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_csfr_spring=csfr_v_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_csfr_summer=csfr_v_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_csfr_autumn=csfr_v_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_csfr_winter=csfr_v_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_v_csfr_year)

reorder_v_era_year=era_v_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_spring=era_v_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_summer=era_v_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_autumn=era_v_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_winter=era_v_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_v_era_year)

n=31

v_correlation_year=escorc(reorder_v_csfr_year,reorder_v_era_year)
t_test_v_year=sqrt(n-2)*v_correlation_year/sqrt(1-v_correlation_year^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_year)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_year)
v_correlation_spring=escorc(reorder_v_csfr_spring,reorder_v_era_spring)
t_test_v_spring=sqrt(n-2)*v_correlation_spring/sqrt(1-v_correlation_spring^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_spring)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_spring)
v_correlation_summer=escorc(reorder_v_csfr_summer,reorder_v_era_summer)
t_test_v_summer=sqrt(n-2)*v_correlation_summer/sqrt(1-v_correlation_summer^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_summer)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_summer)
v_correlation_autumn=escorc(reorder_v_csfr_autumn,reorder_v_era_autumn)
t_test_v_autumn=sqrt(n-2)*v_correlation_autumn/sqrt(1-v_correlation_autumn^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_autumn)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_autumn)
v_correlation_winter=escorc(reorder_v_csfr_winter,reorder_v_era_winter)
t_test_v_winter=sqrt(n-2)*v_correlation_winter/sqrt(1-v_correlation_winter^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_winter)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_winter)

out5=addfile("cor_v_csrf.nc","c")
out5->v_correlation_year=v_correlation_year
out5->v_correlation_spring=v_correlation_spring
out5->v_correlation_summer=v_correlation_summer
out5->v_correlation_autumn=v_correlation_autumn
out5->v_correlation_winter=v_correlation_winter
out5->t_test_v_year=t_test_v_year
out5->t_test_v_spring=t_test_v_spring
out5->t_test_v_summer=t_test_v_summer
out5->t_test_v_autumn=t_test_v_autumn
out5->t_test_v_winter=t_test_v_winter
