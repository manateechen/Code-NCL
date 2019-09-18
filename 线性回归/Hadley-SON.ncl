load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "../snow/interannual.ncl"

; SON
season = "SON"
idx_A = 8
idx_B = 9
idx_C = 10

yearstart = 1979
yearend = 1994
nyear = yearend - yearstart + 1

ttestval = 2.120 ;1.725 ;2.086

snow = asciiread("../snow/before.txt",(/nyear/),"float")

uwindfile = addfile("../ncfile/ncep2nc/uwnd.10m.mon.mean.nc","r")
vwindfile = addfile("../ncfile/ncep2nc/vwnd.10m.mon.mean.nc","r")
airfile = addfile("../ncfile/HadISST/HadISST_sst.nc","r")

uwinds = short2flt(uwindfile->uwnd)
vwinds = short2flt(vwindfile->vwnd)
airs = airfile->sst


lat_wind = uwindfile->lat
lon_wind = uwindfile->lon
year=calendar_decode2(uwindfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))

sst_year = calendar_decode2(airfile->time,0)
sst_year_idx = ind(sst_year(:,0).ge.(yearstart).and.sst_year(:,0).le.(yearend))

uwind= uwinds(year_idx,0,:,:)
vwind = vwinds(year_idx,0,:,:)
air = airs(sst_year_idx,:,:)

uA = uwind(idx_A::12,:,:)
uB = uwind(idx_B::12,:,:)
uC = uwind(idx_C::12,:,:)
uwind_season = (uA + uB + uC) / 3.0

vA = vwind(idx_A::12,:,:)
vB = vwind(idx_B::12,:,:)
vC = vwind(idx_C::12,:,:)
vwind_season = (vA + vB + vC) / 3.0

hA = air(idx_A::12,:,:)
hB = air(idx_B::12,:,:)
hC = air(idx_C::12,:,:)
air_season = (hA + hB + hC) / 3.0 
copy_VarMeta(hA, air_season)

rc_uwind = regCoef_n(snow, uwind_season, 0, 0)
rc_vwind = regCoef_n(snow, vwind_season, 0, 0)
rc_air = regCoef_n(snow, air_season, 0, 0)

rc_air = where(rc_air.ge.0.8.or.rc_air.le.-0.8, rc_air@_FillValue, rc_air)


tval_uwind = reshape(abs(rc_uwind@tval),(/dimsizes(rc_uwind(:,0)),dimsizes(rc_uwind(0,:))/))
tval_vwind = reshape(abs(rc_vwind@tval),(/dimsizes(rc_vwind(:,0)),dimsizes(rc_vwind(0,:))/))
tval_air = reshape(rc_air@tval,(/dimsizes(rc_air(:,0)),dimsizes(rc_air(0,:))/))

u_sig = where(tval_uwind.ge.ttestval.or.tval_vwind.ge.ttestval,rc_uwind,rc_uwind@_FillValue)
u_not_sig = where(tval_uwind.lt.ttestval.and.tval_vwind.lt.ttestval,rc_uwind,rc_uwind@_FillValue)

v_sig = where(tval_uwind.ge.ttestval.or.tval_vwind.ge.ttestval,rc_vwind,rc_vwind@_FillValue)
v_not_sig = where(tval_uwind.lt.ttestval.and.tval_vwind.lt.ttestval,rc_vwind,rc_vwind@_FillValue)

tval_air = where(tval_air.eq.1e30,0,tval_air)

copy_VarMeta(uwind(0,:,:),rc_uwind)
copy_VarMeta(vwind(0,:,:),rc_vwind)
copy_VarMeta(air(0,:,:),rc_air)


copy_VarMeta(uwind(0,:,:),tval_uwind)
copy_VarMeta(vwind(0,:,:),tval_vwind)
copy_VarMeta(air(0,:,:),tval_air)

copy_VarMeta(uwind(0,:,:),u_sig)
copy_VarMeta(vwind(0,:,:),v_sig)

copy_VarMeta(uwind(0,:,:),u_not_sig)
copy_VarMeta(vwind(0,:,:),v_not_sig)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMaxLatF = 80
res@mpMinLonF = 260
res@mpMaxLonF = 360


res@mpCenterLonF=180

res@mpFillOn=False

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(-0.6,0.6,21);(/-0.5,-0.3,-0.1,0,0.1,0.3,0.5/)
;res@cnFillColors=(/5,7,9,0,0,12,14,16/)

res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "Hadley-"+season)
gsn_define_colormap(wks,"BlueRed")


map = gsn_csm_contour_map(wks, rc_air, res)


resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,f(:,0),f(:,1),resp)



resvc                  = True                      ; plot mods desired
resvc@gsnDraw=False
resvc@gsnFrame=False

resvc@gsnLeftString=""
resvc@gsnRightString=""

resvc@vcMinDistanceF=0.027

resvc@vcRefMagnitudeF  = 0.3
resvc@vcRefLengthF     = 0.025

resvc@vcGlyphStyle="FillArrow"
resvc@vcLineArrowThicknessF=2.

resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "0.3"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -1.0
resvc@vcRefAnnoParallelPosF     = 0.999
resvc@vcRefAnnoBackgroundColor  = "green"
resvc@vcVectorDrawOrder         = "PostDraw"
resvc@vcFillArrowWidthF=0.05
resvc@vcFillArrowHeadYF=0.07

resvc@vcMonoFillArrowFillColor =True
resvc@vcFillArrowFillColor="black"
resvc@vcFillArrowEdgeColor="black"
resvc@vcGlyphOpacityF = 0.3

;map1 = gsn_csm_vector(wks,rc_uwind_200,rc_vwind_200,resvc)

