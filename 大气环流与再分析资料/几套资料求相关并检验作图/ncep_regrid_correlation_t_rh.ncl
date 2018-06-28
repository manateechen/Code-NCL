load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

ncep_t_file=addfile("air.mon.mean.nc","r")
ncep_rh_file=addfile("rhum.mon.mean.nc","r")

ncep_t=(ncep_t_file->air)*0.01+465.15
ncep_rh=(ncep_rh_file->rhum)*0.01+302.65
copy_VarCoords(ncep_t_file->air,ncep_t)
copy_VarCoords(ncep_rh_file->rhum,ncep_rh)
printVarSummary(ncep_t)
ncep_lat=ncep_t_file->lat
ncep_lon=ncep_t_file->lon
ncep_lev=ncep_t_file->level
ncep_time=ut_calendar(ncep_t_file->time,-1)

era_file=addfile("ERA_T_R.nc","r")
era_t=(era_file->t(:,16:0,:,:))*0.00126939862359422+271.0304321952195
era_rh=(era_file->r(:,16:0,:,:))*0.001756458395684075+57.55215237153708
copy_VarCoords(era_file->t(:,16:0,:,:),era_t)
copy_VarCoords(era_file->r(:,16:0,:,:),era_rh)
printVarSummary(era_t)
era_lon=era_file->longitude
era_lat=era_file->latitude

air=linint2_Wrap(ncep_lon,ncep_lat(72:0),ncep_t,True,era_lon,era_lat(240:0),0)
air&latitude=era_file->latitude
printVarSummary(air)
rhum=linint2_Wrap(ncep_lon,ncep_lat(72:0),ncep_rh,True,era_lon,era_lat(240:0),0)
rhum&latitude=era_file->latitude
printVarSummary(rhum)

ncep_t_spring_ave=month_to_season(air,"MAM")
ncep_t_summer_ave=month_to_season(air,"JJA")
ncep_t_autumn_ave=month_to_season(air,"SON")
ncep_t_winter_ave=month_to_season(air,"DJF")
ncep_t_year_ave=(ncep_t_spring_ave+ncep_t_summer_ave+ncep_t_autumn_ave+ncep_t_winter_ave)/4.0
copy_VarCoords(ncep_t_spring_ave,ncep_t_year_ave)
printVarSummary(ncep_t_year_ave)

ncep_r_spring_ave=month_to_season(rhum,"MAM")
ncep_r_summer_ave=month_to_season(rhum,"JJA")
ncep_r_autumn_ave=month_to_season(rhum,"SON")
ncep_r_winter_ave=month_to_season(rhum,"DJF")
ncep_r_year_ave=(ncep_r_spring_ave+ncep_r_summer_ave+ncep_r_autumn_ave+ncep_r_winter_ave)/4.0
copy_VarCoords(ncep_r_spring_ave,ncep_r_year_ave)
printVarSummary(ncep_r_year_ave)

era_t_spring_ave=month_to_season(era_t,"MAM")
era_t_summer_ave=month_to_season(era_t,"JJA")
era_t_autumn_ave=month_to_season(era_t,"SON")
era_t_winter_ave=month_to_season(era_t,"DJF")
era_t_year_ave=(era_t_spring_ave+era_t_summer_ave+era_t_autumn_ave+era_t_winter_ave)/4.0
copy_VarCoords(era_t_spring_ave,era_t_year_ave)
printVarSummary(era_t_year_ave)

era_r_spring_ave=month_to_season(era_rh,"MAM")
era_r_summer_ave=month_to_season(era_rh,"JJA")
era_r_autumn_ave=month_to_season(era_rh,"SON")
era_r_winter_ave=month_to_season(era_rh,"DJF")
era_r_year_ave=(era_r_spring_ave+era_r_summer_ave+era_r_autumn_ave+era_r_winter_ave)/4.0
copy_VarCoords(era_r_spring_ave,era_r_year_ave)
printVarSummary(era_r_year_ave)

reorder_t_ncep_year=ncep_t_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_ncep_spring=ncep_t_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_ncep_summer=ncep_t_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_ncep_autumn=ncep_t_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_ncep_winter=ncep_t_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_t_ncep_year)

reorder_r_ncep_year=ncep_r_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_ncep_spring=ncep_r_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_ncep_summer=ncep_r_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_ncep_autumn=ncep_r_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_ncep_winter=ncep_r_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_r_ncep_year)

reorder_t_era_year=era_t_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_spring=era_t_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_summer=era_t_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_autumn=era_t_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_t_era_winter=era_t_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_t_era_year)

reorder_r_era_year=era_r_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_spring=era_r_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_summer=era_r_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_autumn=era_r_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_r_era_winter=era_r_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_r_era_year)

