load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

ttestval = 1.995
season="SON"

ff= addfile("eof-son.nc", "r")
rc1 = ff->eof1
ts1 = ff->ts1
tval1 = abs(ff->tval1)
var1 = ff->var1

copy_VarMeta(rc1, tval1)


mylevels = ispan(-40, 40, 4)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
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
res@cnLevels=mylevels
;res@cnFillColors = (/2,11,18,27,42,57,0,0,73,83,97,107,118,129/)

res@cnLineThicknessF = 3

res@lbOrientation="Vertical"

res@gsnMaximize=True
res@vpWidthF      = 0.4
res@vpHeightF     = 0.6

res@gsnLeftString=""
res@gsnRightString=var1+"%"

res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res@mpOutlineOn              = True
res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last

res@mpPerimOn   = True



wks = gsn_open_wks("eps", season+"-eof-01")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")

map = gsn_csm_contour_map(wks, rc1, res)
;map = ColorNegDashZeroPosContour(map,"black","white","black")

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
resshade@cnMonoFillScale = True 
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


map2 = gsn_csm_contour(wks, tval1, resshade)
overlay(map,map2)



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
delete(res@gsnRightString)

