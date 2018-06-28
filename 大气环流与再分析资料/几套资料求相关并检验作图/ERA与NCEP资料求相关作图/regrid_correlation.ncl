load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

ncep_u_file=addfile("uwnd.mon.mean.nc","r")
ncep_v_file=addfile("vwnd.mon.mean.nc","r")
ncep_hgt_file=addfile("hgt.mon.mean.nc","r")

ncep_u=(ncep_u_file->uwnd)*0.01+187.65
ncep_v=(ncep_v_file->vwnd)*0.01+187.65
ncep_hgt=(ncep_hgt_file->hgt)*1.0+31265.0

copy_VarCoords(ncep_u_file->uwnd,ncep_u)
copy_VarCoords(ncep_v_file->vwnd,ncep_v)
copy_VarCoords(ncep_hgt_file->hgt,ncep_hgt)

printVarSummary(ncep_u)
ncep_lat=ncep_u_file->lat
ncep_lon=ncep_u_file->lon
ncep_lev=ncep_u_file->level
ncep_time=ut_calendar(ncep_u_file->time,-1)

era_file=addfile("ERA-UV.nc","r")
e_file=addfile("ERA-GEO.nc","r")
era_u=(era_file->u(:,16:0,:,:))*0.002767466033334351+20.78932671620208
era_v=(era_file->v(:,16:0,:,:))*0.002142944680542627-0.3266940309340213
era_hgt=(e_file->z(:,16:0,:,:))*4.866332663207372+156219.190124684
copy_VarCoords(era_file->u(:,16:0,:,:),era_u)
copy_VarCoords(era_file->v(:,16:0,:,:),era_v)
copy_VarCoords(e_file->z(:,16:0,:,:),era_hgt)

printVarSummary(era_u)
era_lon=era_file->longitude
era_lat=era_file->latitude

uwnd=linint2_Wrap(ncep_lon,ncep_lat(72:0),ncep_u,True,era_lon,era_lat(240:0),0)
uwnd&latitude=era_file->latitude
printVarSummary(uwnd)
vwnd=linint2_Wrap(ncep_lon,ncep_lat(72:0),ncep_v,True,era_lon,era_lat(240:0),0)
vwnd&latitude=era_file->latitude
printVarSummary(vwnd)
hgt=linint2_Wrap(ncep_lon,ncep_lat(72:0),ncep_hgt,True,era_lon,era_lat(240:0),0)
hgt&latitude=era_file->latitude
printVarSummary(hgt)

ncep_u_spring_ave=month_to_season(uwnd,"MAM")
ncep_u_summer_ave=month_to_season(uwnd,"JJA")
ncep_u_autumn_ave=month_to_season(uwnd,"SON")
ncep_u_winter_ave=month_to_season(uwnd,"DJF")
ncep_u_year_ave=(ncep_u_spring_ave+ncep_u_summer_ave+ncep_u_autumn_ave+ncep_u_winter_ave)/4.0
copy_VarCoords(ncep_u_spring_ave,ncep_u_year_ave)
printVarSummary(ncep_u_year_ave)

ncep_v_spring_ave=month_to_season(vwnd,"MAM")
ncep_v_summer_ave=month_to_season(vwnd,"JJA")
ncep_v_autumn_ave=month_to_season(vwnd,"SON")
ncep_v_winter_ave=month_to_season(vwnd,"DJF")
ncep_v_year_ave=(ncep_v_spring_ave+ncep_v_summer_ave+ncep_v_autumn_ave+ncep_v_winter_ave)/4.0
copy_VarCoords(ncep_v_spring_ave,ncep_v_year_ave)
printVarSummary(ncep_v_year_ave)

ncep_hgt_spring_ave=month_to_season(hgt,"MAM")
ncep_hgt_summer_ave=month_to_season(hgt,"JJA")
ncep_hgt_autumn_ave=month_to_season(hgt,"SON")
ncep_hgt_winter_ave=month_to_season(hgt,"DJF")
ncep_hgt_year_ave=(ncep_hgt_spring_ave+ncep_hgt_summer_ave+ncep_hgt_autumn_ave+ncep_hgt_winter_ave)/4.0
copy_VarCoords(ncep_hgt_spring_ave,ncep_hgt_year_ave)
printVarSummary(ncep_hgt_year_ave)

era_u_spring_ave=month_to_season(era_u,"MAM")
era_u_summer_ave=month_to_season(era_u,"JJA")
era_u_autumn_ave=month_to_season(era_u,"SON")
era_u_winter_ave=month_to_season(era_u,"DJF")
era_u_year_ave=(era_u_spring_ave+era_u_summer_ave+era_u_autumn_ave+era_u_winter_ave)/4.0
copy_VarCoords(era_u_spring_ave,era_u_year_ave)
printVarSummary(era_u_year_ave)

