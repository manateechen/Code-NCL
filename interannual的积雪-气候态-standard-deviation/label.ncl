load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "./interannual.ncl"
load "./decadal.ncl"


season="SON"
idx_A = 8 
idx_B = 9
idx_C = 10

yearstart = 1979
yearend = 2018
nyear = yearend - yearstart + 1

varfile = addfile("../ncfile/rutgersnownc/mysnowcover.nc","r")

vars = varfile->snowcover

lat=varfile->lat
lon=varfile->lon

lat_idx=ind(lat.ge.10.and.lat.le.55)
lon_idx=ind(lon.ge.40.and.lon.le.125)

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
copy_VarMeta(var, interan)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
;res@gsnMaximize=True

;res@mpLimitMode        = "Corners"               ; Portion of map to zoom
;res@mpLeftCornerLatF   = 20 ;lat(lat_idx(0))
;res@mpLeftCornerLonF   = 50 ;lon(lon_idx(0))
;res@mpRightCornerLatF  = 45 ;lat(lat_idx(dimsizes(lat_idx)-1))
;res@mpRightCornerLonF  = 120 ;lon(lon_idx(dimsizes(lon_idx)-1))

res@mpMinLatF              =  25
  res@mpMaxLatF              =  45
  res@mpMinLonF              = 70
  res@mpMaxLonF              = 105

res@mpGridAndLimbOn        = True  
res@pmTickMarkDisplayMode  = "Always"
res@mpGridLatSpacingF      = 5
res@mpGridLonSpacingF      = 5

res@mpGridLineDashPattern  = 5

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(5,55,5)

res@lbOrientation="horizontal"

res@gsnMaximize=True
res@vpWidthF      = 0.4
res@vpHeightF     = 0.6

res@gsnLeftString=""
res@gsnRightString=""


resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness


wks = gsn_open_wks("eps", "label")
gsn_define_colormap(wks,"WhiteBlue")


map = gsn_csm_contour_map(wks, dim_avg_n_Wrap(var,0), res)


resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("../tibet_shape",(/2066,2/),"float")

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

draw(wks)
frame(wks)
delete(wks)

wks = gsn_open_wks("eps", "snowcover-int")
gsn_define_colormap(wks,"WhiteBlue")

plots = gsn_csm_contour_map(wks,  dim_stddev_n_Wrap(interan, 0),res)
poli=gsn_add_polyline(wks,plots,f(:,0),f(:,1),resp)

dum11 = new(4,graphic)
do i = 0 , 3
    dum11(i)=gsn_add_polyline(wks,plots,xpts(i:i+1),ypts(i:i+1),resc)
end do

draw(wks)
frame(wks)
