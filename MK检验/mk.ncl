load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

ub = asciiread("./UB.txt",(/40/),"float")
uf = asciiread("./UF.txt",(/40/),"float")
;souinterannual = asciiread("../cal_interannual/south-interannual.txt",(/39/),"float")

rts           = True

rts@gsnScale  = True
rts@gsnDraw   = False
rts@gsnFrame  = False

rts@vpWidthF  = 0.75
rts@vpHeightF = 0.26

rts@tiYAxisString = ""
rts@tiXAxisString = ""

rts@trYMinF   = -4.0        ; min value on y-axis
rts@trYMaxF   =  4.0        ; max value on y-axis

rts@tmXTOn=False
rts@tmYROn=False

rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01

rts@gsnXYBarChart         = False
rts@xyLineThicknessF = 4
rts@xyLineColors = (/"blue","black"/)
rts@xyDashPatterns = (/0,0/)

rts@gsnYRefLine           = (/-1.96,0,1.96/)
rts@gsnYRefLineDashPatterns = (/16,0,16/)
rts@gsnYRefLineColors = (/"black","black","black"/)
rts@gsnYRefLineThicknesses = (/1,1,1/)

rts@gsnXRefLine = (/1994.7/)
rts@gsnXRefLineColors = (/"black"/)
rts@gsnXRefLineThicknesses = (/1/)
rts@gsnXRefLineDashPattern = 16

data = new((/2,40/),"float")
data(0,:) = ub
data(1,:) = uf
;data(2,:) = souinterannual

wks=gsn_open_wks("eps","mk")

p5=gsn_csm_xy(wks,ispan(1979,2018,1),data(:,:),rts)


res_text                    = True                  ; text mods desired
res_text@txFontHeightF      = 0.01                 ; change text size
res_text@txJust             = "CenterLeft"          ; text justification
res_lines                   = True                  ; polyline mods desired
res_lines@gsLineDashPattern = 0.                    ; solid line
res_lines@gsLineThicknessF  = 3.                    ; line thicker

res_lines@gsLineColor       = "blue"                 ; line color
xx = (/2002,2007/)
yy = (/-2.2,-2.2/)
dum3 = gsn_add_polyline(wks,p5,xx,yy,res_lines)              ; add polyline
dum4 = gsn_add_text(wks,p5,"UB",2008,-2.2,res_text); add text

yy = (/-2.7,-2.7/)
res_lines@gsLineColor       = "black"
res_lines@gsLineDashPattern = 0
dum5 = gsn_add_polyline(wks,p5,xx,yy,res_lines)              ; add polyline
dum6 = gsn_add_text(wks,p5,"UF",2008,-2.7,res_text); add text



draw(wks)
frame(wks)