n=35

t_correlation_year=escorc(reorder_t_ncep_year,reorder_t_era_year)
t_test_t_year=sqrt(n-2)*t_correlation_year/sqrt(1-t_correlation_year^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_year)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_year)
printVarSummary(t_correlation_year)
printVarSummary(t_test_t_year)

r_correlation_year=escorc(reorder_r_ncep_year,reorder_r_era_year)
t_test_r_year=sqrt(n-2)*r_correlation_year/sqrt(1-r_correlation_year^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_year)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_year)
printVarSummary(r_correlation_year)
printVarSummary(t_test_r_year)

t_correlation_spring=escorc(reorder_t_ncep_spring,reorder_t_era_spring)
t_test_t_spring=sqrt(n-2)*t_correlation_spring/sqrt(1-t_correlation_spring^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_spring)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_spring)
printVarSummary(t_correlation_spring)
printVarSummary(t_test_t_spring)

r_correlation_spring=escorc(reorder_r_ncep_spring,reorder_r_era_spring)
t_test_r_spring=sqrt(n-2)*r_correlation_spring/sqrt(1-r_correlation_spring^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_spring)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_spring)
printVarSummary(r_correlation_spring)
printVarSummary(t_test_r_spring)

t_correlation_summer=escorc(reorder_t_ncep_summer,reorder_t_era_summer)
t_test_t_summer=sqrt(n-2)*t_correlation_summer/sqrt(1-t_correlation_summer^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_summer)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_summer)
printVarSummary(t_correlation_summer)
printVarSummary(t_test_t_summer)

r_correlation_summer=escorc(reorder_r_ncep_summer,reorder_r_era_summer)
t_test_r_summer=sqrt(n-2)*r_correlation_summer/sqrt(1-r_correlation_summer^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_summer)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_summer)
printVarSummary(r_correlation_summer)
printVarSummary(t_test_r_summer)

t_correlation_autumn=escorc(reorder_t_ncep_autumn,reorder_t_era_autumn)
t_test_t_autumn=sqrt(n-2)*t_correlation_autumn/sqrt(1-t_correlation_autumn^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_autumn)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_autumn)
printVarSummary(t_correlation_autumn)
printVarSummary(t_test_t_autumn)

r_correlation_autumn=escorc(reorder_r_ncep_autumn,reorder_r_era_autumn)
t_test_r_autumn=sqrt(n-2)*r_correlation_autumn/sqrt(1-r_correlation_autumn^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_autumn)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_autumn)
printVarSummary(r_correlation_autumn)
printVarSummary(t_test_r_autumn)

t_correlation_winter=escorc(reorder_t_ncep_winter,reorder_t_era_winter)
t_test_t_winter=sqrt(n-2)*t_correlation_winter/sqrt(1-t_correlation_winter^2)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_correlation_winter)
copy_VarCoords(reorder_t_era_winter(:,:,:,0),t_test_t_winter)
printVarSummary(t_correlation_winter)
printVarSummary(t_test_t_winter)

r_correlation_winter=escorc(reorder_r_ncep_winter,reorder_r_era_winter)
t_test_r_winter=sqrt(n-2)*r_correlation_winter/sqrt(1-r_correlation_winter^2)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),r_correlation_winter)
copy_VarCoords(reorder_r_era_winter(:,:,:,0),t_test_r_winter)
printVarSummary(r_correlation_winter)
printVarSummary(t_test_r_winter)


out1=addfile("cor_t.nc","c")
out1->t_correlation_year=t_correlation_year
out1->t_correlation_spring=t_correlation_spring
out1->t_correlation_summer=t_correlation_summer
out1->t_correlation_autumn=t_correlation_autumn
out1->t_correlation_winter=t_correlation_winter
out1->t_test_t_year=t_test_t_year
out1->t_test_t_spring=t_test_t_spring
out1->t_test_t_summer=t_test_t_summer
out1->t_test_t_autumn=t_test_t_autumn
out1->t_test_t_winter=t_test_t_winter

out2=addfile("cor_r.nc","c")
out2->r_correlation_year=r_correlation_year
out2->r_correlation_spring=r_correlation_spring
out2->r_correlation_summer=r_correlation_summer
out2->r_correlation_autumn=r_correlation_autumn
out2->r_correlation_winter=r_correlation_winter
out2->t_test_r_year=t_test_r_year
out2->t_test_r_spring=t_test_r_spring
out2->t_test_r_summer=t_test_r_summer
out2->t_test_r_autumn=t_test_r_autumn
out2->t_test_r_winter=t_test_r_winter
  

  