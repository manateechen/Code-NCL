load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

filepath="data.txt"
nlines=5
ncols=80
dat=asciiread(filepath,(/nlines,ncols/),"float")

lat=dat(0,:)
lon=dat(1,:)
means=dat(2,:)
mins=dat(3,:)
maxs=dat(4,:)           

wrfout_d03=addfile("./wrfout_d03_2013-07-06_00:00:00","r")
xlat_d03=wrf_user_getvar(wrfout_d03,"XLAT",0)
xlon_d03=wrf_user_getvar(wrfout_d03,"XLONG",0)

wrfout_d04=addfile("./wrfout_d04_2013-07-06_00:00:00","r")
xlat_d04=wrf_user_getvar(wrfout_d04,"XLAT",0)
xlon_d04=wrf_user_getvar(wrfout_d04,"XLONG",0)

rscan = (/1,0.7,0.5,0.3,0.1/)

;xlat=ndtooned(xlat_d03)
;xlon=ndtooned(xlon_d03)
means_out_d03=obj_anal_ic_deprecated(lon,lat,means,xlon_d03,xlat_d03,rscan,False)
;means_out_d03=obj_anal_ic_deprecated(lon,lat,means,xlat,xlon,rscan,True)
;means_out_d03=obj_anal_ic_Wrap(lon,lat,means,xlat,xlon,rscan,True)
;print(means_out_d03)
means_out_d03@lat2d=xlat_d03
means_out_d03@lon2d=xlon_d03

means_out_d04=obj_anal_ic_deprecated(lon,lat,means,xlon_d04,xlat_d04,rscan,False)
means_out_d04@lat2d=xlat_d04
means_out_d04@lon2d=xlon_d04

mins_out_d03=obj_anal_ic_deprecated(lon,lat,mins,xlon_d03,xlat_d03,rscan,False)
mins_out_d03@lat2d=xlat_d03
mins_out_d03@lon2d=xlon_d03

mins_out_d04=obj_anal_ic_deprecated(lon,lat,mins,xlon_d04,xlat_d04,rscan,False)
mins_out_d04@lat2d=xlat_d04
mins_out_d04@lon2d=xlon_d04

maxs_out_d03=obj_anal_ic_deprecated(lon,lat,maxs,xlon_d03,xlat_d03,rscan,False)
maxs_out_d03@lat2d=xlat_d03
maxs_out_d03@lon2d=xlon_d03

maxs_out_d04=obj_anal_ic_deprecated(lon,lat,maxs,xlon_d04,xlat_d04,rscan,False)
maxs_out_d04@lat2d=xlat_d04
maxs_out_d04@lon2d=xlon_d04

dom_dims = dimsizes(xlat_d03)
dom_rank = dimsizes(dom_dims)
nx1 = dom_dims(dom_rank - 1) - 1
ny1 = dom_dims(dom_rank - 2) - 1
dom_dims = dimsizes(xlat_d04)
dom_rank = dimsizes(dom_dims)
nx2 = dom_dims(dom_rank - 1) - 1
ny2 = dom_dims(dom_rank - 2) - 1

res                 = True
res@cnFillOn        = True
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@gsnSpreadColors = True
;res@cnLevelSelectionMode = "ExplicitLevels"
;res@cnLevels=(/0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1250,1500,1750,2000,2250,2500,2750,3000,3250,3500,3750,4000,4250,4500,4750,5000,5250,5500,5750,6000/)
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnDraw         = False
res@gsnFrame        = False
res2 = res
res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res@mpOutlineOn              = True
res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last
res@mpGridAndLimbOn       = True                ; Turn off lat/lon lines
res@mpGridLineDashPattern       = 2
res@pmTickMarkDisplayMode = "Always"             ; Turn on map tickmarks
res = set_mp_wrf_map_resources(wrfout_d03,res)
res@mpLimitMode        = "Corners"               ; Portion of map to zoom
res@mpLeftCornerLatF   = xlat_d03(0,0)
res@mpLeftCornerLonF   = xlon_d03(0,0)
res@mpRightCornerLatF  = xlat_d03(ny1,nx1)
res@mpRightCornerLonF  = xlon_d03(ny1,nx1)
res2@lbLabelBarOn = False  ; Labelbar already created in 1st plot
res2@gsnMaximize  = False  ; Use maximization from original plot

wks = gsn_open_wks("eps", "mean")
map = gsn_csm_contour_map(wks, means_out_d03, res)
plot = gsn_csm_contour(wks, means_out_d04, res2)
overlay(map,plot)
draw(map)
gsn_polyline(wks,map,xlon_d04(0,:),xlat_d04(0,:),True)
gsn_polyline(wks,map,xlon_d04(:,0),xlat_d04(:,0),True)
gsn_polyline(wks,map,xlon_d04(ny2,:),xlat_d04(ny2,:),True)
gsn_polyline(wks,map,xlon_d04(:,nx2),xlat_d04(:,nx2),True)
delete(wks)

wks = gsn_open_wks("eps", "min")
map = gsn_csm_contour_map(wks, mins_out_d03, res)
plot = gsn_csm_contour(wks, mins_out_d04, res2)
overlay(map,plot)
draw(map)
gsn_polyline(wks,map,xlon_d04(0,:),xlat_d04(0,:),True)
gsn_polyline(wks,map,xlon_d04(:,0),xlat_d04(:,0),True)
gsn_polyline(wks,map,xlon_d04(ny2,:),xlat_d04(ny2,:),True)
gsn_polyline(wks,map,xlon_d04(:,nx2),xlat_d04(:,nx2),True)
delete(wks)

wks = gsn_open_wks("eps", "max")
map = gsn_csm_contour_map(wks, maxs_out_d03, res)
plot = gsn_csm_contour(wks, maxs_out_d04, res2)
overlay(map,plot)
draw(map)
gsn_polyline(wks,map,xlon_d04(0,:),xlat_d04(0,:),True)
gsn_polyline(wks,map,xlon_d04(:,0),xlat_d04(:,0),True)
gsn_polyline(wks,map,xlon_d04(ny2,:),xlat_d04(ny2,:),True)
gsn_polyline(wks,map,xlon_d04(:,nx2),xlat_d04(:,nx2),True)
delete(wks)