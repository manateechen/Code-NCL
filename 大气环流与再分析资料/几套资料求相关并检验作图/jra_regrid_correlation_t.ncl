load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

dir="/home/qianqf/JRA/"

jra_t_file_namelist=systemfunc("ls "+dir+"JRA_T/anl*")
jra_t_file_namelist=jra_t_file_namelist+".grib"
;print(jra_t_file_namelist)
jra_t_file_multi=addfiles(jra_t_file_namelist,"r")
ListSetType (jra_t_file_multi, "join")

lat_jra=jra_t_file_multi[0]->g0_lat_1
lon_jra=jra_t_file_multi[0]->g0_lon_2
lev_jra=jra_t_file_multi[0]->lv_ISBL0
lev_ind=ind(lev_jra.eq.10.or.lev_jra.eq.20.or.lev_jra.eq.30.or.lev_jra.eq.50.or.lev_jra.eq.70.or.lev_jra.eq.100.or.lev_jra.eq.150.or.lev_jra.eq.200.or.lev_jra.eq.250.or.lev_jra.eq.300.or.lev_jra.eq.400.or.lev_jra.eq.500.or.lev_jra.eq.600.or.lev_jra.eq.700.or.lev_jra.eq.850.or.lev_jra.eq.925.or.lev_jra.eq.1000)
;print(lev_jra(lev_ind))

t_jra=jra_t_file_multi[:]->TMP_GDS0_ISBL_S123(:,lev_ind,:,:)
printVarSummary(t_jra)

era_file_a=addfile("ERA_T_R.nc","r")
t_era=(era_file_a->t)*0.002136145481674667+248.5977096982552
copy_VarCoords(era_file_a->t,t_era)
lat_era=era_file_a->latitude
lon_era=era_file_a->longitude

t_jra_interp=linint2_Wrap(lon_jra,lat_jra(144:0),t_jra,True,lon_era,lat_era(240:0),0)
printVarSummary(t_jra_interp)

jra_t_spring_ave=month_to_season(t_jra_interp,"MAM")
jra_t_summer_ave=month_to_season(t_jra_interp,"JJA")
jra_t_autumn_ave=month_to_season(t_jra_interp,"SON")
jra_t_winter_ave=month_to_season(t_jra_interp,"DJF")
jra_t_year_ave=(jra_t_spring_ave+jra_t_summer_ave+jra_t_autumn_ave+jra_t_winter_ave)/4.0
copy_VarCoords(jra_t_spring_ave,jra_t_year_ave)
printVarSummary(jra_t_year_ave)



era_t_spring_ave=month_to_season(t_era,"MAM")
era_t_summer_ave=month_to_season(t_era,"JJA")
era_t_autumn_ave=month_to_season(t_era,"SON")
era_t_winter_ave=month_to_season(t_era,"DJF")
era_t_year_ave=(era_t_spring_ave+era_t_summer_ave+era_t_autumn_ave+era_t_winter_ave)/4.0
copy_VarCoords(era_t_spring_ave,era_t_year_ave)
printVarSummary(era_t_year_ave)


reorder_t_jra_year=jra_t_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_jra_spring=jra_t_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_jra_summer=jra_t_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_jra_autumn=jra_t_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_t_jra_winter=jra_t_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_t_jra_year)


reorder_t_era_year=era_t_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_spring=era_t_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_summer=era_t_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_autumn=era_t_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_winter=era_t_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_t_era_year)


n=35

t_correlation_year=escorc(reorder_t_jra_year,reorder_t_era_year)
t_test_t_year=sqrt(n-2)*t_correlation_year/sqrt(1-t_correlation_year^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_year)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_year)
t_correlation_spring=escorc(reorder_t_jra_spring,reorder_t_era_spring)
t_test_t_spring=sqrt(n-2)*t_correlation_spring/sqrt(1-t_correlation_spring^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_spring)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_spring)
t_correlation_summer=escorc(reorder_t_jra_summer,reorder_t_era_summer)
t_test_t_summer=sqrt(n-2)*t_correlation_summer/sqrt(1-t_correlation_summer^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_summer)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_summer)
t_correlation_autumn=escorc(reorder_t_jra_autumn,reorder_t_era_autumn)
t_test_t_autumn=sqrt(n-2)*t_correlation_autumn/sqrt(1-t_correlation_autumn^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_autumn)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_autumn)
t_correlation_winter=escorc(reorder_t_jra_winter,reorder_t_era_winter)
t_test_t_winter=sqrt(n-2)*t_correlation_winter/sqrt(1-t_correlation_winter^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_winter)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_winter)


out5=addfile("cor_t.nc","c")
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
