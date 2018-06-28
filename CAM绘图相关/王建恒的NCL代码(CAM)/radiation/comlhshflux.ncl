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


        name    = stest(n)+"comlhshflux"

;***********************************************************
;********directionary (need to be change)********
;***********************************************************
	dir	= "/home/wjh/arctic-seaice/output"	

in1=addfile(dir+"/case1/LHFLX.nc","r")
in2=addfile(dir+"/case2/LHFLX.nc","r")
in3=addfile(dir+"/case3/LHFLX.nc","r")
;***********************************************************
;*****read month************************************
;***********************************************************
;n=11
ldec1=in1->LHFLX(11::12,:,:)
ldec2=in2->LHFLX(11::12,:,:)
ldec3=in3->LHFLX(11::12,:,:)
ljan1=in1->LHFLX(0::12,:,:)
ljan2=in2->LHFLX(0::12,:,:)
ljan3=in3->LHFLX(0::12,:,:)
lfeb1=in1->LHFLX(1::12,:,:)
lfeb2=in2->LHFLX(1::12,:,:)
lfeb3=in3->LHFLX(1::12,:,:)

;***********************************************************
;******calculate season average if need:Temp1=(DEC1+JAN1+FEB1)/3.0********
;***********************************************************

lTemp1=	(ldec1+ljan1+lfeb1)/3.0
lTemp2=	(ldec2+ljan2+lfeb2)/3.0
lTemp3=	(ldec3+ljan3+lfeb3)/3.0

;copy_VarCoords(dec1,lTemp1)
;copy_VarCoords(dec1,lTemp2)
;copy_VarCoords(dec1,lTemp3)

x=in1->LHFLX(0,:,:)
;----------------------------------------------------------

sin1=addfile(dir+"/case1/SHFLX.nc","r")
sin2=addfile(dir+"/case2/SHFLX.nc","r")
sin3=addfile(dir+"/case3/SHFLX.nc","r")
;***********************************************************
;*****read month************************************
;***********************************************************
;n=11
sdec1=sin1->SHFLX(11::12,:,:)
sdec2=sin2->SHFLX(11::12,:,:)
sdec3=sin3->SHFLX(11::12,:,:)
sjan1=sin1->SHFLX(0::12,:,:)
sjan2=sin2->SHFLX(0::12,:,:)
sjan3=sin3->SHFLX(0::12,:,:)
sfeb1=sin1->SHFLX(1::12,:,:)
sfeb2=sin2->SHFLX(1::12,:,:)
sfeb3=sin3->SHFLX(1::12,:,:)

;***********************************************************
;******calculate season average if need:Temp1=(DEC1+JAN1+FEB1)/3.0********
;***********************************************************

sTemp1=  (sdec1+sjan1+sfeb1)/3.0
sTemp2=  (sdec2+sjan2+sfeb2)/3.0
sTemp3=  (sdec3+sjan3+sfeb3)/3.0

;copy_VarCoords(dec1,Temp1)
;copy_VarCoords(dec1,Temp2)
;copy_VarCoords(dec1,Temp3)

;x=in1->SHFLX(0,:,:)
;----------------------------------------------
Temp1	= (lTemp1+sTemp1)
Temp2	= (lTemp2+sTemp2)
Temp3	= (lTemp3+sTemp3)

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
res21@tiMainString = "LH+SH flux difference in winter"
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

res31@tiMainString = "LH+SH flux difference in winter"
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
res32@tiMainString = "LH+SH flux difference in winter"
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






