load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

year_start = 1979
year_end = 2018

ntime = year_end - year_start + 1

f = addfile("eof-son.nc", "r")

south_interannual = f->ts1
cc = runave_n_Wrap(south_interannual,10,0,0)


data = new((/ntime,2/),float)
data(:,0) = south_interannual
data(:,1) = cc

rts           = True

rts@gsnScale  = True
rts@gsnDraw   = False
rts@gsnFrame  = False
rts@vpWidthF  = 0.75
rts@vpHeightF = 0.26
rts@tiYAxisString = ""
rts@gsnMaximize=True
rts@trYMinF   = -2.5        ; min value on y-axis
rts@trYMaxF   =  2.5        ; max value on y-axis
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01
rts3 = rts


rts@gsnXYBarChart         = True
rts@gsnYRefLine           = 0.

rts@gsnAboveYRefLineColor = "red"
rts@gsnBelowYRefLineColor = "blue"
rts@gsnXYBarChartBarWidth = 0.25 


rts3@xyLineThicknessF = 3.0

wks=gsn_open_wks("png","time")


p5=gsn_csm_xy2(wks,ispan(year_start,2018,1),south_interannual,cc,rts,rts3)


draw(wks)
frame(wks)

asciiwrite("./before.txt", south_interannual(0:15))
asciiwrite("./after.txt", south_interannual(16:))
