load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "./taylor_diagram.ncl"
load "./taylor_metrics_table.ncl" 

cli_pre_file=addfile("climate_pre.nc","r")
cli_tm_file=addfile("climate_tm.nc","r")
lat=cli_pre_file->lat
lon=cli_pre_file->lon
era_pre_file=addfile("era_pre.nc","r")
era_tm_file=addfile("era_2mt.nc","r")

ind_r1_lat=ind(lat.le.27)
ind_r2_lat=ind(lat.le.33.and.lat.ge.27)
ind_r2_lon=ind(lon.ge.98)
ind_r3_lat=ind(lat.le.43.and.lat.ge.33)
ind_r3_lon=ind(lon.ge.98)
ind_r4_lat=ind(lat.ge.43)
ind_r5_lat=ind(lat.ge.35)
ind_r5_lon=ind(lon.le.98)
ind_r6_lat=ind(lat.le.35)
ind_r6_lon=ind(lon.le.98)

cli_pre_r1=cli_pre_file->pre(:,ind_r1_lat,:)
era_pre_r1=era_pre_file->pre(:,ind_r1_lat,:)
cli_tm_r1=cli_tm_file->tm(:,ind_r1_lat,:)
era_tm_r1=era_tm_file->2mt(:,ind_r1_lat,:)

cli_pre_r2=cli_pre_file->pre(:,ind_r2_lat,ind_r2_lon)
era_pre_r2=era_pre_file->pre(:,ind_r2_lat,ind_r2_lon)
cli_tm_r2=cli_tm_file->tm(:,ind_r2_lat,ind_r2_lon)
era_tm_r2=era_tm_file->2mt(:,ind_r2_lat,ind_r2_lon)

cli_pre_r3=cli_pre_file->pre(:,ind_r3_lat,ind_r3_lon)
era_pre_r3=era_pre_file->pre(:,ind_r3_lat,ind_r3_lon)
cli_tm_r3=cli_tm_file->tm(:,ind_r3_lat,ind_r3_lon)
era_tm_r3=era_tm_file->2mt(:,ind_r3_lat,ind_r3_lon)

cli_pre_r4=cli_pre_file->pre(:,ind_r4_lat,:)
era_pre_r4=era_pre_file->pre(:,ind_r4_lat,:)
cli_tm_r4=cli_tm_file->tm(:,ind_r4_lat,:)
era_tm_r4=era_tm_file->2mt(:,ind_r4_lat,:)

cli_pre_r5=cli_pre_file->pre(:,ind_r5_lat,ind_r5_lon)
era_pre_r5=era_pre_file->pre(:,ind_r5_lat,ind_r5_lon)
cli_tm_r5=cli_tm_file->tm(:,ind_r5_lat,ind_r5_lon)
era_tm_r5=era_tm_file->2mt(:,ind_r5_lat,ind_r5_lon)

cli_pre_r6=cli_pre_file->pre(:,ind_r6_lat,ind_r6_lon)
era_pre_r6=era_pre_file->pre(:,ind_r6_lat,ind_r6_lon)
cli_tm_r6=cli_tm_file->tm(:,ind_r6_lat,ind_r6_lon)
era_tm_r6=era_tm_file->2mt(:,ind_r6_lat,ind_r6_lon)

