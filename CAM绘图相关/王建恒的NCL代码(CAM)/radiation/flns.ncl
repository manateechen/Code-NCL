load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"


;***********************************************************
        n       = 1

        stest   = (/"90","95"/)
        sig	= (/0.101,0.051/)

        levb    = 1000
        levt    = 25

        lats    = 0
        latn    = 90

        lonw    = 0
        lone    = 360


        name    = stest(n)+"FLNS"

;***********************************************************
;********directionary (need to be change)********
;***********************************************************
	dir	= "/home/wjh/arctic-seaice/output"	

in1=addfile(dir+"/case1/FLNS.nc","r")
in2=addfile(dir+"/case2/FLNS.nc","r")
in3=addfile(dir+"/case3/FLNS.nc","r")
;***********************************************************
;*****read month************************************
;***********************************************************
;n=11
dec1=in1->FLNS(11::12,:,:)
dec2=in2->FLNS(11::12,:,:)
dec3=in3->FLNS(11::12,:,:)
jan1=in1->FLNS(0::12,:,:)
jan2=in2->FLNS(0::12,:,:)
jan3=in3->FLNS(0::12,:,:)
feb1=in1->FLNS(1::12,:,:)
feb2=in2->FLNS(1::12,:,:)
feb3=in3->FLNS(1::12,:,:)

;***********************************************************
;******calculate season average if need:Temp1=(DEC1+JAN1+FEB1)/3.0********
;***********************************************************

Temp1=	(dec1+jan1+feb1)/3.0
Temp2=	(dec2+jan2+feb2)/3.0
Temp3=	(dec3+jan3+feb3)/3.0

copy_VarCoords(dec1,Temp1)
copy_VarCoords(dec1,Temp2)
copy_VarCoords(dec1,Temp3)

x=in1->FLNS(0,:,:)
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
wks = gsn_open_wks("eps",name)
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
res2@cnMaxLevelValF      = .102        ; set max contour level
res2@cnLevelSpacingF     = 0.01        ; set contour spacing
res2@cnInfoLabelOn       = False       ; turn off info label
res2@cnLinesOn           = False       ; do not draw contour lines
res2@cnLineLabelsOn      = False       ; do not draw contour labels
res2@cnFillScaleF        = 0.6         ; add extra density
;***********res21/res31/res32 setting***********************									 
										 res = True
res21@tiMainString = "FLNS difference in winter"
res21@gsnLeftString = ""
res21@gsnCenterString = "case2-case1"
res21@gsnRightString = "W/m2"
res21@cnLevelSelectionMode = "ManualLevels"
res21@cnMinLevelValF=-30
res21@cnMaxLevelValF=30
res21@cnLevelSpacingF = 5
res21@cnFillOn = True
res21@gsnSpreadColors = True
res21@gsnPolar    = "NH"
res21@gsnDraw=False
res21@gsnFrame=False 
res21@mpMinLatF = 30

res31@tiMainString = "FLNS difference in winter"
res31@gsnLeftString = ""
res31@gsnCenterString = "case3-case1"
res31@gsnRightString = "W/m2"
res31@cnLevelSelectionMode = "ManualLevels"
res31@cnMinLevelValF=-30
res31@cnMaxLevelValF=30
res31@cnLevelSpacingF = 5
res31@cnFillOn = True
res31@gsnSpreadColors = True
res31@gsnPolar    = "NH"
res31@gsnDraw=False
res31@gsnFrame=False 
res21@cnLinesOn=False
res31@cnLinesOn=False
res31@mpMinLatF = 30


res32@cnLinesOn=False
res32@tiMainString = "FLNS difference in winter"
res32@gsnLeftString = ""
res32@gsnCenterString = "case3-case2"
res32@gsnRightString = "W/m2"
res32@cnLevelSelectionMode = "ManualLevels"
res32@cnMinLevelValF=-10
res32@cnMaxLevelValF=10
res32@cnLevelSpacingF = 2
res32@cnFillOn = True
res32@gsnSpreadColors = True
res32@gsnPolar    = "NH"
res32@gsnDraw=False
res32@gsnFrame=False 
res32@mpMinLatF = 30

;***********************************************************
;**********************plot**************************************
;***********************************************************

printVarSummary(T221)

DIF21 = gsn_csm_contour_map_polar(wks,T221, res21)  
DIF21 = ZeroNegDashLineContour (DIF21)
DIF31 = gsn_csm_contour_map_polar(wks,T231, res31)  
DIF31 = ZeroNegDashLineContour (DIF31)
DIF32 = gsn_csm_contour_map_polar(wks,T232, res32)  
DIF32 = ZeroNegDashLineContour (DIF32)


plot21   = gsn_csm_contour(wks,gsn_add_cyclic_point(p21), res2) 
plot21   = ShadeLtContour(plot21,sig(n), 17)  ; shade all areas less than the
                                         ; 0.1 contour level
plot31   = gsn_csm_contour(wks,gsn_add_cyclic_point(p31), res2) 
plot31   = ShadeLtContour(plot31, sig(n), 17)  ; shade all areas less than the
                                         ; 0.1 contour level
plot32   = gsn_csm_contour(wks,gsn_add_cyclic_point(p32), res2) 
plot32   = ShadeLtContour(plot32, sig(n), 17)  ; shade all areas less than the
                                         ; 0.1 contour level
										 										 
	


overlay (DIF21, plot21)

overlay (DIF31, plot31)

overlay (DIF32, plot32)


 


	draw (DIF21)
;	draw (DIF31)
;	draw (DIF32)
  frame(wks)






