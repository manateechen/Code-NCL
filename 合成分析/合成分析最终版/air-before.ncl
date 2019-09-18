load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

; SON
season = "SON"
idx_A = 8
idx_B = 9
idx_C = 10

yearstart = 1979
yearend = 1994
nyear = yearend - yearstart + 1

snow = asciiread("../../snow/before.txt",(/nyear/),"float")

uwindfile = addfile("../../ncfile/ncep2nc/uwnd.10m.mon.mean.nc","r")
vwindfile = addfile("../../ncfile/ncep2nc/vwnd.10m.mon.mean.nc","r")
airfile = addfile("../../ncfile/ncep2nc/air.2m.mon.mean.nc","r")

uwinds = short2flt(uwindfile->uwnd)
vwinds = short2flt(vwindfile->vwnd)
airs = short2flt(airfile->air(:,0,:,:))


lat_wind = uwindfile->lat
lon_wind = uwindfile->lon
year=calendar_decode2(uwindfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))

uwind= uwinds(year_idx,0,:,:)
vwind = vwinds(year_idx,0,:,:)
air = airs(year_idx,:,:)

hA = air(idx_A::12,:,:)
hB = air(idx_B::12,:,:)
hC = air(idx_C::12,:,:)
air_season = (hA + hB + hC) / 3.0 
copy_VarMeta(hC, air_season)

idxH = (/1,6/)
idxL = (/2,3,4,5,8,9,12,13/)

ave1 = dim_avg_n_Wrap(air_season(idxH,:,:), 0)
var1 = dim_stddev_n_Wrap(air_season(idxH,:,:), 0)
s1 = dimsizes(idxH)

ave2 = dim_avg_n_Wrap(air_season(idxL,:,:), 0)
var2 = dim_stddev_n_Wrap(air_season(idxL,:,:), 0)
s2 =  dimsizes(idxL)


hgt_high_ave = ave1
hgt_high_var = var1
hgt_low_ave = ave2
hgt_low_var = var2

n_high = s1
n_low = s2

diff = ave1-ave2
tval = diff/sqrt( ( (n_high-1.)*hgt_high_var^2+(n_low-1.)*hgt_low_var^2)/(n_high+n_low-2.0))/sqrt(1.0/n_high+1.0/n_low)  
tval = abs(tval)
copy_VarMeta(ave1,diff)
copy_VarMeta(ave1,tval)

ttestval =2.306

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnMaximize=True


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
res@cnLevels=fspan(-4,4,21)
;res@cnFillColors=(/2,18,34,50,66,82,0,0,146,162,178,194,210,226,242,255/)

res@lbOrientation="Vertical"

;res@cnFillOpacityF=0.8

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "air-before")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")


map = gsn_csm_contour_map(wks, diff, res)


resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,f(:,0),f(:,1),resp)



resshade=True
resshade@pmTickMarkDisplayMode="Always"
resshade@cnFillOn=True
resshade@cnLinesOn=False
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False
resshade@cnMonoFillColor=True

resshade@cnFillPatterns=(/-1,17/)
resshade@cnFillDotSizeF=0.004
resshade@cnFillColor = "black"
resshade@cnFillScaleF = 2.0

resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/ttestval/)
resshade@lbLabelBarOn=False
resshade@cnInfoLabelOn=False

resshade@gsnAddCyclic=False

resshade@gsnDraw=False
resshade@gsnFrame=False

resshade@gsnLeftString=""
resshade@gsnRightString=""


tval=smth9_Wrap(tval, 0.5, -0.25, False)



map3 = gsn_csm_contour(wks, tval, resshade)
overlay(map,map3)


tibet_lat_low = 27.5
tibet_lat_high = 36.0
tibet_lon_left = 88.5
tibet_lon_right = 100.5
ypts = (/tibet_lat_low,  tibet_lat_low, tibet_lat_high ,  tibet_lat_high, tibet_lat_low/)
xpts = (/tibet_lon_left, tibet_lon_right, tibet_lon_right, tibet_lon_left, tibet_lon_left/)
resc=True
resc@gsLineColor      = "red4"                     ; color of lines
resc@gsLineThicknessF = 3.0                       ; thickness of lines
dum5 = new(4,graphic)
dum6 = new(4,graphic)
dum7 = new(4,graphic)
dum8 = new(4,graphic)
do i = 0 , 3
  dum5(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum6(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum7(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum8(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do

draw(map)
frame(wks)

llat_idx = ind(lat_wind.ge.tibet_lat_low.and.lat_wind.le.tibet_lat_high)
llon_idx = ind(lon_wind.ge.tibet_lon_left.and.lon_wind.le.tibet_lon_right)
ave = dim_avg_n_Wrap(dim_avg_n_Wrap(diff(llat_idx,llon_idx), 0),0)

print(ave)

out = addfile("air-before.nc", "c")
out->diffbefore = diff