load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

;***********************************************************
;********directionary (need to be change)********
;***********************************************************
in1=addfile("/home/wjh/case1h0/deal/deal/case1-50T.nc","r")
in2=addfile("/home/wjh/case2h0/deal/deal/case2-50T.nc","r")
in3=addfile("/home/wjh/case3h0/deal/deal/case3-50T.nc","r")
;***********************************************************
;*****read month************************************
;***********************************************************
n=11
dec1=in1->T(11::12,:,:,:)
dec2=in2->T(11::12,:,:,:)
dec3=in3->T(11::12,:,:,:)
jan1=in1->T(0::12,:,:,:)
jan2=in2->T(0::12,:,:,:)
jan3=in3->T(0::12,:,:,:)
feb1=in1->T(1::12,:,:,:)
feb2=in2->T(1::12,:,:,:)
feb3=in3->T(1::12,:,:,:)
;****calculate month average**********************
DEC1=dim_avg_n_Wrap(dec1,3)
DEC2=dim_avg_n_Wrap(dec2,3)
DEC3=dim_avg_n_Wrap(dec3,3)
JAN1=dim_avg_n_Wrap(jan1,3)
JAN2=dim_avg_n_Wrap(jan2,3)
JAN3=dim_avg_n_Wrap(jan3,3)
FEB1=dim_avg_n_Wrap(dec1,3)
FEB2=dim_avg_n_Wrap(dec2,3)
FEB3=dim_avg_n_Wrap(dec3,3)
;***********************************************************
;******calculate season average if need:Temp1=(DEC1+JAN1+FEB1)/3.0********
;***********************************************************
Temp1=FEB1
Temp2=FEB2
Temp3=FEB3
copy_VarCoords(DEC1,Temp1)
copy_VarCoords(DEC1,Temp2)
copy_VarCoords(DEC1,Temp3)

x=in1->T(0,:,:,0)
y=in1->lev_p
y@units ="hpa"
x&lev_p = y

;***********************************************************
;******cal dif average*****************************
;***********************************************************
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
;***********************************************************
;********calculate  average/varance*******************************
;***********************************************************
T1avg=dim_avg_n_Wrap(Temp1,0)
T2avg=dim_avg_n_Wrap(Temp2,0)
T3avg=dim_avg_n_Wrap(Temp3,0)
T1var=dim_variance_n_Wrap(Temp1,0)
T2var=dim_variance_n_Wrap(Temp2,0)
T3var=dim_variance_n_Wrap(Temp3,0)
;***********************************************************
;*******calculate  prob***********************************************
;***********************************************************
p21 = ttest(T1avg,T1var,50, T2avg,T2var,50, False, False)
p31 = ttest(T1avg,T1var,50, T3avg,T3var,50, False, False)
p32 = ttest(T2avg,T2var,50, T3avg,T3var,50, False, False)
copy_VarCoords(x,p21)
copy_VarCoords(x,p31)
copy_VarCoords(x,p32)
;***********************************************************
;********wks**********************
;***********************************************************

wks = gsn_open_wks("eps","height-latitude")
gsn_define_colormap(wks,"ncl_default")
;***********************************************************
;********dif res2*************************
;***********************************************************
res21=True
res31=True
res32=True
res2 = True                            ; res2 probability plots
res2@gsnDraw             = False       ; Do not draw plot
res2@gsnFrame            = False       ; Do not advance frome
res2@cnLevelSelectionMode = "ManualLevels" ; set manual contour levels
res2@cnMinLevelValF      = 0.00        ; set min contour level
res2@cnMaxLevelValF      = 1.05        ; set max contour level
res2@cnLevelSpacingF     = 0.05        ; set contour spacing
res2@cnInfoLabelOn       = False       ; turn off info label
res2@cnLinesOn           = False       ; do not draw contour lines
res2@cnLineLabelsOn      = False       ; do not draw contour labels
res2@cnFillScaleF        = 0.6         ; add extra density
;***********res21/res31/res32 setting***********************									 
										 res = True
res21@tiMainString = "T difference in Feb."
res21@gsnLeftString = ""
res21@gsnCenterString = "case2-case1"
res21@gsnRightString = "K"
res21@cnLevelSelectionMode = "ManualLevels"
res21@cnMinLevelValF=-2
res21@cnMaxLevelValF=2
res21@cnLevelSpacingF = 0.2
res21@cnFillOn = True
res21@gsnSpreadColors = True
res21@gsnDraw=False
res21@gsnFrame=False 

res31@tiMainString = "T difference in Feb."
res31@gsnLeftString = ""
res31@gsnCenterString = "case3-case1"
res31@gsnRightString = "K"
res31@cnLevelSelectionMode = "ManualLevels"
res31@cnMinLevelValF=-2
res31@cnMaxLevelValF=2
res31@cnLevelSpacingF = 0.2
res31@cnFillOn = True
res31@gsnSpreadColors = True
res31@gsnDraw=False
res31@gsnFrame=False 

res32@tiMainString = "T difference in Feb."
res32@gsnLeftString = ""
res32@gsnCenterString = "case3-case2"
res32@gsnRightString = "K"
res32@cnLevelSelectionMode = "ManualLevels"
res32@cnMinLevelValF=-2
res32@cnMaxLevelValF=2
res32@cnLevelSpacingF = 0.2
res32@cnFillOn = True
res32@gsnSpreadColors = True
res32@gsnDraw=False
res32@gsnFrame=False 
printVarSummary(T221)
res21@gsnAddCyclic=False
res31@gsnAddCyclic=False
res32@gsnAddCyclic=False
res2@gsnAddCyclic=False
res21@cnLinesOn=False
res31@cnLinesOn=False
res32@cnLinesOn=False
;***********************************************************
;**********************plot**************************************
;***********************************************************
print(1)      
plot=new(3,graphic)
plot(0) =  gsn_csm_pres_hgt(wks,T221(lev_p|0:24,lat|72:95), res21)  
print(2)
plot(0) = ZeroNegDashLineContour (plot(0))
plot(1) =  gsn_csm_pres_hgt(wks,T231(lev_p|0:24,lat|72:95), res31)  
plot(1) = ZeroNegDashLineContour (plot(1))
plot(2) =  gsn_csm_pres_hgt(wks,T232(lev_p|0:24,lat|72:95), res32)  
plot(2) = ZeroNegDashLineContour (plot(2))
print(3)
plot21=gsn_csm_pres_hgt(wks,p21(lev_p|0:24,lat|72:95),res2)
print(4)
plot21   = ShadeLtContour(plot21, 0.12, 3)  ; shade all areas less than the
                                         ; 0.05 contour level
plot31=gsn_csm_pres_hgt(wks,p31(lev_p|0:24,lat|72:95),res2)
plot31   = ShadeLtContour(plot31, 0.12, 3)  ; shade all areas less than the
                                         ; 0.05 contour level
plot32=gsn_csm_pres_hgt(wks,p32(lev_p|0:24,lat|72:95),res2)
plot32   = ShadeLtContour(plot32, 0.12, 3)  ; shade all areas less than the
                                         ; 0.05 contour level
										 										 
	


overlay (plot(0), plot21)

overlay (plot(1), plot31)

overlay (plot(2), plot32)

resP = True
resP@gsnPanelYWhiteSpacePercent = 8
resP@gsnPanelXWhiteSpacePercent = 4
resP@gsnMaximize  = False
resP@gsnPanelLabelBar=True
gsn_panel(wks,plot,(/1,3/),resP)


 