era_v_spring_ave=month_to_season(era_v,"MAM")
era_v_summer_ave=month_to_season(era_v,"JJA")
era_v_autumn_ave=month_to_season(era_v,"SON")
era_v_winter_ave=month_to_season(era_v,"DJF")
era_v_year_ave=(era_v_spring_ave+era_v_summer_ave+era_v_autumn_ave+era_v_winter_ave)/4.0
copy_VarCoords(era_v_spring_ave,era_v_year_ave)
printVarSummary(era_v_year_ave)

era_hgt_spring_ave=month_to_season(era_hgt,"MAM")
era_hgt_summer_ave=month_to_season(era_hgt,"JJA")
era_hgt_autumn_ave=month_to_season(era_hgt,"SON")
era_hgt_winter_ave=month_to_season(era_hgt,"DJF")
era_hgt_year_ave=(era_hgt_spring_ave+era_hgt_summer_ave+era_hgt_autumn_ave+era_hgt_winter_ave)/4.0
copy_VarCoords(era_hgt_spring_ave,era_hgt_year_ave)
printVarSummary(era_hgt_year_ave)

reorder_u_ncep_year=ncep_u_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_ncep_spring=ncep_u_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_ncep_summer=ncep_u_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_ncep_autumn=ncep_u_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_ncep_winter=ncep_u_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_u_ncep_year)

reorder_v_ncep_year=ncep_v_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_ncep_spring=ncep_v_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_ncep_summer=ncep_v_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_ncep_autumn=ncep_v_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_ncep_winter=ncep_v_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_v_ncep_year)

reorder_hgt_ncep_year=ncep_hgt_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_ncep_spring=ncep_hgt_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_ncep_summer=ncep_hgt_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_ncep_autumn=ncep_hgt_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_ncep_winter=ncep_hgt_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_hgt_ncep_year)

reorder_u_era_year=era_u_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_spring=era_u_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_summer=era_u_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_autumn=era_u_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_u_era_winter=era_u_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_u_era_year)

reorder_v_era_year=era_v_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_spring=era_v_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_summer=era_v_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_autumn=era_v_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_v_era_winter=era_v_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_v_era_year)

reorder_hgt_era_year=era_hgt_year_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_spring=era_hgt_spring_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_summer=era_hgt_summer_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_autumn=era_hgt_autumn_ave(level|:,latitude|:,longitude|:,time|:)
reorder_hgt_era_winter=era_hgt_winter_ave(level|:,latitude|:,longitude|:,time|:)
printVarSummary(reorder_hgt_era_year)

n=35

u_correlation_year=escorc(reorder_u_ncep_year,reorder_u_era_year)
t_test_u_year=sqrt(n-2)*u_correlation_year/sqrt(1-u_correlation_year^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_year)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_year)
printVarSummary(u_correlation_year)
printVarSummary(t_test_u_year)

v_correlation_year=escorc(reorder_v_ncep_year,reorder_v_era_year)
t_test_v_year=sqrt(n-2)*v_correlation_year/sqrt(1-v_correlation_year^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_year)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_year)
printVarSummary(v_correlation_year)
printVarSummary(t_test_v_year)

hgt_correlation_year=escorc(reorder_hgt_ncep_year,reorder_hgt_era_year)
t_test_hgt_year=sqrt(n-2)*hgt_correlation_year/sqrt(1-hgt_correlation_year^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_year)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_year)
printVarSummary(hgt_correlation_year)
printVarSummary(t_test_hgt_year)



u_correlation_spring=escorc(reorder_u_ncep_spring,reorder_u_era_spring)
t_test_u_spring=sqrt(n-2)*u_correlation_spring/sqrt(1-u_correlation_spring^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_spring)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_spring)
printVarSummary(u_correlation_spring)
printVarSummary(t_test_u_spring)

v_correlation_spring=escorc(reorder_v_ncep_spring,reorder_v_era_spring)
t_test_v_spring=sqrt(n-2)*v_correlation_spring/sqrt(1-v_correlation_spring^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_spring)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_spring)
printVarSummary(v_correlation_spring)
printVarSummary(t_test_v_spring)

hgt_correlation_spring=escorc(reorder_hgt_ncep_spring,reorder_hgt_era_spring)
t_test_hgt_spring=sqrt(n-2)*hgt_correlation_spring/sqrt(1-hgt_correlation_spring^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_spring)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_spring)
printVarSummary(hgt_correlation_spring)
printVarSummary(t_test_hgt_spring)



u_correlation_summer=escorc(reorder_u_ncep_summer,reorder_u_era_summer)
t_test_u_summer=sqrt(n-2)*u_correlation_summer/sqrt(1-u_correlation_summer^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_summer)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_summer)
printVarSummary(u_correlation_summer)
printVarSummary(t_test_u_summer)

