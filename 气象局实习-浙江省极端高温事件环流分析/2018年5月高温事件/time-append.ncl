load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

south_tpsc = asciiread("./wpsh-append.txt",(/46,4/),"float")


idx1 = south_tpsc(:,0)
idx2 = south_tpsc(:,1)
idx3 = south_tpsc(:,2)
idx4 = south_tpsc(:,3)

idx1_run = runave_n_Wrap(idx1, 11, 0, 0)
idx2_run = runave_n_Wrap(idx2, 11, 0, 0)
idx3_run = runave_n_Wrap(idx3, 11, 0, 0)
idx4_run = runave_n_Wrap(idx4, 11, 0, 0)

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
rts@trXMinF = 1973
rts@trXMaxF = 2018
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01
rts@gsnXYBarChart         = False
;rts@gsnYRefLine           = 0.
;rts@gsnXYBarChartBarWidth = 0.7

rts2 = rts

rts@xyLineColor = "black"
rts@xyLineThicknesses = 7.

rts@xyMarkLineMode      = "MarkLines"               ; Markers *and* lines
rts@xyMarkers           = (/16/)               ; Three different markers

rts@tmXBLabelFontHeightF = 0.017
rts@tmYLLabelFontHeightF = 0.022

rts2@xyLineColor = "red"
rts2@xyLineThicknesses = 7.

rts2@xyMarkLineMode      = "MarkLines"               ; Markers *and* lines
rts2@xyMarkers           = (/16/)               ; Three different markers
rts2@xyMarkerColors = (/"red"/)

rts@trYMaxF   = 150  
rts@trYMinF   = 0
rts2@trYMaxF   = 150  
rts2@trYMinF   = 0
wks=gsn_open_wks("eps","wp-01")
p5=gsn_csm_xy2(wks, ispan(1973, 2018, 1), idx1, idx1_run, rts, rts2)
draw(wks)
frame(wks)
delete(wks)
delete(rts@trYMaxF)
delete(rts@trYMinF)
delete(rts2@trYMaxF)
delete(rts2@trYMinF)

rts@trYMaxF   = 350  
rts@trYMinF   = 0
rts2@trYMaxF   = 350  
rts2@trYMinF   = 0
wks=gsn_open_wks("eps","wp-02")
p5=gsn_csm_xy2(wks, ispan(1973, 2018, 1), idx2, idx2_run, rts, rts2)
draw(wks)
frame(wks)
delete(wks)
delete(rts@trYMaxF)
delete(rts@trYMinF)
delete(rts2@trYMaxF)
delete(rts2@trYMinF)

rts@trYMaxF   = 22  
rts@trYMinF   = 12
rts2@trYMaxF   = 22  
rts2@trYMinF   = 12
wks=gsn_open_wks("eps","wp-03")
p5=gsn_csm_xy2(wks, ispan(1973, 2018, 1), idx3, idx3_run, rts, rts2)
draw(wks)
frame(wks)
delete(wks)
delete(rts@trYMaxF)
delete(rts@trYMinF)
delete(rts2@trYMaxF)
delete(rts2@trYMinF)

rts@trYMaxF   = 180  
rts@trYMinF   = 80
rts2@trYMaxF   = 180  
rts2@trYMinF   = 80
wks=gsn_open_wks("eps","wp-04")
p5=gsn_csm_xy2(wks, ispan(1973, 2018, 1), idx4, idx4_run, rts, rts2)
draw(wks)
frame(wks)
delete(wks)
delete(rts@trYMaxF)
delete(rts@trYMinF)
delete(rts2@trYMaxF)
delete(rts2@trYMinF)
