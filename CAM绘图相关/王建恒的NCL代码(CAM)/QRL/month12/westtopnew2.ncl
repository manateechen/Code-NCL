load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

;***********************************************************
;********directionary (need to be change)*******************
;***********************************************************
;***********************************************************
	n	= 0

	stest	= (/"90","95"/)
	sig	= (/0.101,0.051/)

        levb    = 1000
        levt    = 25

        lats    = 0
        latn    = 90

	lonw	= 0
	lone	= 180


	name	= stest(n)+"westtopnew2"

dir     = "/home/wjh/arctic-seaice2/output"

in1=addfile(dir+"/case1/QRL.nc","r")
in2=addfile(dir+"/case2/QRL.nc","r")
in3=addfile(dir+"/case3/QRL.nc","r")


;***********************************************************
;*****read month********************************************
;***********************************************************

dec1=in1->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
dec2=in2->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
dec3=in3->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
jan1=in1->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
jan2=in2->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
jan3=in3->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
feb1=in1->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
feb2=in2->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
feb3=in3->QRL(time|12::15,{lev_p|levb:levt},{lat|lats:latn},{lon|lonw:lone})
;****calculate latitudinal average**********************
DEC1=dim_avg_n_Wrap(dec1,3)
DEC2=dim_avg_n_Wrap(dec2,3)
DEC3=dim_avg_n_Wrap(dec3,3)
JAN1=dim_avg_n_Wrap(jan1,3)
JAN2=dim_avg_n_Wrap(jan2,3)
JAN3=dim_avg_n_Wrap(jan3,3)
FEB1=dim_avg_n_Wrap(feb1,3)
FEB2=dim_avg_n_Wrap(feb2,3)
FEB3=dim_avg_n_Wrap(feb3,3)
;***********************************************************
;******calculate season average if need:Temp1=(DEC1+JAN1+FEB1)/3.0********
;***********************************************************
Temp1=(DEC1+JAN1+FEB1)*24.0*3600.0/3.0
Temp2=(DEC2+JAN2+FEB2)*24.0*3600.0/3.0
Temp3=(DEC3+JAN3+FEB3)*24.0*3600.0/3.0

copy_VarCoords(DEC1,Temp1)
copy_VarCoords(DEC1,Temp2)
copy_VarCoords(DEC1,Temp3)

x=in1->QRL(time|0,{lev_p|levb:levt},{lat|lats:latn},lon|0)
y=in1->lev_p({lev_p|levb:levt})
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

wks = gsn_open_wks("eps",name)
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
res2@cnMaxLevelValF      = 0.102        ; set max contour level
res2@cnLevelSpacingF     = 0.001        ; set contour spacing
res2@cnInfoLabelOn       = False       ; turn off info label
res2@cnLinesOn           = False       ; do not draw contour lines
res2@cnLineLabelsOn      = False       ; do not draw contour labels
res2@cnFillScaleF        = 0.6         ; add extra density
;***********res21/res31/res32 setting***********************									 
										 res = True
res21@tiMainString = "QRL difference in winter"
res21@gsnLeftString = ""
res21@gsnCenterString = "case2-case1"
res21@gsnRightString = "K/day"
res21@cnLevelSelectionMode = "ManualLevels"
res21@cnMinLevelValF=-0.1
res21@cnMaxLevelValF=0.1
res21@cnLevelSpacingF = 0.01
res21@cnFillOn = True
res21@gsnSpreadColors = True
res21@gsnDraw=False
res21@gsnFrame=False 

res31@tiMainString = "QRL difference in winter"
res31@gsnLeftString = ""
res31@gsnCenterString = "case3-case1"
res31@gsnRightString = "K/day"
res31@cnLevelSelectionMode = "ManualLevels"
res31@cnMinLevelValF=-0.1
res31@cnMaxLevelValF=0.1
res31@cnLevelSpacingF = 0.01
res31@cnFillOn = True
res31@gsnSpreadColors = True
res31@gsnDraw=False
res31@gsnFrame=False 

res32@tiMainString = "QRL difference in winter"
res32@gsnLeftString = ""
res32@gsnCenterString = "case3-case2"
res32@gsnRightString = "K/day"
res32@cnLevelSelectionMode = "ManualLevels"
res32@cnMinLevelValF=-0.1
res32@cnMaxLevelValF=0.1
res32@cnLevelSpacingF = 0.01
res32@cnFillOn = True
res32@gsnSpreadColors = True
res32@gsnDraw=False
res32@gsnFrame=False 
printVarSummary(T221)



res21@cnLinesOn= False
res31@cnLinesOn= False
res32@cnLinesOn= False;***********************************************************
;**********************plot**************************************
;***********************************************************
print(1)      
plot=new(3,graphic)
plot(1) =  gsn_csm_pres_hgt(wks,T221({lev_p|levb:levt},{lat|lats:latn}), res21)  
printVarSummary(T221)
plot(1) = ZeroNegDashLineContour (plot(1))

plot(0) =  gsn_csm_pres_hgt(wks,T231({lev_p|levb:levt},{lat|lats:latn}), res31)  
plot(0) = ZeroNegDashLineContour (plot(0))

plot(2) =  gsn_csm_pres_hgt(wks,T232({lev_p|levb:levt},{lat|lats:latn}), res32)  
plot(2) = ZeroNegDashLineContour (plot(2))
;print(3)

;=============================================================================

plot21=gsn_csm_pres_hgt(wks,p21({lev_p|levb:levt},{lat|lats:latn}),res2)
print(4)
plot21   = ShadeLtContour(plot21, sig(n), 17)  ; shade all areas less than the
                                         ; 0.05 contour level
plot31=gsn_csm_pres_hgt(wks,p31({lev_p|levb:levt},{lat|lats:latn}),res2)
plot31   = ShadeLtContour(plot31, sig(n), 17)  ; shade all areas less than the
                                         ; 0.05 contour level
plot32=gsn_csm_pres_hgt(wks,p32({lev_p|levb:levt},{lat|lats:latn}),res2)
plot32   = ShadeLtContour(plot32, sig(n), 17)  ; shade all areas less than the
                                         ; 0.05 contour level
;============================================================================

overlay (plot(1), plot21)

overlay (plot(0), plot31)

overlay (plot(2), plot32)

resP = True
;resP@gsnPanelYWhiteSpacePercent = 4
;resP@gsnPanelXWhiteSpacePercent = 4
resP@gsnMaximize  = False
;resP@gsnPanelLabelBar=True
gsn_panel(wks,plot,(/1,3/),resP)

;draw(wks)
;frame(wks)