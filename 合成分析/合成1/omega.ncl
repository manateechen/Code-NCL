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
yearend = 2017
nyear = yearend - yearstart + 1

mylev = 500

hgtfile = addfile("/home/qqf/Documents/PhD-Working/mypaper/ncfile/ncep2nc/omega.mon.mean.nc","r")

hgts = short2flt(hgtfile->omega)



lat_wind = hgtfile->lat
lon_wind = hgtfile->lon
year=calendar_decode2(hgtfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))
level_wind = hgtfile->level
lev_wind = ind(level_wind.eq.mylev)

hgt = hgts(year_idx,lev_wind,:,:)

hA = hgt(idx_A::12,:,:)
hB = hgt(idx_B::12,:,:)
hC = hgt(idx_C::12,:,:)
hgt_season = dtrend_leftdim((hA + hB + hC) / 3.0 ,False)
copy_VarMeta(hC,hgt_season)

high_ind = (/3,7,8,12,15,18,25,30,36/)
n_high = dimsizes(high_ind)

hgt_high = hgt_season(high_ind,:,:)
hgt_high_ave = dim_avg_n_Wrap(hgt_high,0)-dim_avg_n_Wrap(hgt_season,0)
copy_VarMeta(hgt_season(0,:,:),hgt_high_ave)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = -20
;res@mpMinLonF = 40
;res@mpMaxLonF = 285

res@mpCenterLonF=180

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(-0.04, 0.04, 9)  

res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "omega")
gsn_define_colormap(wks,"ncl_default")

map = gsn_csm_contour_map(wks, hgt_high_ave, res)

resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)



tibet_lat_low = 30
tibet_lat_high = 40.0
tibet_lon_left = 70.0
tibet_lon_right = 82.0
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
