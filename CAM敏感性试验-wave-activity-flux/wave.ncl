load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

case="P1"

f1 = addfile("Z200-control.nc", "r")
f2 = addfile("Z200-"+case+".nc", "r")

ctl = f1->Z200
snt = f2->Z200

anom = snt-ctl
copy_VarMeta(ctl, anom)

Hgt_anom = (anom(8::12,:,:)+anom(9::12,:,:)+anom(10::12,:,:))/3.0
copy_VarMeta(anom(0:19,:,:), Hgt_anom)

Hgt_clim = (ctl(8::12,:,:)+ctl(9::12,:,:)+ctl(10::12,:,:))/3.0
copy_VarMeta(ctl(0:19,:,:), Hgt_anom)

hgt_anom = dim_avg_n_Wrap(Hgt_anom(0:19,:,:), 0)
hgt_clim = dim_avg_n_Wrap(Hgt_clim(0:19,:,:), 0)

lat = f1->lat
lon = f1->lon

nlat = dimsizes(lat)

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
Fx = mask( 200.0/1000./(2.*cumag*re*re)*( uwnd_clim/coslattmp * xuterm + vwnd_clim * xvterm), uwnd_clim.lt.5,False)
;Fx =mylev/1000./(2.*cumag*re*re)*( uwnd_clim/coslattmp * xuterm + vwnd_clim * xvterm)

;y-component 
Fy = mask(200.0/1000./(2.*cumag*re*re)*( uwnd_clim*xvterm + coslattmp*vwnd_clim*yvterm),  uwnd_clim.lt.5,False)
;Fy = mylev/1000./(2.*cumag*re*re)*( uwnd_clim*xvterm + coslattmp*vwnd_clim*yvterm)


fspd = sqrt(Fx*Fx+Fy*Fy)
Fx = mask(Fx, fspd.le.0.04, False)
Fy = mask(Fy, fspd.le.0.04, False)


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
res@mpMaxLatF = 90
res@mpMinLonF = -110
res@mpMaxLonF = 150

res@mpCenterLonF=0

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(-40,40,5)


res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "wave-"+case)
gsn_define_colormap(wks,"GMT_polar")

map = gsn_csm_contour_map(wks, hgt_anom, res)

resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)



resvc                  = True                      ; plot mods desired
resvc@gsnDraw=False
resvc@gsnFrame=False

resvc@gsnLeftString=""
resvc@gsnRightString=""

resvc@vcMinDistanceF=0.023

resvc@vcRefMagnitudeF  = 0.1
resvc@vcRefLengthF     = 0.015

resvc@vcGlyphStyle="LineArrow"
resvc@vcLineArrowThicknessF=2.0


resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "0.1"
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



