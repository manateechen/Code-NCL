load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

era_t_file=addfile("era_2mt.nc","r")
era_pre_file=addfile("era_pre.nc","r")
clm_t_file=addfile("climate_tm.nc","r")
clm_pre_file=addfile("climate_pre.nc","r")

era_t=era_t_file->2mt
era_pre=era_pre_file->pre
clm_t=clm_t_file->tm
clm_pre=clm_pre_file->pre

era_t_ave=dim_avg_n_Wrap(dim_avg_n_Wrap(era_t,2),1)-273.15
era_pre_ave=dim_avg_n_Wrap(dim_avg_n_Wrap(era_pre,2),1)
clm_t_ave=dim_avg_n_Wrap(dim_avg_n_Wrap(clm_t,2),1)
clm_pre_ave=dim_avg_n_Wrap(dim_avg_n_Wrap(clm_pre,2),1)

ip_era_t_ave=dim_pqsort(era_t_ave,1)
ip_era_pre_ave=dim_pqsort(era_pre_ave,1)
ip_clm_t_ave=dim_pqsort(clm_t_ave,1)
ip_clm_pre_ave=dim_pqsort(clm_pre_ave,1)

tercile=new(10,"integer")
tercile=(/2,9,23,46,55,64,73,82,87,91/)
x=fspan(15,21,10)
y=x
era_t_tercile=new((/2,10/),"float")
clm_t_tercile=new((/2,10/),"float")
era_t_tercile(1,:)=y
clm_t_tercile(1,:)=x
era_t_tercile(0,:)=era_t_ave(ip_era_t_ave(tercile))
clm_t_tercile(0,:)=era_t_ave(ip_clm_t_ave(tercile))

era_pre_tercile=new((/2,10/),"float")
clm_pre_tercile=new((/2,10/),"float")
x=fspan(2,12,10)
y=x
era_pre_tercile(1,:)=y
clm_pre_tercile(1,:)=x
era_pre_tercile(0,:)=era_pre_ave(ip_era_pre_ave(tercile))
clm_pre_tercile(0,:)=era_pre_ave(ip_clm_pre_ave(tercile))

res=True
res @gsnMaximize=True
res @xyMarkers=4
res @xyMarkerColor="red" 
res @xyMarkLineModes=(/"Markers","Lines"/)
res @xyExplicitLegendLabels = (/"ERA-Interim","perfect"/)
res @pmLegendOrthogonalPosF=-0.45
res @pmLegendParallelPosF=0.85
res @pmLegendDisplayMode="Always"
res @pmLegendWidthF=0.15
res @pmLegendHeightF=0.15
res @lgLabelFontHeightF=10

res @tiMainString="Quantiles of daily precipitation"
res @tiXAxisString="OBS (mm/day)"
res @tiYAxisString="mm/day"
wks=gsn_open_wks("eps" ,"tercile_pre")
plot=gsn_csm_xy(wks,clm_pre_tercile,era_pre_tercile,res)
delete(wks)

res @tiMainString="Quantiles of daily mean temperature"
res @tiXAxisString="OBS (~S~o~N~C)"
res @tiYAxisString="~S~o~N~C"
wks=gsn_open_wks("eps" ,"tercile_t")
plot1=gsn_csm_xy(wks,clm_t_tercile,era_t_tercile,res)
delete(wks)