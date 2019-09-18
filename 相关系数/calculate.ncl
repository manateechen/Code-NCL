load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "./interannual.ncl"
load "./decadal.ncl"


season="OND"
idx_A = 9
idx_B = 10
idx_C = 11

yearstart = 1979
yearend = 2018
nyear = yearend - yearstart + 1

varfile = addfile("../ncfile/rutgersnownc/mysnowcover.nc","r")

vars = varfile->snowcover

lat=varfile->lat
lon=varfile->lon

lat_idx=ind(lat.ge.25.and.lat.le.46.5)
lon_idx=ind(lon.ge.64.and.lon.le.106)

year=calendar_decode2(varfile->time,0)
year_idx=ind(year(:,0).ge.yearstart.and.year(:,0).le.yearend)
;printVarSummary(year_idx)
;print(year(year_idx,0))

varss = vars(year_idx,lat_idx,lon_idx)

varA = varss(idx_A::12,:,:)
varB = varss(idx_B::12,:,:)
varC = varss(idx_C::12,:,:)

var = (varA+varB+varC)/3.0
copy_VarMeta(varA,var)

lat_tibet=lat(lat_idx)
lon_tibet=lon(lon_idx)


interan = var

do i = 0, dimsizes(lat_tibet)-1
    do j = 0, dimsizes(lon_tibet)-1
        interan(:,i,j) = 0
        interannual(var(:,i,j),interan(:,i,j),dimsizes(var(:,i,j)))   
    end do
end do

std_dev_interannual = smth9_Wrap(dim_stddev_n_Wrap(var,0),0.5,0.25,False)
;print(std_dev_interannual)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
;res@gsnMaximize=True

res@mpLimitMode        = "Corners"               ; Portion of map to zoom
res@mpLeftCornerLatF   = lat(lat_idx(0))
res@mpLeftCornerLonF   = lon(lon_idx(0))
res@mpRightCornerLatF  = lat(lat_idx(dimsizes(lat_idx)-1))
res@mpRightCornerLonF  = lon(lon_idx(dimsizes(lon_idx)-1))

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(10,70,10)

res@lbOrientation="Vertical"

res@gsnMaximize=True
res@vpWidthF      = 0.4
res@vpHeightF     = 0.6

res@gsnLeftString=""
res@gsnRightString=""


resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness


wks = gsn_open_wks("eps", "snowcover-interannual")
gsn_define_colormap(wks,"WhiteGreen")


map = gsn_csm_contour_map(wks, dim_avg_n_Wrap(var,0), res)


resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("../tibet_shape",(/2066,2/),"float")

resstd=True

resstd@cnLinesOn=True
resstd@cnLevelSelectionMode = "ExplicitLevels"
resstd@cnLevels=(/12,15,18/)

resstd@cnLineLabelDensityF=1

resstd@cnLineLabelsOn=True

resstd@cnMonoLevelFlag=False
resstd@cnLineLabelInterval=1

resstd@cnInfoLabelOn=False
resstd@cnLineThicknessF=2

resstd@cnLineLabelFontHeightF=0.007

resstd@gsnDraw=False
resstd@gsnFrame=False

resstd@gsnLeftString=""
resstd@gsnRightString=""

plots = gsn_csm_contour(wks,  std_dev_interannual,resstd)

overlay(map,plots)

poli=gsn_add_polyline(wks,map,f(:,0),f(:,1),resp)


lat_low = 27.5   ;29.0
lat_high = 36.0  ;34.0
lon_left = 88.5  ;90.0
lon_right = 100.5
ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
resc=True
resc@gsLineColor      = "red4"                     ; color of lines
resc@gsLineThicknessF = 6.0                       ; thickness of lines
dum1 = new(4,graphic)
do i = 0 , 3
    dum1(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do
idx_region_lat = ind(lat_tibet.ge.lat_low.and.lat_tibet.le.lat_high)
idx_region_lon=ind(lon_tibet.ge.lon_left.and.lon_tibet.le.lon_right)
region_ave = dim_avg_n_Wrap(dim_avg_n_Wrap(NewCosWeight(var(:,idx_region_lat,idx_region_lon)),2),1)
aa=linmsg(region_ave,0)
inter = aa
interannual(aa,inter,dimsizes(inter))  
reg_std = dim_standardize_n_Wrap(inter, 1, 0)

asciiwrite("interannual-"+season+".txt", reg_std)
asciiwrite("TPSC-"+season+".txt", dim_standardize_n_Wrap(region_ave, 1, 0))
asciiwrite("region_ave-"+season+".txt", region_ave)

delete(idx_region_lat)
delete(idx_region_lon)
delete(region_ave)
delete(aa)
delete(inter)
delete(reg_std)


draw(wks)
frame(wks)
