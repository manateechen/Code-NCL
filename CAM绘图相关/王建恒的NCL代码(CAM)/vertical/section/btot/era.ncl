load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

n	= 1
ss	= (/90,95/)

name	= ss(n)+"eurasia"	;"all"	;"northamerica"		;"eurasia"

sig	= (/0.101,0.052/)
latn	= 90
lats	= 0
lonw	= 0
lone	= 180

levb	= 1000
levt	= 20

in=addfile("/home/wjh/arctic-seaice/observationdata/ERA-Interim-T-197901-201312.nc","r")
Temp=short2flt(in->t((1988-1979)*12:(2013-1979)*12-1,:,:,:))

t	= month_to_season(Temp(time|:,level|:,{latitude|lats:latn},{longitude|lonw:lone}),"DJF")
tdjf	= dim_avg_n_Wrap(t,3)

printVarSummary(tdjf)

x = ispan(1988,2012,1)*1.0

y=in->level
;y@units="millibars"
;T12&level = y
;print(y)

DJF   = regCoef(x, tdjf(latitude|:,level|:,time|:) )
;MAM   = regCoef(x, T1(latitude|:,level|:,time|:) )
;JJA   = regCoef(x, T2(latitude|:,level|:,time|:) )

copy_VarCoords(tdjf(time|0,latitude|:,level|:),DJF)

;copy_VarCoords(tdjf(time|0,latitude|:,level|:),MAM)
;copy_VarCoords(tdjf(time|0,latitude|:,level|:),JJA)
printVarSummary(DJF)
;x=Z(0,:,:,0)
;y=in->lev_p
;@units ="hpa"
;x&lev_p = y

	t1val = onedtond(DJF@tval, dimsizes(DJF))
	df   = onedtond(DJF@nptxy, dimsizes(DJF)) - 2

	b = t1val    ; b must be same size as tval (and df)
	b = 0.5

;t2val = onedtond(MAM@tval , dimsizes(MAM))
;t3val = onedtond(JJA@tval , dimsizes(JJA))

 p1 = betainc(df/(df+t1val^2),df/2.0,b) 

; p2 = betainc(df/(df+t2val^2),df/2.0,b) 

; p3 = betainc(df/(df+t3val^2),df/2.0,b) 
;print(1111111111111111111111111111111111111111111111)
copy_VarCoords(tdjf(time|0,latitude|:,level|:),p1)
;print(2222222222222222222222222222222222222222222)
;copy_VarCoords(T12(time|0,latitude|:,level|:),p2)
;copy_VarCoords(T12(time|0,latitude|:,level|:),p3)

wks = gsn_open_wks("png",name)
gsn_define_colormap(wks,"ncl_default")
;gsn_define_colormap(wks,"BlueWhiteOrangeRed")
res = True
r12 = True
r1 = True
r2 = True
r3 = True
res2 = True                            ; res2 probability plots
res2@gsnDraw             = False       ; Do not draw plot
res2@gsnFrame            = False       ; Do not advance frome
res2@cnLevelSelectionMode = "ManualLevels" ; set manual contour levels
res2@cnMinLevelValF      = 0.00        ; set min contour level
res2@cnMaxLevelValF      = 0.102        ; set max contour level
res2@cnLevelSpacingF     = 0.001        ; set contour spacing
res2@cnInfoLabelOn       = False       ; turn off info label
res2@cnLinesOn           = False       ; do not draw contour lines
res2@cnLineLabelsOn      = False       ; do not draw contour labels
;res2@cnFillScaleF        = 0.6         ; add extra density

;*****title************************************;
r12@gsnFrame = False
r12@gsnDraw = False
r12@tiMainString = "TemperatureTrend"
r12@gsnLeftString = "DJF"
r12@gsnCenterString = "ERA"
r12@gsnRightString = "K"
r12@cnLevelSelectionMode = "ManualLevels"
r12@cnMinLevelValF=-5
r12@cnMaxLevelValF=5
r12@cnLevelSpacingF = 0.5
r12@cnFillOn = True
r12@cnLinesOn= True
r12@gsnSpreadColors = True
;r12@gsnPolar    = "NH"

r12@cnLinesOn= True
r1@cnLinesOn=False
r2@cnLinesOn=False
r3@cnLinesOn=False

r12@lbLabelBarOn= True
r1@lbLabelBarOn=False
r2@lbLabelBarOn=False
r3@lbLabelBarOn=False

r1@gsnFrame = False
r1@gsnDraw = False
r1@tiMainString = "Temperature Trend."
r1@gsnLeftString = "DJF"
r1@gsnCenterString = "ERA"
r1@gsnRightString = "K/10yrs"
r1@cnLevelSelectionMode = "ManualLevels"
r1@cnMinLevelValF=-0.5
r1@cnMaxLevelValF=0.5
r1@cnLevelSpacingF = 0.1
r1@cnFillOn = True
r1@gsnSpreadColors = True
r1@gsnPolar    = "NH"

r2@gsnFrame = False
r2@gsnDraw = False
r2@tiMainString = "Temperature Trend   in Feb."
r2@gsnLeftString = ""
r2@gsnCenterString = "ERA"
r2@gsnRightString = "K"
r2@cnLevelSelectionMode = "ManualLevels"
r2@cnMinLevelValF=-0.5
r2@cnMaxLevelValF=0.5
r2@cnLevelSpacingF = 0.1
r2@cnFillOn = True
r2@gsnSpreadColors = True
r2@gsnPolar    = "NH"


r3@gsnFrame = False
r3@gsnDraw = False
r3@tiMainString = "Temperature Trend  in SON."
r3@gsnLeftString = ""
r3@gsnCenterString = "ERA"
r3@gsnRightString = "K/year"
r3@cnLevelSelectionMode = "ManualLevels"
r3@cnMinLevelValF=-0.5
r3@cnMaxLevelValF=0.5
r3@cnLevelSpacingF = 0.1
r3@cnFillOn = True
r3@gsnSpreadColors = True
r3@gsnPolar    = "NH"

r12@gsnMaximize  = False
r1@gsnMaximize  = False
r2@gsnMaximize  = False
r3@gsnMaximize  = False

Final=DJF*21.0
copy_VarCoords(DJF,Final)
plot = new(1,graphic)
plot(0) = gsn_csm_pres_hgt(wks,Final({level|levb:levt},{latitude|lats:latn}),r12) 
plot(0) = ZeroNegDashLineContour (plot(0))

plot1   = gsn_csm_pres_hgt(wks,p1({level|levb:levt},{latitude|lats:latn}), res2) 
plot1   = ShadeLtContour(plot1, sig(n),14)  ; shade all areas less than the
                                         ; 0.05 contour level					 
	
overlay (plot(0), plot1)

resP = True
resP@gsnPanelYWhiteSpacePercent = 8
resP@gsnPanelXWhiteSpacePercent = 4
resP@gsnMaximize  = False
resP@gsnPanelLabelBar=True
;gsn_panel(wks,plot,(/1,1/),resP)

draw(plot(0))
frame(wks)




