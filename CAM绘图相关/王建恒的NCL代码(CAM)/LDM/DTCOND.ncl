load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
in1=addfile("/home/wjh/case1h0/heat/heat/case1DTCOND.nc","r")
in2=addfile("/home/wjh/case2h0/heat/heat/case2DTCOND.nc","r")
in3=addfile("/home/wjh/case3h0/heat/heat/case3DTCOND.nc","r")
;*****read month************************************
n=11
dec1=in1->DTCOND(11::12,:,:,:)
dec2=in2->DTCOND(11::12,:,:,:)
dec3=in3->DTCOND(11::12,:,:,:)
jan1=in1->DTCOND(0::12,:,:,:)
jan2=in2->DTCOND(0::12,:,:,:)
jan3=in3->DTCOND(0::12,:,:,:)
feb1=in1->DTCOND(1::12,:,:,:)
feb2=in2->DTCOND(1::12,:,:,:)
feb3=in3->DTCOND(1::12,:,:,:)
DEC1=dim_avg_n_Wrap(dec1,3)
DEC2=dim_avg_n_Wrap(dec2,3)
DEC3=dim_avg_n_Wrap(dec3,3)
JAN1=dim_avg_n_Wrap(jan1,3)
JAN2=dim_avg_n_Wrap(jan2,3)
JAN3=dim_avg_n_Wrap(jan3,3)
FEB1=dim_avg_n_Wrap(dec1,3)
FEB2=dim_avg_n_Wrap(dec2,3)
FEB3=dim_avg_n_Wrap(dec3,3)

Temp1=(DEC1+JAN1+FEB1)*3600.0*24.0/3.0
Temp2=(DEC2+JAN2+FEB2)*3600.0*24.0/3.0
Temp3=(DEC3+JAN3+FEB3)*3600.0*24.0/3.0
copy_VarCoords(DEC1,Temp1)
copy_VarCoords(DEC1,Temp2)
copy_VarCoords(DEC1,Temp3)
printVarSummary(Temp1)
x=in1->DTCOND(0,:,:,0)
y=in1->lev_p
y@units ="hpa"
x&lev_p = y
;******cal dif average*****************************

Temp21=Temp2-Temp1
Temp31=Temp3-Temp1
Temp32=Temp3-Temp2
T221=dim_avg_n_Wrap(Temp21,0)
T231=dim_avg_n_Wrap(Temp31,0)
T232=dim_avg_n_Wrap(Temp32,0)
copy_VarCoords(x,T231)
copy_VarCoords(x,T221)
copy_VarCoords(x,T232)
printVarSummary(x)
printVarSummary(T221)
;********cal month1/month2 average/varance*******************************
T1avg=dim_avg_n_Wrap(Temp1,0)
T2avg=dim_avg_n_Wrap(Temp2,0)
T3avg=dim_avg_n_Wrap(Temp3,0)
T1var=dim_variance_n_Wrap(Temp1,0)
T2var=dim_variance_n_Wrap(Temp2,0)
T3var=dim_variance_n_Wrap(Temp3,0)
;*******cal prob***********************************************
p21 = ttest(T1avg,T1var,50, T2avg,T2var,50, False, False)
p31 = ttest(T1avg,T1var,50, T3avg,T3var,50, False, False)
p32 = ttest(T2avg,T2var,50, T3avg,T3var,50, False, False)
copy_VarCoords(x,p21)
copy_VarCoords(x,p31)
copy_VarCoords(x,p32)
;********wks**********************
wks = gsn_open_wks("eps","50DTCOND")
gsn_define_colormap(wks,"ncl_default")
;********dif res*************************
res21=True
res31=True
res32=True
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
									 
										 res = True
res21@tiMainString = "DTCOND difference in DJF."
res21@gsnLeftString = ""
res21@gsnCenterString = "case2-case1"
res21@gsnRightString = "K/day"
res21@cnLevelSelectionMode = "ManualLevels"
res21@cnMinLevelValF=-0.2
res21@cnMaxLevelValF=0.2
res21@cnLevelSpacingF = 0.04
res21@cnFillOn = True
res21@gsnSpreadColors = True
res21@gsnDraw=False
res21@gsnFrame=False 

