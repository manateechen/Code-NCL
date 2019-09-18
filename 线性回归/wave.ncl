load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

; SON
season = "SON"

ttestval = 2.120

infile = addfile(season+".nc", "r")
hgt_clim = infile->hgt_clim
hgt_anom = infile->hgt_anom

mylev = infile->mylev

lat = infile->lat
lon = infile->lon

nlat = dimsizes(lat)

tval_hgt = reshape(hgt_anom@tval,(/dimsizes(hgt_anom(:,0)),dimsizes(hgt_anom(0,:))/))
copy_VarMeta(hgt_anom, tval_hgt)
;  Gas constant
gc=290
;  Gravitational acceleration
ga=9.80665

;  Radius of the earth
re=6378388

; pi
pi = atan(1.0)*4.

; Coriolis parameter
f =  2.*2.*pi/(60.*60.*24.)*sin(pi/180. * lat(:))
f!0 = "lat"
f&lat = lat
f@_FillValue = hgt_anom@_FillValue

; missing for 10S - 10N
do ilat = 0, nlat-1
if (abs(lat(ilat) ).lt. 10. ) then
f(ilat)= f@_FillValue
end if
end do

; cosine
coslat = cos(lat(:)*pi/180.)

coslattmp = conform_dims(dimsizes(hgt_anom),coslat,0)
ftmp = conform_dims(dimsizes(hgt_anom),f,0)

bb=z2geouv(hgt_clim, lat, lon, 1)
uwnd_clim = bb(0,:,:)
vwnd_clim = bb(1,:,:)

; magnitude of climatological wind
cumag = sqrt(uwnd_clim^2 + vwnd_clim^2)
cumag@_FillValue = uwnd_clim@_FillValue
cumag = where(cumag .gt. 0, cumag, cumag@_FillValue)

; QG steam function for anomaly
psidev = hgt_anom*ga /ftmp

;dpsidev/dlon
dpsidevdlon =  center_finite_diff_n(psidev,lon*pi/180.,True,0,1)

;ddpsidev/dlonlon
ddpsidevdlonlon =  center_finite_diff_n(dpsidevdlon,lon*pi/180.,True,0,1)

;dpsidev/dlat
dpsidevdlat = center_finite_diff_n(psidev, lat*pi/180., False,0,0)

;ddpsidev/dlonlat
ddpsidevdlonlat =  center_finite_diff_n(dpsidevdlon,lat*pi/180.,False,0,0)

;ddpsidev/dlatdlat
ddpsidevdlatlat = center_finite_diff_n(dpsidevdlat, lat*pi/180.,False,0,0)

xuterm = (dpsidevdlon*dpsidevdlon - psidev*ddpsidevdlonlon)
xvterm = (dpsidevdlon*dpsidevdlat - psidev*ddpsidevdlonlat)
;yuterm = xvterm
yvterm = (dpsidevdlat*dpsidevdlat - psidev*ddpsidevdlatlat)

; Mask out where westerlies is small or negative (less than 5 m/s).
;  by using mask


;x-component of (38)
Fx = mask( mylev/1000./(2.*cumag*re*re)*( uwnd_clim/coslattmp * xuterm + vwnd_clim * xvterm), uwnd_clim.lt.5,False)
;Fx =mylev/1000./(2.*cumag*re*re)*( uwnd_clim/coslattmp * xuterm + vwnd_clim * xvterm)

;y-component 
Fy = mask(mylev/1000./(2.*cumag*re*re)*( uwnd_clim*xvterm + coslattmp*vwnd_clim*yvterm),  uwnd_clim.lt.5,False)
;Fy = mylev/1000./(2.*cumag*re*re)*( uwnd_clim*xvterm + coslattmp*vwnd_clim*yvterm)


fspd = sqrt(Fx*Fx+Fy*Fy)
Fx = mask(Fx, fspd.le.0.035, False)
Fy = mask(Fy, fspd.le.0.035, False)


; for output
Fx!0 = "lat"
Fx&lat = lat
Fx!1 = "lon"
Fx&lon = lon

Fy!0 = "lat"
Fy&lat = lat
Fy!1 = "lon"
Fy&lon = lon

psidev!0 = "lat"
psidev&lat = lat
psidev!1 = "lon"
psidev&lon = lon

Fx@units = "m^2/s^2"
Fx@units = "m^2/s^2"

copy_VarMeta(hgt_anom, Fx)
copy_VarMeta(hgt_anom, Fy)

;out = addfile("wave-activity.nc","c")
;out->lat = lat
;out->lon = lon
;out->Fx = Fx
;out->Fy = Fy
;out->psidev = psidev

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = 10
res@mpMinLonF = -110
res@mpMaxLonF = 150

;res@mpCenterLonF=0

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/-35,-25,-15,-5,0,5,15,25,35/)
;res@cnFillColors=(/3,4,5,7,0,0,12,14,15,16/)


res@lbOrientation="vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "wave-"+season)
gsn_define_colormap(wks,"BlueRed")

map = gsn_csm_contour_map(wks, hgt_anom, res)

resp = True
resp@gsLineColor      = "black" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)



resvc                  = True                      ; plot mods desired
resvc@gsnDraw=False
resvc@gsnFrame=False

resvc@gsnLeftString=""
resvc@gsnRightString=""

resvc@vcMinDistanceF=0.02

resvc@vcRefMagnitudeF  = 0.15
resvc@vcRefLengthF     = 0.02

resvc@vcGlyphStyle="LineArrow"
resvc@vcLineArrowThicknessF=2.6


resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "0.15"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -0.21
resvc@vcRefAnnoParallelPosF     = 0.999
resvc@vcRefAnnoBackgroundColor  = "green"
resvc@vcVectorDrawOrder         = "PostDraw"
resvc@vcFillArrowWidthF=0.05
resvc@vcFillArrowHeadYF=0.07

resvc@vcMonoFillArrowFillColor =True
resvc@vcFillArrowFillColor = "black"
resvc@vcFillArrowEdgeColor = "white"

map1 = gsn_csm_vector(wks,Fx,Fy,resvc)

overlay(map,map1)


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



map2 = gsn_csm_contour(wks, tval_hgt, resshade)
overlay(map,map2)

map3 = gsn_csm_contour(wks, tval_hgt, resshade2)
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