v_correlation_summer=escorc(reorder_v_ncep_summer,reorder_v_era_summer)
t_test_v_summer=sqrt(n-2)*v_correlation_summer/sqrt(1-v_correlation_summer^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_summer)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_summer)
printVarSummary(v_correlation_summer)
printVarSummary(t_test_v_summer)

hgt_correlation_summer=escorc(reorder_hgt_ncep_summer,reorder_hgt_era_summer)
t_test_hgt_summer=sqrt(n-2)*hgt_correlation_summer/sqrt(1-hgt_correlation_summer^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_summer)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_summer)
printVarSummary(hgt_correlation_summer)
printVarSummary(t_test_hgt_summer)


u_correlation_autumn=escorc(reorder_u_ncep_autumn,reorder_u_era_autumn)
t_test_u_autumn=sqrt(n-2)*u_correlation_autumn/sqrt(1-u_correlation_autumn^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_autumn)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_autumn)
printVarSummary(u_correlation_autumn)
printVarSummary(t_test_u_autumn)

v_correlation_autumn=escorc(reorder_v_ncep_autumn,reorder_v_era_autumn)
t_test_v_autumn=sqrt(n-2)*v_correlation_autumn/sqrt(1-v_correlation_autumn^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_autumn)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_autumn)
printVarSummary(v_correlation_autumn)
printVarSummary(t_test_v_autumn)

hgt_correlation_autumn=escorc(reorder_hgt_ncep_autumn,reorder_hgt_era_autumn)
t_test_hgt_autumn=sqrt(n-2)*hgt_correlation_autumn/sqrt(1-hgt_correlation_autumn^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_autumn)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_autumn)
printVarSummary(hgt_correlation_autumn)
printVarSummary(t_test_hgt_autumn)


u_correlation_winter=escorc(reorder_u_ncep_winter,reorder_u_era_winter)
t_test_u_winter=sqrt(n-2)*u_correlation_winter/sqrt(1-u_correlation_winter^2)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),u_correlation_winter)
copy_VarCoords(reorder_u_era_winter(:,:,:,0),t_test_u_winter)
printVarSummary(u_correlation_winter)
printVarSummary(t_test_u_winter)

v_correlation_winter=escorc(reorder_v_ncep_winter,reorder_v_era_winter)
t_test_v_winter=sqrt(n-2)*v_correlation_winter/sqrt(1-v_correlation_winter^2)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),v_correlation_winter)
copy_VarCoords(reorder_v_era_winter(:,:,:,0),t_test_v_winter)
printVarSummary(v_correlation_winter)
printVarSummary(t_test_v_winter)

hgt_correlation_winter=escorc(reorder_hgt_ncep_winter,reorder_hgt_era_winter)
t_test_hgt_winter=sqrt(n-2)*hgt_correlation_winter/sqrt(1-hgt_correlation_winter^2)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),hgt_correlation_winter)
copy_VarCoords(reorder_hgt_era_winter(:,:,:,0),t_test_hgt_winter)
printVarSummary(hgt_correlation_winter)
printVarSummary(t_test_hgt_winter)

out1=addfile("cor_u.nc","c")
out1->u_correlation_year=u_correlation_year
out1->u_correlation_spring=u_correlation_spring
out1->u_correlation_summer=u_correlation_summer
out1->u_correlation_autumn=u_correlation_autumn
out1->u_correlation_winter=u_correlation_winter
out1->t_test_u_year=t_test_u_year
out1->t_test_u_spring=t_test_u_spring
out1->t_test_u_summer=t_test_u_summer
out1->t_test_u_autumn=t_test_u_autumn
out1->t_test_u_winter=t_test_u_winter

out2=addfile("cor_v.nc","c")
out2->v_correlation_year=v_correlation_year
out2->v_correlation_spring=v_correlation_spring
out2->v_correlation_summer=v_correlation_summer
out2->v_correlation_autumn=v_correlation_autumn
out2->v_correlation_winter=v_correlation_winter
out2->t_test_v_year=t_test_v_year
out2->t_test_v_spring=t_test_v_spring
out2->t_test_v_summer=t_test_v_summer
out2->t_test_v_autumn=t_test_v_autumn
out2->t_test_v_winter=t_test_v_winter
  
out3=addfile("cor_hgt.nc","c")
out3->hgt_correlation_year=hgt_correlation_year
out3->hgt_correlation_spring=hgt_correlation_spring
out3->hgt_correlation_summer=hgt_correlation_summer
out3->hgt_correlation_autumn=hgt_correlation_autumn
out3->hgt_correlation_winter=hgt_correlation_winter
out3->t_test_hgt_year=t_test_hgt_year
out3->t_test_hgt_spring=t_test_hgt_spring
out3->t_test_hgt_summer=t_test_hgt_summer
out3->t_test_hgt_autumn=t_test_hgt_autumn
out3->t_test_hgt_winter=t_test_hgt_winter  
  
  