cli_pre_r1_ave_1=dim_avg_n_Wrap(cli_pre_r1,0)
era_pre_r1_ave_1=dim_avg_n_Wrap(era_pre_r1,0)
cli_tm_r1_ave_1=dim_avg_n_Wrap(cli_tm_r1,0)
era_tm_r1_ave_1=dim_avg_n_Wrap(era_tm_r1,0)
cli_pre_r2_ave_1=dim_avg_n_Wrap(cli_pre_r2,0)
era_pre_r2_ave_1=dim_avg_n_Wrap(era_pre_r2,0)
cli_tm_r2_ave_1=dim_avg_n_Wrap(cli_tm_r2,0)
era_tm_r2_ave_1=dim_avg_n_Wrap(era_tm_r2,0)
cli_pre_r3_ave_1=dim_avg_n_Wrap(cli_pre_r3,0)
era_pre_r3_ave_1=dim_avg_n_Wrap(era_pre_r3,0)
cli_tm_r3_ave_1=dim_avg_n_Wrap(cli_tm_r3,0)
era_tm_r3_ave_1=dim_avg_n_Wrap(era_tm_r3,0)
cli_pre_r4_ave_1=dim_avg_n_Wrap(cli_pre_r4,0)
era_pre_r4_ave_1=dim_avg_n_Wrap(era_pre_r4,0)
cli_tm_r4_ave_1=dim_avg_n_Wrap(cli_tm_r4,0)
era_tm_r4_ave_1=dim_avg_n_Wrap(era_tm_r4,0)
cli_pre_r5_ave_1=dim_avg_n_Wrap(cli_pre_r5,0)
era_pre_r5_ave_1=dim_avg_n_Wrap(era_pre_r5,0)
cli_tm_r5_ave_1=dim_avg_n_Wrap(cli_tm_r5,0)
era_tm_r5_ave_1=dim_avg_n_Wrap(era_tm_r5,0)
cli_pre_r6_ave_1=dim_avg_n_Wrap(cli_pre_r6,0)
era_pre_r6_ave_1=dim_avg_n_Wrap(era_pre_r6,0)
cli_tm_r6_ave_1=dim_avg_n_Wrap(cli_tm_r6,0)
era_tm_r6_ave_1=dim_avg_n_Wrap(era_tm_r6,0)
pattern_correlation=new((/6,2/),"float")
pattern_correlation(0,0)=pattern_cor(cli_pre_r1_ave_1,era_pre_r1_ave_1,1.0,0)
pattern_correlation(0,1)=pattern_cor(cli_tm_r1_ave_1,era_tm_r1_ave_1,1.0,0)
pattern_correlation(1,0)=pattern_cor(cli_pre_r2_ave_1,era_pre_r2_ave_1,1.0,0)
pattern_correlation(1,1)=pattern_cor(cli_tm_r2_ave_1,era_tm_r2_ave_1,1.0,0)
pattern_correlation(2,0)=pattern_cor(cli_pre_r3_ave_1,era_pre_r3_ave_1,1.0,0)
pattern_correlation(2,1)=pattern_cor(cli_tm_r3_ave_1,era_tm_r3_ave_1,1.0,0)
pattern_correlation(3,0)=pattern_cor(cli_pre_r4_ave_1,era_pre_r4_ave_1,1.0,0)
pattern_correlation(3,1)=pattern_cor(cli_tm_r4_ave_1,era_tm_r4_ave_1,1.0,0)
pattern_correlation(4,0)=pattern_cor(cli_pre_r5_ave_1,era_pre_r5_ave_1,1.0,0)
pattern_correlation(4,1)=pattern_cor(cli_tm_r5_ave_1,era_tm_r5_ave_1,1.0,0)
pattern_correlation(5,0)=pattern_cor(cli_pre_r6_ave_1,era_pre_r6_ave_1,1.0,0)
pattern_correlation(5,1)=pattern_cor(cli_tm_r6_ave_1,era_tm_r6_ave_1,1.0,0)
print(pattern_correlation)

