load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

south_tpsc = asciiread("./2017-wp.txt",(/62,7/),"float")

idx1 = south_tpsc(:,3)
idx2 = south_tpsc(:,4)
idx3 = south_tpsc(:,5)
idx4 = south_tpsc(:,6)

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
rts@trXMaxF = 61
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01
rts@gsnXYBarChart         = False
;rts@gsnYRefLine           = 0.
;rts@gsnXYBarChartBarWidth = 0.7
rts@xyLineColor = "black"
rts@xyLineThicknesses = 7.

rts@tmXBMode      = "Explicit" 
;rts@tmXBValues    = (/  0. ,  4.,  9.,   14., 19., 24., 29 /)
rts@tmXBValues    = ispan(0,60,10)
rts@tmXBLabels    = (/"07-01","07-11","07-21" ,"07-31","08-09", "08-19", "08-29" /)
rts@tmXBLabelFontHeightF = 0.017

rts@tmYLLabelFontHeightF = 0.017

wks=gsn_open_wks("png","wp-01")
p5=gsn_csm_xy(wks, ispan(0, 61, 1), idx1, rts)
draw(wks)
frame(wks)
delete(wks)

wks=gsn_open_wks("png","wp-02")
p5=gsn_csm_xy(wks, ispan(0, 61, 1), idx2, rts)
draw(wks)
frame(wks)
delete(wks)

wks=gsn_open_wks("png","wp-03")
p5=gsn_csm_xy(wks, ispan(0, 61, 1), idx3, rts)
draw(wks)
frame(wks)
delete(wks)

wks=gsn_open_wks("png","wp-04")
p5=gsn_csm_xy(wks, ispan(0, 61, 1), idx4, rts)
draw(wks)
frame(wks)
delete(wks)
