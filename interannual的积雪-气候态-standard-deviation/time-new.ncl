load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

year_start = 1979
year_end = 2018

ntime = year_end - year_start + 1

;south_tpsc = asciiread("./south-TPSC.txt",(/ntime/),"float")
south_interannual = asciiread("./south-interannual.txt",(/ntime/),"float")
bb = asciiread("../snow-eof/sc.txt",(/ntime/),"float")
;south_decadal = asciiread("./south-decadal.txt",(/ntime/),"float")

data = new((/ntime,2/),float)
data(:,0) = bb
data(:,1) = south_interannual

rts           = True

rts@gsnScale  = True
rts@gsnDraw   = False
rts@gsnFrame  = False
rts@vpWidthF  = 0.75
rts@vpHeightF = 0.26
rts@tiYAxisString = ""
rts@gsnMaximize=True
rts@trYMinF   = -3.0        ; min value on y-axis
rts@trYMaxF   =  3.0        ; max value on y-axis
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01

rts2 = rts

rts@gsnXYBarChart         = False
rts@gsnYRefLine           = 0.
;rts@gsnXYBarChartBarWidth = 0.7
rts@xyLineThicknessF = 4.


;rts2 = rts
rts2@gsnXYBarChart         = True
rts2@gsnYRefLine           = 0.
rts2@gsnAboveYRefLineColor = "orange"
rts2@gsnBelowYRefLineColor = "green3"
rts2@gsnXYBarChartBarWidth = 0.55 


;rts@xyMarker         = 16
;rts@xyMarkLineMode   = "MarkLines"


wks=gsn_open_wks("eps","time-n")

p5=gsn_csm_xy2(wks,ispan(year_start,2018,1),south_interannual,bb,rts2,rts)

print(escorc(south_interannual,bb))

draw(wks)
frame(wks)
