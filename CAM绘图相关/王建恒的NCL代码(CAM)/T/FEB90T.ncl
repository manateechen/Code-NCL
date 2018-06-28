load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

;***********************************************************
;********directionary (need to be change)********
;***********************************************************
	dir	= "/home/wjh/arctic-seaice2/output"	

in1=addfile(dir+"/case1/T2m.nc","r")
in2=addfile(dir+"/case2/T2m.nc","r")
in3=addfile(dir+"/case3/T2m.nc","r")
;***********************************************************
;*****read month************************************
;***********************************************************
n=11
dec1=in1->T2m(0::15,:,:)
dec2=in2->T2m(0::15,:,:)
dec3=in3->T2m(0::15,:,:)
jan1=in1->T2m(1::15,:,:)
jan2=in2->T2m(1::15,:,:)
jan3=in3->T2m(1::15,:,:)
feb1=in1->T2m(2::15,:,:)
feb2=in2->T2m(2::15,:,:)
feb3=in3->T2m(2::15,:,:)

;***********************************************************
;******calculate season average if need:Temp1=(DEC1+JAN1+FEB1)/3.0********
;***********************************************************

Temp1=	(feb1)/1.0
Temp2=	(feb2)/1.0
Temp3=	(feb3)/1.0

copy_VarCoords(dec1,Temp1)
copy_VarCoords(dec1,Temp2)
copy_VarCoords(dec1,Temp3)

x=in1->T2m(0,:,:)
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
;***********************************************************
;********calculate  average/varance*******************************
;***********************************************************
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
wks = gsn_open_wks("eps","FEB90T2m")
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
res2@cnFillScaleF        = 0.6         ; add extra density
;***********res21/res31/res32 setting***********************									 
res = True
res21@tiMainString = "T2m difference in winter"
res21@gsnLeftString = ""
res21@gsnCenterString = "case2-case1"
res21@gsnRightString = "K"
res21@cnLevelSelectionMode = "ManualLevels"
res21@cnMinLevelValF=-5
res21@cnMaxLevelValF=5
res21@cnLevelSpacingF = 1
res21@cnFillOn = True
res21@gsnSpreadColors = True
res21@gsnPolar    = "NH"
res21@gsnDraw=False
res21@gsnFrame=False 
res21@mpMinLatF =30

res31@tiMainString = "T2m difference in winter"
res31@gsnLeftString = ""
res31@gsnCenterString = "case3-case1"
res31@gsnRightString = "K"
res31@cnLevelSelectionMode = "ManualLevels"
res31@cnMinLevelValF=-5
res31@cnMaxLevelValF=5
res31@cnLevelSpacingF = 1
res31@cnFillOn = True
res31@gsnSpreadColors = True
res31@gsnPolar    = "NH"
res31@gsnDraw=False
res31@gsnFrame=False 
res21@cnLinesOn=False
res31@cnLinesOn=False
res31@mpMinLatF = 30


res32@cnLinesOn=False
res32@tiMainString = "T2m difference in winter"
res32@gsnLeftString = ""
res32@gsnCenterString = "case3-case2"
res32@gsnRightString = "K"
res32@cnLevelSelectionMode = "ManualLevels"
res32@cnMinLevelValF=-1.2
res32@cnMaxLevelValF=1.2
res32@cnLevelSpacingF = 0.2
res32@cnFillOn = True
res32@gsnSpreadColors = True
res32@gsnPolar    = "NH"
res32@gsnDraw=False
res32@gsnFrame=False 
res32@mpMinLatF = 30

;***********************************************************
;**********************plot**************************************
;***********************************************************
plot=new(3,graphic)
plot(0) = gsn_csm_contour_map_polar(wks,T221, res21)  
plot(0) = ZeroNegDashLineContour (plot(0))
plot(1) = gsn_csm_contour_map_polar(wks,T231, res31)  
plot(1) = ZeroNegDashLineContour (plot(1))
plot(2) = gsn_csm_contour_map_polar(wks,T232, res32)  
plot(2) = ZeroNegDashLineContour (plot(2))


plot21   = gsn_csm_contour(wks,gsn_add_cyclic_point(p21), res2) 
plot21   = ShadeLtContour(plot21, 0.102, 17)  ; shade all areas less than the
                                         ; 0.1 contour level
plot31   = gsn_csm_contour(wks,gsn_add_cyclic_point(p31), res2) 
plot31   = ShadeLtContour(plot31, 0.102, 17)  ; shade all areas less than the
                                         ; 0.1 contour level
plot32   = gsn_csm_contour(wks,gsn_add_cyclic_point(p32), res2) 
plot32   = ShadeLtContour(plot32, 0.102, 17)  ; shade all areas less than the
                                         ; 0.1 contour level
										 										 
	


overlay (plot(0), plot21)

overlay (plot(1), plot31)

overlay (plot(2), plot32)


 resP = True
resP@gsnPanelYWhiteSpacePercent = 8
resP@gsnPanelXWhiteSpacePercent = 4
resP@gsnMaximize  = False
resP@gsnPanelLabelBar=True
gsn_panel(wks,plot,(/1,3/),resP)






