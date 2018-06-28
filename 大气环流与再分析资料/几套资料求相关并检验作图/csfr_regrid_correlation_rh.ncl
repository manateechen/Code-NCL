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

csfr_r=csfr_file_multi[:]->RH_P8_L100_GLL0(:,lev_ind,:,:)
printVarSummary(csfr_r)

era_file=addfile("ERA_T_R.nc","r")
r_era=(era_file->r(0:371,:,:,:))*0.002063735055076803+67.62375920270928
copy_VarCoords(era_file->r(0:371,:,:,:),r_era)
lat_era=era_file->latitude
lon_era=era_file->longitude

r_csfr_interp=linint2_Wrap(csfr_lon,csfr_lat(72:0),csfr_r,True,lon_era,lat_era(240:0),0)
printVarSummary(r_csfr_interp)

csfr_r_spring_ave=month_to_season(r_csfr_interp,"MAM")
csfr_r_summer_ave=month_to_season(r_csfr_interp,"JJA")
csfr_r_autumn_ave=month_to_season(r_csfr_interp,"SON")
csfr_r_winter_ave=month_to_season(r_csfr_interp,"DJF")
csfr_r_year_ave=(csfr_r_spring_ave+csfr_r_summer_ave+csfr_r_autumn_ave+csfr_r_winter_ave)/4.0
copy_VarCoords(csfr_r_spring_ave,csfr_r_year_ave)
printVarSummary(csfr_r_year_ave)

era_r_spring_ave=month_to_season(r_era,"MAM")
era_r_summer_ave=month_to_season(r_era,"JJA")
era_r_autumn_ave=month_to_season(r_era,"SON")
era_r_winter_ave=month_to_season(r_era,"DJF")
era_r_year_ave=(era_r_spring_ave+era_r_summer_ave+era_r_autumn_ave+era_r_winter_ave)/4.0
copy_VarCoords(era_r_spring_ave,era_r_year_ave)
printVarSummary(era_r_year_ave)

reorder_r_csfr_year=csfr_r_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_r_csfr_spring=csfr_r_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_r_csfr_summer=csfr_r_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_r_csfr_autumn=csfr_r_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_r_csfr_winter=csfr_r_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_r_csfr_year)

reorder_r_era_year=era_r_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_spring=era_r_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_summer=era_r_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_autumn=era_r_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_winter=era_r_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_r_era_year)

n=31

r_correlation_year=escorc(reorder_r_csfr_year,reorder_r_era_year)
t_test_r_year=sqrt(n-2)*r_correlation_year/sqrt(1-r_correlation_year^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_year)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_year)
r_correlation_spring=escorc(reorder_r_csfr_spring,reorder_r_era_spring)
t_test_r_spring=sqrt(n-2)*r_correlation_spring/sqrt(1-r_correlation_spring^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_spring)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_spring)
r_correlation_summer=escorc(reorder_r_csfr_summer,reorder_r_era_summer)
t_test_r_summer=sqrt(n-2)*r_correlation_summer/sqrt(1-r_correlation_summer^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_summer)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_summer)
r_correlation_autumn=escorc(reorder_r_csfr_autumn,reorder_r_era_autumn)
t_test_r_autumn=sqrt(n-2)*r_correlation_autumn/sqrt(1-r_correlation_autumn^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_autumn)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_autumn)
r_correlation_winter=escorc(reorder_r_csfr_winter,reorder_r_era_winter)
t_test_r_winter=sqrt(n-2)*r_correlation_winter/sqrt(1-r_correlation_winter^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_winter)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_winter)

out5=addfile("cor_r_csrf.nc","c")
out5->r_correlation_year=r_correlation_year
out5->r_correlation_spring=r_correlation_spring
out5->r_correlation_summer=r_correlation_summer
out5->r_correlation_autumn=r_correlation_autumn
out5->r_correlation_winter=r_correlation_winter
out5->t_test_r_year=t_test_r_year
out5->t_test_r_spring=t_test_r_spring
out5->t_test_r_summer=t_test_r_summer
out5->t_test_r_autumn=t_test_r_autumn
out5->t_test_r_winter=t_test_r_winter