res31@tiMainString = "DTCOND difference in DJF."
res31@gsnLeftString = ""
res31@gsnCenterString = "case3-case1"
res31@gsnRightString = "K/day"
res31@cnLevelSelectionMode = "ManualLevels"
res31@cnMinLevelValF=-0.2
res31@cnMaxLevelValF=0.2
res31@cnLevelSpacingF = 0.04
res31@cnFillOn = True
res31@gsnSpreadColors = True
res31@gsnDraw=False
res31@gsnFrame=False 

res32@tiMainString = "DTCOND difference in DJF."
res32@gsnLeftString = ""
res32@gsnCenterString = "case3-case2"
res32@gsnRightString = "K/day"
res32@cnLevelSelectionMode = "ManualLevels"
res32@cnMinLevelValF=-0.1
res32@cnMaxLevelValF=0.1
res32@cnLevelSpacingF = 0.02
res32@cnFillOn = True
res32@gsnSpreadColors = True
res32@gsnDraw=False
res32@gsnFrame=False 
printVarSummary(T221)
res21@gsnAddCyclic=False
res31@gsnAddCyclic=False
res32@gsnAddCyclic=False
res2@gsnAddCyclic=False
;latitude=in1->lat
;latitude(0)=-89.9
;latitude(95)=89.9
;print(latitude(0))
;T221@lat =latitude
;T231@lat =latitude
;T232@lat =latitude
;p21@lat =latitude
;p31@lat =latitude
;p32@lat =latitude
res21@cnLinesOn=False
res31@cnLinesOn=False
res32@cnLinesOn=False
printVarSummary(T221)      
plot=new(3,graphic)
plot(0) =  gsn_csm_pres_hgt(wks,T221(lev_p|0:24,lat|72:95), res21)  
print(2)
plot(0) = ZeroNegDashLineContour (plot(0))
plot(1) =  gsn_csm_pres_hgt(wks,T231(lev_p|0:24,lat|72:95), res31)  
plot(1) = ZeroNegDashLineContour (plot(1))
plot(2) =  gsn_csm_pres_hgt(wks,T232(lev_p|0:24,lat|72:95), res32)  
plot(2) = ZeroNegDashLineContour (plot(2))
;plot21   =  gsn_csm_pres_hgt(wks,gsn_add_cyclic_point(p21), res2) 
plot21=gsn_csm_pres_hgt(wks,p21(lev_p|0:24,lat|72:95),res2)
plot21   = ShadeLtContour(plot21, 0.102, 17)  ; shade all areas less than the
                                         ; 0.05 contour level
;plot31   =  gsn_csm_pres_hgt(wks,gsn_add_cyclic_point(p31), res2) 
plot31=gsn_csm_pres_hgt(wks,p31(lev_p|0:24,lat|72:95),res2)
plot31   = ShadeLtContour(plot31, 0.102, 17)  ; shade all areas less than the
                                         ; 0.05 contour level
;plot32   =  gsn_csm_pres_hgt(wks,gsn_add_cyclic_point(p32), res2) 
plot32=gsn_csm_pres_hgt(wks,p32(lev_p|0:24,lat|72:95),res2)
plot32   = ShadeLtContour(plot32, 0.102, 17)  ; shade all areas less than the
                                         ; 0.05 contour level
										 										 
	


overlay (plot(0), plot21)

overlay (plot(1), plot31)

overlay (plot(2), plot32)
;plot = new(3,graphic)
;plot(0) = DJF21 
;plot(1) = DJF31
;plot(2) = DJF32 

resP = True
resP@gsnPanelYWhiteSpacePercent = 8
resP@gsnPanelXWhiteSpacePercent = 4
resP@gsnMaximize  = False
;resP@gsnPanelLabelBar=True
gsn_panel(wks,plot,(/1,3/),resP)


 







