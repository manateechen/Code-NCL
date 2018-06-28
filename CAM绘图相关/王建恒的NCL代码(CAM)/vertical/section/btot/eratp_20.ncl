load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
in=addfile("/home/wjh/arctic-seaice/observationdata/ERA-Interim-T-197901-201312.nc","r")
Temp=short2flt(in->t((1988-1979)*12-1:(2013-1979)*12-2,:,:,:))
Z=Temp-273.15
copy_VarCoords(Temp,Z)
printVarSummary(Z)
x1=240
x2=479
temp12= Z(0::12,:,:,x1:x2) 
t1= Z(1::12,:,:,x1:x2) 
t2= Z(2::12,:,:,x1:x2) 
t3= Z(3::12,:,:,x1:x2) 
t4= Z(4::12,:,:,x1:x2) 
t5= Z(5::12,:,:,x1:x2) 
t6= Z(6::12,:,:,x1:x2) 
t7= Z(7::12,:,:,x1:x2) 
t8= Z(8::12,:,:,x1:x2) 
t9= Z(9::12,:,:,x1:x2) 
t10= Z(10::12,:,:,x1:x2) 
t11= Z(11::12,:,:,x1:x2) 
t12=(temp12+t1+t2)/3.0
copy_VarCoords(temp12,t12)
T12=dim_avg_n_Wrap(t12,3)
T1=dim_avg_n_Wrap(t1,3)
T2=dim_avg_n_Wrap(t2,3)
T3=dim_avg_n_Wrap(t3,3)
T4=dim_avg_n_Wrap(t4,3)
T5=dim_avg_n_Wrap(t5,3)
T6=dim_avg_n_Wrap(t6,3)
T7=dim_avg_n_Wrap(t7,3)
T8=dim_avg_n_Wrap(t8,3)
T9=dim_avg_n_Wrap(t9,3)
T10=dim_avg_n_Wrap(t10,3)
T11=dim_avg_n_Wrap(t11,3)
printVarSummary(T12)
x = fspan(1988,2012,25)

y=in->level
y@units="millibars"
T12&level = y
print(y)
DJF   = regCoef(x, T12(latitude|:,level|:,time|:) )
MAM   = regCoef(x, T1(latitude|:,level|:,time|:) )
JJA   = regCoef(x, T2(latitude|:,level|:,time|:) )
printVarSummary(T12(time|0,latitude|:,level|:))
copy_VarCoords(T12(time|0,latitude|:,level|:),DJF)
copy_VarCoords(T12(time|0,latitude|:,level|:),MAM)
copy_VarCoords(T12(time|0,latitude|:,level|:),JJA)
printVarSummary(DJF)
;x=Z(0,:,:,0)
;y=in->lev_p
;@units ="hpa"
;x&lev_p = y

t1val = onedtond(DJF@tval , dimsizes(DJF))
   df   = onedtond(JJA@nptxy, dimsizes(JJA)) - 2
 b = t1val    ; b must be same size as tval (and df)
   b = 0.5
t2val = onedtond(MAM@tval , dimsizes(MAM))
t3val = onedtond(JJA@tval , dimsizes(JJA))

 p1 = betainc(df/(df+t1val^2),df/2.0,b) 

 p2 = betainc(df/(df+t2val^2),df/2.0,b) 

 p3 = betainc(df/(df+t3val^2),df/2.0,b) 
print(1111111111111111111111111111111111111111111111)
copy_VarCoords(T12(time|0,latitude|:,level|:),p1)
print(2222222222222222222222222222222222222222222)
copy_VarCoords(T12(time|0,latitude|:,level|:),p2)
copy_VarCoords(T12(time|0,latitude|:,level|:),p3)





wks = gsn_open_wks("png","ERAtp")
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
res2@cnMaxLevelValF      = 0.202        ; set max contour level
res2@cnLevelSpacingF     = 0.002        ; set contour spacing
res2@cnInfoLabelOn       = False       ; turn off info label
res2@cnLinesOn           = False       ; do not draw contour lines
res2@cnLineLabelsOn      = False       ; do not draw contour labels
;res2@cnFillScaleF        = 0.6         ; add extra density


;*****title************************************;
r12@gsnFrame = False
r12@gsnDraw = False
r12@tiMainString = "TemperatureTrend  in DJF."
r12@gsnLeftString = ""
r12@gsnCenterString = "ERA"
r12@gsnRightString = "K/year"
r12@cnLevelSelectionMode = "ManualLevels"
r12@cnMinLevelValF=-5
r12@cnMaxLevelValF=5
r12@cnLevelSpacingF = 0.5
r12@cnFillOn = True
r12@gsnSpreadColors = True
;r12@gsnPolar    = "NH"

r12@cnLinesOn=False
r1@cnLinesOn=False
r2@cnLinesOn=False
r3@cnLinesOn=False

r12@lbLabelBarOn=False
r1@lbLabelBarOn=False
r2@lbLabelBarOn=False
r3@lbLabelBarOn=False

r1@gsnFrame = False
r1@gsnDraw = False
r1@tiMainString = "Temperature Trend   in Jan."
r1@gsnLeftString = ""
r1@gsnCenterString = "ERA"
r1@gsnRightString = "K/year"
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
r2@gsnRightString = "K/year"
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

Final=DJF*24.0
copy_VarCoords(DJF,Final)
plot = new(1,graphic)
plot(0) = gsn_csm_pres_hgt(wks,Final(level|10:36,latitude|0:120),r12) 
plot(0) = ZeroNegDashLineContour (plot(0))

plot1   = gsn_csm_pres_hgt(wks,p1(level|10:36,latitude|0:120), res2) 
plot1   = ShadeLtContour(plot1, 0.102, 17)  ; shade all areas less than the
                                         ; 0.05 contour level
	 										 
	


overlay (plot(0), plot1)

 


resP = True
resP@gsnPanelYWhiteSpacePercent = 8
resP@gsnPanelXWhiteSpacePercent = 4
resP@gsnMaximize  = False
resP@gsnPanelLabelBar=True
gsn_panel(wks,plot,(/1,1/),resP)






