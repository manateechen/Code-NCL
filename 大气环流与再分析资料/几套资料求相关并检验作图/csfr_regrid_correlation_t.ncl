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

csfr_t=csfr_file_multi[:]->TMP_P8_L100_GLL0(:,lev_ind,:,:)
printVarSummary(csfr_t)
;csfr_r=csfr_file_multi[:]->RH_P8_L100_GLL0(:,lev_ind,:,:)
;printVarSummary(csfr_r)

era_file=addfile("ERA_T_R.nc","r")
t_era=(era_file->t(0:371,:,:,:))*0.002136145481674667+248.5977096982552
copy_VarCoords(era_file->t(0:371,:,:,:),t_era)
lat_era=era_file->latitude
lon_era=era_file->longitude

t_csfr_interp=linint2_Wrap(csfr_lon,csfr_lat(72:0),csfr_t,True,lon_era,lat_era(240:0),0)
printVarSummary(t_jra_interp)

csfr_t_spring_ave=month_to_season(t_csfr_interp,"MAM")
csfr_t_summer_ave=month_to_season(t_csfr_interp,"JJA")
csfr_t_autumn_ave=month_to_season(t_csfr_interp,"SON")
csfr_t_winter_ave=month_to_season(t_csfr_interp,"DJF")
csfr_t_year_ave=(csfr_t_spring_ave+csfr_t_summer_ave+csfr_t_autumn_ave+csfr_t_winter_ave)/4.0
copy_VarCoords(csfr_t_spring_ave,csfr_t_year_ave)
printVarSummary(csfr_t_year_ave)

era_t_spring_ave=month_to_season(t_era,"MAM")
era_t_summer_ave=month_to_season(t_era,"JJA")
era_t_autumn_ave=month_to_season(t_era,"SON")
era_t_winter_ave=month_to_season(t_era,"DJF")
era_t_year_ave=(era_t_spring_ave+era_t_summer_ave+era_t_autumn_ave+era_t_winter_ave)/4.0
copy_VarCoords(era_t_spring_ave,era_t_year_ave)
printVarSummary(era_t_year_ave)

reorder_t_csfr_year=csfr_t_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_csfr_spring=csfr_t_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_csfr_summer=csfr_t_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_csfr_autumn=csfr_t_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_csfr_winter=csfr_t_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_t_csfr_year)

reorder_t_era_year=era_t_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_spring=era_t_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_summer=era_t_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_autumn=era_t_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_winter=era_t_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_t_era_year)

n=31

t_correlation_year=escorc(reorder_t_csfr_year,reorder_t_era_year)
t_test_t_year=sqrt(n-2)*t_correlation_year/sqrt(1-t_correlation_year^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_year)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_year)
t_correlation_spring=escorc(reorder_t_csfr_spring,reorder_t_era_spring)
t_test_t_spring=sqrt(n-2)*t_correlation_spring/sqrt(1-t_correlation_spring^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_spring)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_spring)
t_correlation_summer=escorc(reorder_t_csfr_summer,reorder_t_era_summer)
t_test_t_summer=sqrt(n-2)*t_correlation_summer/sqrt(1-t_correlation_summer^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_summer)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_summer)
t_correlation_autumn=escorc(reorder_t_csfr_autumn,reorder_t_era_autumn)
t_test_t_autumn=sqrt(n-2)*t_correlation_autumn/sqrt(1-t_correlation_autumn^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_autumn)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_autumn)
t_correlation_winter=escorc(reorder_t_csfr_winter,reorder_t_era_winter)
t_test_t_winter=sqrt(n-2)*t_correlation_winter/sqrt(1-t_correlation_winter^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_winter)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_winter)

out5=addfile("cor_t_csrf.nc","c")
out5->t_correlation_year=t_correlation_year
out5->t_correlation_spring=t_correlation_spring
out5->t_correlation_summer=t_correlation_summer
out5->t_correlation_autumn=t_correlation_autumn
out5->t_correlation_winter=t_correlation_winter
out5->t_test_t_year=t_test_t_year
out5->t_test_t_spring=t_test_t_spring
out5->t_test_t_summer=t_test_t_summer
out5->t_test_t_autumn=t_test_t_autumn
out5->t_test_t_winter=t_test_t_winter
