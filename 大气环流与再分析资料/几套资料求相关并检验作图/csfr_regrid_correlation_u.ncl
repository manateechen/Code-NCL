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

csfr_u=csfr_file_multi[:]->UGRD_P8_L100_GLL0(:,lev_ind,:,:)
printVarSummary(csfr_u)

era_file=addfile("ERA-UV.nc","r")
u_era=(era_file->u(0:371,:,:,:))*0.002767466033334351+20.78932671620208
copy_VarCoords(era_file->u(0:371,:,:,:),u_era)
lat_era=era_file->latitude
lon_era=era_file->longitude

u_csfr_interp=linint2_Wrap(csfr_lon,csfr_lat(72:0),csfr_u,True,lon_era,lat_era(240:0),0)
printVarSummary(u_csfr_interp)

csfr_u_spring_ave=month_to_season(u_csfr_interp,"MAM")
csfr_u_summer_ave=month_to_season(u_csfr_interp,"JJA")
csfr_u_autumn_ave=month_to_season(u_csfr_interp,"SON")
csfr_u_winter_ave=month_to_season(u_csfr_interp,"DJF")
csfr_u_year_ave=(csfr_u_spring_ave+csfr_u_summer_ave+csfr_u_autumn_ave+csfr_u_winter_ave)/4.0
copy_VarCoords(csfr_u_spring_ave,csfr_u_year_ave)
printVarSummary(csfr_u_year_ave)

era_u_spring_ave=month_to_season(u_era,"MAM")
era_u_summer_ave=month_to_season(u_era,"JJA")
era_u_autumn_ave=month_to_season(u_era,"SON")
era_u_winter_ave=month_to_season(u_era,"DJF")
era_u_year_ave=(era_u_spring_ave+era_u_summer_ave+era_u_autumn_ave+era_u_winter_ave)/4.0
copy_VarCoords(era_u_spring_ave,era_u_year_ave)
printVarSummary(era_u_year_ave)

reorder_u_csfr_year=csfr_u_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_csfr_spring=csfr_u_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_csfr_summer=csfr_u_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_csfr_autumn=csfr_u_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_u_csfr_winter=csfr_u_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_u_csfr_year)

reorder_u_era_year=era_u_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_spring=era_u_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_summer=era_u_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_autumn=era_u_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_winter=era_u_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_u_era_year)

n=31

u_correlation_year=escorc(reorder_u_csfr_year,reorder_u_era_year)
t_test_u_year=sqrt(n-2)*u_correlation_year/sqrt(1-u_correlation_year^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_year)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_year)
u_correlation_spring=escorc(reorder_u_csfr_spring,reorder_u_era_spring)
t_test_u_spring=sqrt(n-2)*u_correlation_spring/sqrt(1-u_correlation_spring^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_spring)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_spring)
u_correlation_summer=escorc(reorder_u_csfr_summer,reorder_u_era_summer)
t_test_u_summer=sqrt(n-2)*u_correlation_summer/sqrt(1-u_correlation_summer^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_summer)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_summer)
u_correlation_autumn=escorc(reorder_u_csfr_autumn,reorder_u_era_autumn)
t_test_u_autumn=sqrt(n-2)*u_correlation_autumn/sqrt(1-u_correlation_autumn^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_autumn)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_autumn)
u_correlation_winter=escorc(reorder_u_csfr_winter,reorder_u_era_winter)
t_test_u_winter=sqrt(n-2)*u_correlation_winter/sqrt(1-u_correlation_winter^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_winter)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_winter)

out5=addfile("cor_u_csrf.nc","c")
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
