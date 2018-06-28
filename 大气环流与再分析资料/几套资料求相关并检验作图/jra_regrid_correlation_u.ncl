load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

dir="/home/qianqf/JRA/"

jra_u_file_namelist=systemfunc("ls "+dir+"JRA_U/anl*")
jra_u_file_namelist=jra_u_file_namelist+".grib"
;print(jra_u_file_namelist)
jra_u_file_multi=addfiles(jra_u_file_namelist,"r")
ListSetType (jra_u_file_multi, "join")

lat_jra=jra_u_file_multi[0]->g0_lat_1
lon_jra=jra_u_file_multi[0]->g0_lon_2
lev_jra=jra_u_file_multi[0]->lv_ISBL0
lev_ind=ind(lev_jra.eq.10.or.lev_jra.eq.20.or.lev_jra.eq.30.or.lev_jra.eq.50.or.lev_jra.eq.70.or.lev_jra.eq.100.or.lev_jra.eq.150.or.lev_jra.eq.200.or.lev_jra.eq.250.or.lev_jra.eq.300.or.lev_jra.eq.400.or.lev_jra.eq.500.or.lev_jra.eq.600.or.lev_jra.eq.700.or.lev_jra.eq.850.or.lev_jra.eq.925.or.lev_jra.eq.1000)
;print(lev_jra(lev_ind))

u_jra=jra_u_file_multi[:]->UGRD_GDS0_ISBL_S123(:,lev_ind,:,:)
printVarSummary(u_jra)

era_file_a=addfile("ERA-UV.nc","r")
u_era=(era_file_a->u)*0.002767466033334351+20.78932671620208
copy_VarCoords(era_file_a->u,u_era)
lat_era=era_file_a->latitude
lon_era=era_file_a->longitude

u_jra_interp=linint2_Wrap(lon_jra,lat_jra(144:0),u_jra,True,lon_era,lat_era(240:0),0)
printVarSummary(u_jra_interp)

jra_u_spring_ave=month_to_season(u_jra_interp,"MAM")
jra_u_summer_ave=month_to_season(u_jra_interp,"JJA")
jra_u_autumn_ave=month_to_season(u_jra_interp,"SON")
jra_u_winter_ave=month_to_season(u_jra_interp,"DJF")
jra_u_year_ave=(jra_u_spring_ave+jra_u_summer_ave+jra_u_autumn_ave+jra_u_winter_ave)/4.0
copy_VarCoords(jra_u_spring_ave,jra_u_year_ave)
printVarSummary(jra_u_year_ave)

era_u_spring_ave=month_to_season(u_era,"MAM")
era_u_summer_ave=month_to_season(u_era,"JJA")
era_u_autumn_ave=month_to_season(u_era,"SON")
era_u_winter_ave=month_to_season(u_era,"DJF")
era_u_year_ave=(era_u_spring_ave+era_u_summer_ave+era_u_autumn_ave+era_u_winter_ave)/4.0
copy_VarCoords(era_u_spring_ave,era_u_year_ave)
printVarSummary(era_u_year_ave)


reorder_u_jra_year=jra_u_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_jra_spring=jra_u_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_jra_summer=jra_u_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_jra_autumn=jra_u_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_jra_winter=jra_u_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_u_jra_year)


reorder_u_era_year=era_u_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_spring=era_u_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_summer=era_u_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_autumn=era_u_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_winter=era_u_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_u_era_year)


n=35

u_correlation_year=escorc(reorder_u_jra_year,reorder_u_era_year)
t_test_u_year=sqrt(n-2)*u_correlation_year/sqrt(1-u_correlation_year^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_year)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_year)
u_correlation_spring=escorc(reorder_u_jra_spring,reorder_u_era_spring)
t_test_u_spring=sqrt(n-2)*u_correlation_spring/sqrt(1-u_correlation_spring^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_spring)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_spring)
u_correlation_summer=escorc(reorder_u_jra_summer,reorder_u_era_summer)
t_test_u_summer=sqrt(n-2)*u_correlation_summer/sqrt(1-u_correlation_summer^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_summer)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_summer)
u_correlation_autumn=escorc(reorder_u_jra_autumn,reorder_u_era_autumn)
t_test_u_autumn=sqrt(n-2)*u_correlation_autumn/sqrt(1-u_correlation_autumn^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_autumn)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_autumn)
u_correlation_winter=escorc(reorder_u_jra_winter,reorder_u_era_winter)
t_test_u_winter=sqrt(n-2)*u_correlation_winter/sqrt(1-u_correlation_winter^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_winter)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_winter)


out5=addfile("cor_u.nc","c")
out5->u_correlation_year=u_correlation_year
out5->u_correlation_spring=u_correlation_spring
out5->u_correlation_summer=u_correlation_summer
out5->u_correlation_autumn=u_correlation_autumn
out5->u_correlation_winter=u_correlation_winter
out5->t_test_u_year=t_test_u_year
out5->t_test_u_spring=t_test_u_spring
out5->t_test_u_summer=t_test_u_summer
out5->t_test_u_autumn=t_test_u_autumn
out5->t_test_u_winter=t_test_u_winter
