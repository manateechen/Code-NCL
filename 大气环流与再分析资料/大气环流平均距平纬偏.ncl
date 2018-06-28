load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

path="hgt.mon.mean.nc"
data=addfile(path,"r")
lev=data->level
lat=data->lat
lon=data->lon
ti=data->time

dim_lev=dimsizes(lev)
dim_lon=dimsizes(lon)
dim_lat=dimsizes(lat)
dim_tim=dimsizes(ti)/12*12

tim=ut_calendar(ti(0:dim_tim-1),-1)
hgt=data->hgt(0:dim_tim-1,:,:,:)

ind_500=ind(lev.eq.500)

;500hPa高度长期平均
h_ave=dim_avg_n_Wrap(hgt(:,ind_500,:,:),0)

;500hPa高度距平
h_ano=dim_rmvmean_n_Wrap(hgt(:,ind_500,:,:),0)

;500hPa高度纬偏
hla=dim_rmvmean_n_Wrap(hgt(:,ind_500,:,:),2)

res = True
res @gsnMaximize = True
res @gsnAddCyclic = True
res @cnFillOn = True             
res @cnLineLabelsOn = False
res @cnLinesOn = False

wks=gsn_open_wks("x11","General Circulation")

;500hPa高度长期平均图像
res @tiMainString = "Long time average"
plot = gsn_csm_contour_map(wks,h_ave,res)

;500hPa高度距平图像
ind_t=ind(tim.eq.200801)
res @tiMainString = "Anomaly "+"200801"
plot = gsn_csm_contour_map(wks,h_ano(ind_t,:,:),res)

;500hPa高度纬偏图像
res @tiMainString = "HLA "+"200801"
plot = gsn_csm_contour_map(wks,hla(ind_t,:,:),res)






