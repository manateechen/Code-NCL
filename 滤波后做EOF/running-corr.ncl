load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/run_cor.ncl"

mam01 = asciiread("mam-01.txt", 48, "float")
mam02 = asciiread("mam-02.txt", 48, "float")
jja01 = asciiread("jja-01.txt", 48, "float")
jja02 = asciiread("jja-02.txt", 48, "float")

year = ispan(1971, 2018, 1)
year@units="year"

COR1 = run_cor(mam02,jja01,year,21)
COR2 = run_cor(mam02,jja02,year,21)

COR3 = run_cor(mam01,jja01,year,21)
COR4 = run_cor(mam01,jja02,year,21)

rts           = True

rts@gsnScale  = True
rts@gsnDraw   = False
rts@gsnFrame  = False
rts@vpWidthF  = 0.75
rts@vpHeightF = 0.26
rts@tiYAxisString = ""
rts@gsnMaximize=True
rts@trXMinF   = 1971        ; min value on y-axis
rts@trXMaxF   =  2018        ; max value on y-axis
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01
rts@gsnXYBarChart         = False
rts@gsnYRefLine           = (/-0.44,-0.37,0.37,0.44/)
rts@gsnYRefLineThicknessF = 2.0
rts@gsnYRefLineDashPattern = 16
rts@gsnYRefLineColor = "red"
rts@xyLineThicknesses=(/3.0/)
rts@xyMarkLineMode = "MarkLines"
;rts@xyMarker=16
rts@xyLineColor="blue"
rts@xyMarkerColor="blue"
rts@xyMarkerSizeF=0.005
;rts@gsnXYBarChartBarWidth = 1.0


;rts2 = rts
;rts2@gsnAboveYRefLineColor = "red"
;rts2@gsnBelowYRefLineColor = "blue"
;rts2@gsnXYBarChartBarWidth = 0.25 

wks=gsn_open_wks("png", "MAM2-JJA1")
p5=gsn_csm_xy(wks,ispan(1981, 2008, 1),COR1,rts)
draw(wks)
frame(wks)
delete(wks)
delete(p5)

wks=gsn_open_wks("png", "MAM2-JJA2")
p5=gsn_csm_xy(wks,ispan(1981, 2008, 1),COR2,rts)
draw(wks)
frame(wks)
delete(wks)
delete(p5)

wks=gsn_open_wks("png", "MAM1-JJA1")
p5=gsn_csm_xy(wks,ispan(1981, 2008, 1),COR3,rts)
draw(wks)
frame(wks)
delete(wks)
delete(p5)

wks=gsn_open_wks("png", "MAM1-JJA2")
p5=gsn_csm_xy(wks,ispan(1981, 2008, 1),COR4,rts)
draw(wks)
frame(wks)
delete(wks)
delete(p5)