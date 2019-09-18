load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

year_start = 1979
year_end = 2018

ntime = year_end - year_start + 1

south_tpsc = asciiread("./south-TPSC.txt",(/ntime/),"float")
south_interannual = asciiread("./south-interannual.txt",(/ntime/),"float")
;south_decadal = asciiread("./south-decadal.txt",(/ntime/),"float")
cc = runave_n_Wrap(south_interannual,9,0,0)

data = new((/ntime,3/),float)
data(:,0) = south_tpsc
data(:,1) = south_interannual
data(:,2) = cc

rts           = True

rts@gsnScale  = True
rts@gsnDraw   = False
rts@gsnFrame  = False
rts@vpWidthF  = 0.75
rts@vpHeightF = 0.26
rts@tiYAxisString = ""
rts@gsnMaximize=True
rts@trYMinF   = -2.0        ; min value on y-axis
rts@trYMaxF   =  2.0        ; max value on y-axis
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01
rts@gsnXYBarChart         = True
rts@gsnYRefLine           = 0.
rts@gsnXYBarChartBarWidth = 0.7


rts2 = rts
rts2@gsnAboveYRefLineColor = "red"
rts2@gsnBelowYRefLineColor = "blue"
rts2@gsnXYBarChartBarWidth = 0.25 

rts3 = rts
rts3@xyLineThicknessF = 3.0
delete(rts3@gsnXYBarChart)
delete(rts3@gsnYRefLine)
delete(rts3@gsnXYBarChartBarWidth)

wks=gsn_open_wks("eps","time-new")

p5=gsn_csm_xy3(wks,ispan(year_start,2018,1),south_interannual,south_tpsc,cc,rts2,rts,rts3)



draw(wks)
frame(wks)