map1 = gsn_csm_vector(wks,u_not_sig,v_not_sig,resvc)

overlay(map,map1)


resvc@vcFillArrowFillColor = "black"
resvc@vcFillArrowEdgeColor = "black"
resvc@vcGlyphOpacityF = 1

map2 = gsn_csm_vector(wks,u_sig,v_sig,resvc)
overlay(map,map2)






resshade=True
resshade@pmTickMarkDisplayMode="Always"
resshade@cnFillOn=True
resshade@cnLinesOn=False
resshade@cnLineLabelsOn=False
resshade@cnMonoFillPattern=False
resshade@cnMonoFillColor=True
resshade@gsnAddCyclic=False
resshade@gsnDraw=False
resshade@gsnFrame=False
resshade@gsnLeftString=""
resshade@gsnRightString=""
resshade@lbLabelBarOn=False
resshade@cnInfoLabelOn=False

resshade2 = resshade

resshade@cnFillPatterns=(/-1,17/)
resshade@cnFillDotSizeF=0.005
resshade@cnFillColor = "red"
resshade@cnFillScaleF = 1.4
resshade@cnLevelSelectionMode="ExplicitLevels"
resshade@cnLevels=(/ttestval/)


resshade2@cnFillPatterns=(/17,-1/)
resshade2@cnFillDotSizeF=0.005
resshade2@cnFillColor = "blue"
resshade2@cnFillScaleF = 1.4
resshade2@cnLevelSelectionMode="ExplicitLevels"
resshade2@cnLevels=(/-ttestval/)



map2 = gsn_csm_contour(wks, tval_air, resshade)
overlay(map,map2)

map3 = gsn_csm_contour(wks, tval_air, resshade2)
overlay(map,map3)

lat_low = 35.0 
lat_high = 50.0
lon_left = 307.0 
lon_right = 327.0 ;330.0 
ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
resc=True
resc@gsLineColor      = "red"                     ; color of lines
resc@gsLineThicknessF = 6.0                       ; thickness of lines
dumm = new(4,graphic)
do i = 0 , 3
    dumm(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do
idx_region_lat = ind(lat_wind.ge.lat_low.and.lat_wind.le.lat_high)
idx_region_lon=ind(lon_wind.ge.lon_left.and.lon_wind.le.lon_right)
region_ave3 = dim_avg_n_Wrap(dim_avg_n_Wrap(air_season(:,idx_region_lat,idx_region_lon),2),1)
delete(idx_region_lat)
delete(idx_region_lon)


lat_low = 25.0 
lat_high = 40.0 
lon_left = 280.0
lon_right = 295.0 ;300.0 
ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
resc=True
resc@gsLineColor      = "blue"                     ; color of lines
resc@gsLineThicknessF = 6.0                       ; thickness of lines
dum = new(4,graphic)
do i = 0 , 3
    dum(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do
idx_region_lat = ind(lat_wind.ge.lat_low.and.lat_wind.le.lat_high)
idx_region_lon=ind(lon_wind.ge.lon_left.and.lon_wind.le.lon_right)
region_ave4 = dim_avg_n_Wrap(dim_avg_n_Wrap(air_season(:,idx_region_lat,idx_region_lon),2),1)
delete(idx_region_lat)
delete(idx_region_lon)




lat_low = 25.0 
lat_high = 40.0 
lon_left = 333
lon_right = 346.5 ;300.0 
ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
resc=True
resc@gsLineColor      = "blue"                     ; color of lines
resc@gsLineThicknessF = 6.0                       ; thickness of lines
dum22 = new(4,graphic)
do i = 0 , 3
    dum22(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do
idx_region_lat = ind(lat_wind.ge.lat_low.and.lat_wind.le.lat_high)
idx_region_lon=ind(lon_wind.ge.lon_left.and.lon_wind.le.lon_right)
region_ave5 = dim_avg_n_Wrap(dim_avg_n_Wrap(air_season(:,idx_region_lat,idx_region_lon),2),1)
delete(idx_region_lat)
delete(idx_region_lon)



lat_low = 57.0 
lat_high = 67.0 
lon_left = 295.5
lon_right = 335.5 ;300.0 
ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
resc=True
resc@gsLineColor      = "blue"                     ; color of lines
resc@gsLineThicknessF = 6.0                       ; thickness of lines
dum24 = new(4,graphic)
do i = 0 , 3
    dum24(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do
idx_region_lat = ind(lat_wind.ge.lat_low.and.lat_wind.le.lat_high)
idx_region_lon=ind(lon_wind.ge.lon_left.and.lon_wind.le.lon_right)
region_ave6 = dim_avg_n_Wrap(dim_avg_n_Wrap(air_season(:,idx_region_lat,idx_region_lon),2),1)
delete(idx_region_lat)
delete(idx_region_lon)















lat_low = 20.0 
lat_high = 70.0 
lon_left = 275.0
lon_right = 350.0 
ypts = (/ lat_low,  lat_low, lat_high ,  lat_high, lat_low/)
xpts = (/lon_left, lon_right, lon_right, lon_left, lon_left/)
resc=True
resc@gsLineColor      = "green"                     ; color of lines
resc@gsLineThicknessF = 6.0                       ; thickness of lines
dums = new(4,graphic)
do i = 0 , 3
    dums(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do



re = -(-region_ave3 + region_ave4 + region_ave5 + region_ave6)/4.0

asciiwrite("./sst.txt", dim_standardize_n_Wrap(re, 1, 0))


draw(map)
frame(wks)

delete(rc_air@tval)
delete(rc_air@nptxy)
delete(rc_air@yintercept)
delete(rc_air@rstd)
system("rm -rf anomaly.nc")
out = addfile("anomaly.nc","c")
out->anomaly = rc_air
