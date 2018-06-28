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

csfr_hgt=csfr_file_multi[:]->HGT_P8_L100_GLL0(:,lev_ind,:,:)
printVarSummary(csfr_hgt)

era_file=addfile("ERA-GEO.nc","r")
hgt_era=(era_file->z(0:371,:,:,:))*4.866332663207372+156219.190124684
copy_VarCoords(era_file->z(0:371,:,:,:),hgt_era)
lat_era=era_file->latitude
lon_era=era_file->longitude

hgt_csfr_interp=linint2_Wrap(csfr_lon,csfr_lat(72:0),csfr_hgt,True,lon_era,lat_era(240:0),0)
printVarSummary(r_csfr_interp)

csfr_hgt_spring_ave=month_to_season(hgt_csfr_interp,"MAM")
csfr_hgt_summer_ave=month_to_season(hgt_csfr_interp,"JJA")
csfr_hgt_autumn_ave=month_to_season(hgt_csfr_interp,"SON")
csfr_hgt_winter_ave=month_to_season(hgt_csfr_interp,"DJF")
csfr_hgt_year_ave=(csfr_hgt_spring_ave+csfr_hgt_summer_ave+csfr_hgt_autumn_ave+csfr_hgt_winter_ave)/4.0
copy_VarCoords(csfr_hgt_spring_ave,csfr_hgt_year_ave)
printVarSummary(csfr_hgt_year_ave)

era_hgt_spring_ave=month_to_season(hgt_era,"MAM")
era_hgt_summer_ave=month_to_season(hgt_era,"JJA")
era_hgt_autumn_ave=month_to_season(hgt_era,"SON")
era_hgt_winter_ave=month_to_season(hgt_era,"DJF")
era_hgt_year_ave=(era_hgt_spring_ave+era_hgt_summer_ave+era_hgt_autumn_ave+era_hgt_winter_ave)/4.0
copy_VarCoords(era_hgt_spring_ave,era_hgt_year_ave)
printVarSummary(era_hgt_year_ave)

reorder_hgt_csfr_year=csfr_hgt_year_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_csfr_spring=csfr_hgt_spring_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_csfr_summer=csfr_hgt_summer_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_csfr_autumn=csfr_hgt_autumn_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
reorder_hgt_csfr_winter=csfr_hgt_winter_ave(lv_ISBL0|:,latitude|:,longitude|:,ncl_join|:)
printVarSummary(reorder_hgt_csfr_year)

reorder_hgt_era_year=era_hgt_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_spring=era_hgt_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_summer=era_hgt_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_autumn=era_hgt_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_winter=era_hgt_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_hgt_era_year)

n=31

hgt_correlation_year=escorc(reorder_hgt_csfr_year,reorder_hgt_era_year)
t_test_hgt_year=sqrt(n-2)*hgt_correlation_year/sqrt(1-hgt_correlation_year^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_year)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_year)
hgt_correlation_spring=escorc(reorder_hgt_csfr_spring,reorder_hgt_era_spring)
t_test_hgt_spring=sqrt(n-2)*hgt_correlation_spring/sqrt(1-hgt_correlation_spring^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_spring)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_spring)
hgt_correlation_summer=escorc(reorder_hgt_csfr_summer,reorder_hgt_era_summer)
t_test_hgt_summer=sqrt(n-2)*hgt_correlation_summer/sqrt(1-hgt_correlation_summer^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_summer)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_summer)
hgt_correlation_autumn=escorc(reorder_hgt_csfr_autumn,reorder_hgt_era_autumn)
t_test_hgt_autumn=sqrt(n-2)*hgt_correlation_autumn/sqrt(1-hgt_correlation_autumn^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_autumn)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_autumn)
hgt_correlation_winter=escorc(reorder_hgt_csfr_winter,reorder_hgt_era_winter)
t_test_hgt_winter=sqrt(n-2)*hgt_correlation_winter/sqrt(1-hgt_correlation_winter^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_winter)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_winter)

out5=addfile("cor_hgt_csrf.nc","c")
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
