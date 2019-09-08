load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

ttestval = 1.995
season="JJA"

ff= addfile("eof-jja.nc", "r")
rc1 = ff->eof1
ts1 = ff->ts1
tval1 = ff->tval1
var1 = ff->var1

rc2 = ff->eof2
ts2 = ff->ts2
tval2 = ff->tval2
var2 = ff->var2

;rc1 = -rc1
;ts1 = -ts1
;copy_VarMeta(rc2, rc1)

;rc2 = -rc2
;ts2 = -ts2
;copy_VarMeta(rc1, rc2)

;tmp = rc1
;rc1 = where(abs(tval1).ge.ttestval, tmp, tmp@_FillValue)
;copy_VarMeta(tmp, rc1)

;tmp = rc2
;rc2 = where(abs(tval2).ge.ttestval, tmp, tmp@_FillValue)
;copy_VarMeta(tmp, rc2)

mylevels = ispan(-120, 120, 20)

latU = 50.
latL = -5
lonL = 90
lonR = 145.

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
res@gsnMaximize=True

res@mpLimitMode        = "LatLon"               ; Portion of map to zoom
res@mpMinLatF = latL   
res@mpMaxLatF = latU
res@mpMinLonF = lonL
res@mpMaxLonF = lonR

res@mpCenterLonF = 195

res@cnFillOn=True
res@cnLinesOn=True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=mylevels
res@cnFillColors = (/2,11,18,27,42,57,0,0,73,83,97,107,118,129/)

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

res@mpOutlineSpecifiers = (/"China"/)
res@mpMaskAreaSpecifiers = (/"China"/)
res@mpPerimOn   = True



wks = gsn_open_wks("png", season+"-eof-01")
gsn_define_colormap(wks,"MPL_BrBG")

map = gsn_csm_contour_map(wks, rc1, res)
map = ColorNegDashZeroPosContour(map,"black","white","black")

draw(wks)
frame(wks)
delete(wks)
delete(res@gsnRightString)

rts           = True

rts@gsnScale  = True
rts@gsnDraw   = False
rts@gsnFrame  = False
rts@vpWidthF  = 0.75
rts@vpHeightF = 0.26
rts@tiYAxisString = ""
rts@gsnMaximize=True
;rts@trYMinF   = -2.0        ; min value on y-axis
;rts@trYMaxF   =  2.0        ; max value on y-axis
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01
rts@gsnXYBarChart         = True
rts@gsnYRefLine           = 0.
rts@gsnXYBarChartBarWidth = 1.0


rts2 = rts
rts2@gsnAboveYRefLineColor = "red"
rts2@gsnBelowYRefLineColor = "blue"
rts2@gsnXYBarChartBarWidth = 0.25 

wks=gsn_open_wks("png", season+"-time-01")

p5=gsn_csm_xy(wks,ispan(1971,2018,1),ts1,rts2)

draw(wks)
frame(wks)
delete(wks)

wks = gsn_open_wks("png", season+"-eof-02")
gsn_define_colormap(wks,"MPL_BrBG")

res@gsnRightString=var2+"%"
map = gsn_csm_contour_map(wks, rc2, res)
map = ColorNegDashZeroPosContour(map,"black","white","black")

draw(wks)
frame(wks)
delete(wks)

wks=gsn_open_wks("png", season+"-time-02")

p5=gsn_csm_xy(wks,ispan(1971,2018,1),ts2,rts2)

draw(wks)
frame(wks)
delete(wks)

asciiwrite("jja-01.txt", ts1)
asciiwrite("jja-02.txt", ts2)