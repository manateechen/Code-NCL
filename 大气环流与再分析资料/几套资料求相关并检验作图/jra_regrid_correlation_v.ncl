load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

dir="/home/qianqf/JRA/"

jra_v_file_namelist=systemfunc("ls "+dir+"JRA_V/anl*")
jra_v_file_namelist=jra_v_file_namelist+".grib"
;print(jra_v_file_namelist)
jra_v_file_multi=addfiles(jra_v_file_namelist,"r")
ListSetType (jra_v_file_multi, "join")

lat_jra=jra_v_file_multi[0]->g0_lat_1
lon_jra=jra_v_file_multi[0]->g0_lon_2
lev_jra=jra_v_file_multi[0]->lv_ISBL0
lev_ind=ind(lev_jra.eq.10.or.lev_jra.eq.20.or.lev_jra.eq.30.or.lev_jra.eq.50.or.lev_jra.eq.70.or.lev_jra.eq.100.or.lev_jra.eq.150.or.lev_jra.eq.200.or.lev_jra.eq.250.or.lev_jra.eq.300.or.lev_jra.eq.400.or.lev_jra.eq.500.or.lev_jra.eq.600.or.lev_jra.eq.700.or.lev_jra.eq.850.or.lev_jra.eq.925.or.lev_jra.eq.1000)
;print(lev_jra(lev_ind))

v_jra=jra_v_file_multi[:]->VGRD_GDS0_ISBL_S123(:,lev_ind,:,:)
printVarSummary(v_jra)

era_file_a=addfile("ERA-UV.nc","r")
v_era=(era_file_a->v)*0.002142944680542627-0.3266940309340213
copy_VarCoords(era_file_a->v,v_era)
lat_era=era_file_a->latitude
lon_era=era_file_a->longitude

v_jra_interp=linint2_Wrap(lon_jra,lat_jra(144:0),v_jra,True,lon_era,lat_era(240:0),0)
printVarSummary(v_jra_interp)

jra_v_spring_ave=month_to_season(v_jra_interp,"MAM")
jra_v_summer_ave=month_to_season(v_jra_interp,"JJA")
jra_v_autumn_ave=month_to_season(v_jra_interp,"SON")
jra_v_winter_ave=month_to_season(v_jra_interp,"DJF")
jra_v_year_ave=(jra_v_spring_ave+jra_v_summer_ave+jra_v_autumn_ave+jra_v_winter_ave)/4.0
copy_VarCoords(jra_v_spring_ave,jra_v_year_ave)
printVarSummary(jra_v_year_ave)

era_v_spring_ave=month_to_season(v_era,"MAM")
era_v_summer_ave=month_to_season(v_era,"JJA")
era_v_autumn_ave=month_to_season(v_era,"SON")
era_v_winter_ave=month_to_season(v_era,"DJF")
era_v_year_ave=(era_v_spring_ave+era_v_summer_ave+era_v_autumn_ave+era_v_winter_ave)/4.0
copy_VarCoords(era_v_spring_ave,era_v_year_ave)
printVarSummary(era_v_year_ave)


reorder_v_jra_year=jra_v_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_jra_spring=jra_v_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_jra_summer=jra_v_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_jra_autumn=jra_v_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_v_jra_winter=jra_v_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_v_jra_year)


reorder_v_era_year=era_v_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_spring=era_v_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_summer=era_v_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_autumn=era_v_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_winter=era_v_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_v_era_year)


n=35

v_correlation_year=escorc(reorder_v_jra_year,reorder_v_era_year)
t_test_v_year=sqrt(n-2)*v_correlation_year/sqrt(1-v_correlation_year^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_year)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_year)
v_correlation_spring=escorc(reorder_v_jra_spring,reorder_v_era_spring)
t_test_v_spring=sqrt(n-2)*v_correlation_spring/sqrt(1-v_correlation_spring^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_spring)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_spring)
v_correlation_summer=escorc(reorder_v_jra_summer,reorder_v_era_summer)
t_test_v_summer=sqrt(n-2)*v_correlation_summer/sqrt(1-v_correlation_summer^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_summer)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_summer)
v_correlation_autumn=escorc(reorder_v_jra_autumn,reorder_v_era_autumn)
t_test_v_autumn=sqrt(n-2)*v_correlation_autumn/sqrt(1-v_correlation_autumn^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_autumn)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_autumn)
v_correlation_winter=escorc(reorder_v_jra_winter,reorder_v_era_winter)
t_test_v_winter=sqrt(n-2)*v_correlation_winter/sqrt(1-v_correlation_winter^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_winter)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_winter)


out5=addfile("cor_v.nc","c")
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
