load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

dir="/home/qianqf/JRA/"

jra_hgt_file_namelist=systemfunc("ls "+dir+"JRA_GEO/anl*")
jra_hgt_file_namelist=jra_hgt_file_namelist+".grib"
;print(jra_hgt_file_namelist)
jra_hgt_file_multi=addfiles(jra_hgt_file_namelist,"r")
ListSetType (jra_hgt_file_multi, "join")

lat_jra=jra_hgt_file_multi[0]->g0_lat_1
lon_jra=jra_hgt_file_multi[0]->g0_lon_2
lev_jra=jra_hgt_file_multi[0]->lv_ISBL0
lev_ind=ind(lev_jra.eq.10.or.lev_jra.eq.20.or.lev_jra.eq.30.or.lev_jra.eq.50.or.lev_jra.eq.70.or.lev_jra.eq.100.or.lev_jra.eq.150.or.lev_jra.eq.200.or.lev_jra.eq.250.or.lev_jra.eq.300.or.lev_jra.eq.400.or.lev_jra.eq.500.or.lev_jra.eq.600.or.lev_jra.eq.700.or.lev_jra.eq.850.or.lev_jra.eq.925.or.lev_jra.eq.1000)
;print(lev_jra(lev_ind))

hgt_jra=jra_hgt_file_multi[:]->HGT_GDS0_ISBL_S123(:,lev_ind,:,:)
printVarSummary(hgt_jra)

era_file_a=addfile("ERA-GEO.nc","r")
hgt_era=(era_file_a->z)*4.866332663207372+156219.190124684
copy_VarCoords(era_file_a->z,hgt_era)
lat_era=era_file_a->latitude
lon_era=era_file_a->longitude

hgt_jra_interp=linint2_Wrap(lon_jra,lat_jra(144:0),hgt_jra,True,lon_era,lat_era(240:0),0)
printVarSummary(hgt_jra_interp)

jra_hgt_spring_ave=month_to_season(hgt_jra_interp,"MAM")
jra_hgt_summer_ave=month_to_season(hgt_jra_interp,"JJA")
jra_hgt_autumn_ave=month_to_season(hgt_jra_interp,"SON")
jra_hgt_winter_ave=month_to_season(hgt_jra_interp,"DJF")
jra_hgt_year_ave=(jra_hgt_spring_ave+jra_hgt_summer_ave+jra_hgt_autumn_ave+jra_hgt_winter_ave)/4.0
copy_VarCoords(jra_hgt_spring_ave,jra_hgt_year_ave)
printVarSummary(jra_hgt_year_ave)

era_hgt_spring_ave=month_to_season(hgt_era,"MAM")
era_hgt_summer_ave=month_to_season(hgt_era,"JJA")
era_hgt_autumn_ave=month_to_season(hgt_era,"SON")
era_hgt_winter_ave=month_to_season(hgt_era,"DJF")
era_hgt_year_ave=(era_hgt_spring_ave+era_hgt_summer_ave+era_hgt_autumn_ave+era_hgt_winter_ave)/4.0
copy_VarCoords(era_hgt_spring_ave,era_hgt_year_ave)
printVarSummary(era_hgt_year_ave)


reorder_hgt_jra_year=jra_hgt_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_jra_spring=jra_hgt_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_jra_summer=jra_hgt_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_jra_autumn=jra_hgt_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_jra_winter=jra_hgt_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_hgt_jra_year)


reorder_hgt_era_year=era_hgt_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_spring=era_hgt_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_summer=era_hgt_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_autumn=era_hgt_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_winter=era_hgt_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_hgt_era_year)


n=35

hgt_correlation_year=escorc(reorder_hgt_jra_year,reorder_hgt_era_year)
t_test_hgt_year=sqrt(n-2)*hgt_correlation_year/sqrt(1-hgt_correlation_year^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_year)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_year)
hgt_correlation_spring=escorc(reorder_hgt_jra_spring,reorder_hgt_era_spring)
t_test_hgt_spring=sqrt(n-2)*hgt_correlation_spring/sqrt(1-hgt_correlation_spring^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_spring)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_spring)
hgt_correlation_summer=escorc(reorder_hgt_jra_summer,reorder_hgt_era_summer)
t_test_hgt_summer=sqrt(n-2)*hgt_correlation_summer/sqrt(1-hgt_correlation_summer^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_summer)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_summer)
hgt_correlation_autumn=escorc(reorder_hgt_jra_autumn,reorder_hgt_era_autumn)
t_test_hgt_autumn=sqrt(n-2)*hgt_correlation_autumn/sqrt(1-hgt_correlation_autumn^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_autumn)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_autumn)
hgt_correlation_winter=escorc(reorder_hgt_jra_winter,reorder_hgt_era_winter)
t_test_hgt_winter=sqrt(n-2)*hgt_correlation_winter/sqrt(1-hgt_correlation_winter^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_winter)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_winter)


out5=addfile("cor_hgt.nc","c")
out5->hgt_correlation_year=hgt_correlation_year
out5->hgt_correlation_spring=hgt_correlation_spring
out5->hgt_correlation_summer=hgt_correlation_summer
out5->hgt_correlation_autumn=hgt_correlation_autumn
out5->hgt_correlation_winter=hgt_correlation_winter
out5->t_test_hgt_year=t_test_hgt_year
out5->t_test_hgt_spring=t_test_hgt_spring
out5->t_test_hgt_summer=t_test_hgt_summer
out5->t_test_hgt_autumn=t_test_hgt_autumn
out5->t_test_hgt_winter=t_test_hgt_winter