cli_pre_r1_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_pre_r1,2),1)
era_pre_r1_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre_r1,2),1)
cli_tm_r1_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_tm_r1,2),1)
era_tm_r1_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_tm_r1,2),1)
variance_pre_r1_0=dim_variance_n_Wrap(cli_pre_r1_ave2,0)
variance_pre_r1_1=dim_variance_n_Wrap(era_pre_r1_ave2,0)
variance_tm_r1_0=dim_variance_n_Wrap(cli_tm_r1_ave2,0)
variance_tm_r1_1=dim_variance_n_Wrap(era_tm_r1_ave2,0)
cli_pre_r2_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_pre_r2,2),1)
era_pre_r2_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre_r2,2),1)
cli_tm_r2_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_tm_r2,2),1)
era_tm_r2_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_tm_r2,2),1)
variance_pre_r2_0=dim_variance_n_Wrap(cli_pre_r2_ave2,0)
variance_pre_r2_1=dim_variance_n_Wrap(era_pre_r2_ave2,0)
variance_tm_r2_0=dim_variance_n_Wrap(cli_tm_r2_ave2,0)
variance_tm_r2_1=dim_variance_n_Wrap(era_tm_r2_ave2,0)
cli_pre_r3_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_pre_r3,2),1)
era_pre_r3_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre_r3,2),1)
cli_tm_r3_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_tm_r3,2),1)
era_tm_r3_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_tm_r3,2),1)
variance_pre_r3_0=dim_variance_n_Wrap(cli_pre_r3_ave2,0)
variance_pre_r3_1=dim_variance_n_Wrap(era_pre_r3_ave2,0)
variance_tm_r3_0=dim_variance_n_Wrap(cli_tm_r3_ave2,0)
variance_tm_r3_1=dim_variance_n_Wrap(era_tm_r3_ave2,0)
cli_pre_r4_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_pre_r4,2),1)
era_pre_r4_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre_r4,2),1)
cli_tm_r4_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_tm_r4,2),1)
era_tm_r4_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_tm_r4,2),1)
variance_pre_r4_0=dim_variance_n_Wrap(cli_pre_r4_ave2,0)
variance_pre_r4_1=dim_variance_n_Wrap(era_pre_r4_ave2,0)
variance_tm_r4_0=dim_variance_n_Wrap(cli_tm_r4_ave2,0)
variance_tm_r4_1=dim_variance_n_Wrap(era_tm_r4_ave2,0)
cli_pre_r5_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_pre_r5,2),1)
era_pre_r5_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre_r5,2),1)
cli_tm_r5_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_tm_r5,2),1)
era_tm_r5_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_tm_r5,2),1)
variance_pre_r5_0=dim_variance_n_Wrap(cli_pre_r5_ave2,0)
variance_pre_r5_1=dim_variance_n_Wrap(era_pre_r5_ave2,0)
variance_tm_r5_0=dim_variance_n_Wrap(cli_tm_r5_ave2,0)
variance_tm_r5_1=dim_variance_n_Wrap(era_tm_r5_ave2,0)
cli_pre_r6_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_pre_r6,2),1)
era_pre_r6_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre_r6,2),1)
cli_tm_r6_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_tm_r6,2),1)
era_tm_r6_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_tm_r6,2),1)
variance_pre_r6_0=dim_variance_n_Wrap(cli_pre_r6_ave2,0)
variance_pre_r6_1=dim_variance_n_Wrap(era_pre_r6_ave2,0)
variance_tm_r6_0=dim_variance_n_Wrap(cli_tm_r6_ave2,0)
variance_tm_r6_1=dim_variance_n_Wrap(era_tm_r6_ave2,0)

ratio=new((/6,2/),"float")
ratio(0,0)=variance_pre_r1_1/variance_pre_r1_0
ratio(0,1)=variance_tm_r1_1/variance_tm_r1_0
ratio(1,0)=variance_pre_r2_1/variance_pre_r2_0
ratio(1,1)=variance_tm_r2_1/variance_tm_r2_0
ratio(2,0)=variance_pre_r3_1/variance_pre_r3_0
ratio(2,1)=variance_tm_r3_1/variance_tm_r3_0
ratio(3,0)=variance_pre_r4_1/variance_pre_r4_0
ratio(3,1)=variance_tm_r4_1/variance_tm_r4_0
ratio(4,0)=variance_pre_r5_1/variance_pre_r5_0
ratio(4,1)=variance_tm_r5_1/variance_tm_r5_0
ratio(5,0)=variance_pre_r6_1/variance_pre_r6_0
ratio(5,1)=variance_tm_r6_1/variance_tm_r6_0
print(ratio)

source=(/"Precipitation","Temperature"/)
case      = (/ "Region I", "Region II" ,"Region III","Region IV", "Region V", "Region VI"/) 
ty_opt   = True 
ty_opt@gsnMaximize=True
ty_opt@varLabels     = source
ty_opt@caseLabels    = case
ty_opt@varLabelsYloc = 1.5
ty_opt@caseLabelsFontHeightF = 0.14 
ty_opt@varLabelsFontHeightF  = 0.011 
ty_opt@stnRad        = (/ 0.5, 1.5 /)
ty_opt@ccRays        = (/ 0.2, 0.4, 0.6, 0.8, 0.9, 0.95, 0.99, 1.0 /) 
ty_opt@centerDiffRMS = True
wks   = gsn_open_wks("eps","taylor")
plot  = taylor_diagram(wks,ratio,pattern_correlation,ty_opt)
