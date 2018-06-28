load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

dir="/home/qianqf/JRA/"

jra_rh_file_namelist=systemfunc("ls "+dir+"JRA_RH/anl*")
jra_rh_file_namelist=jra_rh_file_namelist+".grib"
;print(jra_rh_file_namelist)
jra_rh_file_multi=addfiles(jra_rh_file_namelist,"r")
ListSetType (jra_rh_file_multi, "join")

lat_jra=jra_rh_file_multi[0]->g0_lat_1
lon_jra=jra_rh_file_multi[0]->g0_lon_2
lev_jra=jra_rh_file_multi[0]->lv_ISBL0
lev_ind=ind(lev_jra.eq.100.or.lev_jra.eq.150.or.lev_jra.eq.200.or.lev_jra.eq.250.or.lev_jra.eq.300.or.lev_jra.eq.400.or.lev_jra.eq.500.or.lev_jra.eq.600.or.lev_jra.eq.700.or.lev_jra.eq.850.or.lev_jra.eq.925.or.lev_jra.eq.1000)
;print(lev_jra(lev_ind))

rh_jra=jra_rh_file_multi[:]->RH_GDS0_ISBL_S123(:,lev_ind,:,:)
printVarSummary(rh_jra)

era_file_a=addfile("ERA_T_R.nc","r")
lev_era=era_file_a->level
lev_ind_era=ind(lev_era.eq.100.or.lev_era.eq.150.or.lev_era.eq.200.or.lev_era.eq.250.or.lev_era.eq.300.or.lev_era.eq.400.or.lev_era.eq.500.or.lev_era.eq.600.or.lev_era.eq.700.or.lev_era.eq.850.or.lev_era.eq.925.or.lev_era.eq.1000)
rh_era=(era_file_a->r(:,lev_ind_era,:,:))*0.002063735055076803+67.62375920270928
copy_VarCoords(era_file_a->r(:,lev_ind_era,:,:),rh_era)
lat_era=era_file_a->latitude
lon_era=era_file_a->longitude

rh_jra_interp=linint2_Wrap(lon_jra,lat_jra(144:0),rh_jra,True,lon_era,lat_era(240:0),0)
printVarSummary(rh_jra_interp)

jra_rh_spring_ave=month_to_season(rh_jra_interp,"MAM")
jra_rh_summer_ave=month_to_season(rh_jra_interp,"JJA")
jra_rh_autumn_ave=month_to_season(rh_jra_interp,"SON")
jra_rh_winter_ave=month_to_season(rh_jra_interp,"DJF")
jra_rh_year_ave=(jra_rh_spring_ave+jra_rh_summer_ave+jra_rh_autumn_ave+jra_rh_winter_ave)/4.0
copy_VarCoords(jra_rh_spring_ave,jra_rh_year_ave)
printVarSummary(jra_rh_year_ave)

era_rh_spring_ave=month_to_season(rh_era,"MAM")
era_rh_summer_ave=month_to_season(rh_era,"JJA")
era_rh_autumn_ave=month_to_season(rh_era,"SON")
era_rh_winter_ave=month_to_season(rh_era,"DJF")
era_rh_year_ave=(era_rh_spring_ave+era_rh_summer_ave+era_rh_autumn_ave+era_rh_winter_ave)/4.0
copy_VarCoords(era_rh_spring_ave,era_rh_year_ave)
printVarSummary(era_rh_year_ave)


reorder_rh_jra_year=jra_rh_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_rh_jra_spring=jra_rh_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_rh_jra_summer=jra_rh_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_rh_jra_autumn=jra_rh_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_rh_jra_winter=jra_rh_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_rh_jra_year)


reorder_rh_era_year=era_rh_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_rh_era_spring=era_rh_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_rh_era_summer=era_rh_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_rh_era_autumn=era_rh_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_rh_era_winter=era_rh_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_rh_era_year)


n=35

rh_correlation_year=escorc(reorder_rh_jra_year,reorder_rh_era_year)
t_test_rh_year=sqrt(n-2)*rh_correlation_year/sqrt(1-rh_correlation_year^2)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),rh_correlation_year)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),t_test_rh_year)
rh_correlation_spring=escorc(reorder_rh_jra_spring,reorder_rh_era_spring)
t_test_rh_spring=sqrt(n-2)*rh_correlation_spring/sqrt(1-rh_correlation_spring^2)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),rh_correlation_spring)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),t_test_rh_spring)
rh_correlation_summer=escorc(reorder_rh_jra_summer,reorder_rh_era_summer)
t_test_rh_summer=sqrt(n-2)*rh_correlation_summer/sqrt(1-rh_correlation_summer^2)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),rh_correlation_summer)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),t_test_rh_summer)
rh_correlation_autumn=escorc(reorder_rh_jra_autumn,reorder_rh_era_autumn)
t_test_rh_autumn=sqrt(n-2)*rh_correlation_autumn/sqrt(1-rh_correlation_autumn^2)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),rh_correlation_autumn)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),t_test_rh_autumn)
rh_correlation_winter=escorc(reorder_rh_jra_winter,reorder_rh_era_winter)
t_test_rh_winter=sqrt(n-2)*rh_correlation_winter/sqrt(1-rh_correlation_winter^2)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),rh_correlation_winter)
copy_VarCoords(reorder_rh_era_winter(:,:,:,0),t_test_rh_winter)


out5=addfile("cor_rh.nc","c")
out5->rh_correlation_year=rh_correlation_year
out5->rh_correlation_spring=rh_correlation_spring
out5->rh_correlation_summer=rh_correlation_summer
out5->rh_correlation_autumn=rh_correlation_autumn
out5->rh_correlation_winter=rh_correlation_winter
out5->t_test_rh_year=t_test_rh_year
out5->t_test_rh_spring=t_test_rh_spring
out5->t_test_rh_summer=t_test_rh_summer
out5->t_test_rh_autumn=t_test_rh_autumn
out5->t_test_rh_winter=t_test_rh_winter
