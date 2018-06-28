load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "./taylor_diagram.ncl"
load "./taylor_metrics_table.ncl" 

cli_pre_file=addfile("climate_pre.nc","r")
cli_tm_file=addfile("climate_tm.nc","r")
era_pre_file=addfile("era_pre.nc","r")
era_tm_file=addfile("era_2mt.nc","r")

cli_pre=cli_pre_file->pre
era_pre=era_pre_file->pre
cli_tm=cli_tm_file->tm
era_tm=era_tm_file->2mt

cli_pre_ave_1=dim_avg_n_Wrap(cli_pre,0)
era_pre_ave_1=dim_avg_n_Wrap(era_pre,0)
cli_tm_ave_1=dim_avg_n_Wrap(cli_tm,0)
era_tm_ave_1=dim_avg_n_Wrap(era_tm,0)
pattern_correlation=new((/1,2/),"float")
pattern_correlation(0,0)=pattern_cor(cli_pre_ave_1,era_pre_ave_1,1.0,0)
pattern_correlation(0,1)=pattern_cor(cli_tm_ave_1,era_tm_ave_1,1.0,0)
print(pattern_correlation)

cli_pre_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_pre,2),1)
era_pre_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre,2),1)
cli_tm_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(cli_tm,2),1)
era_tm_ave2=dim_avg_n_Wrap(dim_avg_n_Wrap(era_tm,2),1)
variance_pre_0=dim_variance_n_Wrap(cli_pre_ave2,0)
variance_pre_1=dim_variance_n_Wrap(era_pre_ave2,0)
variance_tm_0=dim_variance_n_Wrap(cli_tm_ave2,0)
variance_tm_1=dim_variance_n_Wrap(era_tm_ave2,0)

ratio=new((/1,2/),"float")
ratio(0,0)=variance_pre_1/variance_pre_0
ratio(0,1)=variance_tm_1/variance_tm_0

source=(/"Precipitation","Temperature"/)
ty_opt   = True 
ty_opt@gsnMaximize=True
ty_opt@varLabels     = source
ty_opt@varLabelsYloc = 1.5
ty_opt@caseLabelsFontHeightF = 0.14 
ty_opt@varLabelsFontHeightF  = 0.011 
ty_opt@stnRad        = (/ 0.5, 1.5 /)
ty_opt@ccRays        = (/ 0.6, 0.9 /) 
ty_opt@centerDiffRMS = True
wks   = gsn_open_wks("eps","taylor")
plot  = taylor_diagram(wks,ratio,pattern_correlation,ty_opt)
