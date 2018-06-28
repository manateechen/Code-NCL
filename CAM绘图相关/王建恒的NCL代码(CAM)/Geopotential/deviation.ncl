load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

;***********************************************************
;********directionary (need to be change)********
;***********************************************************
	dir	= "/home/wjh/arctic-seaice/output"	

in1=addfile(dir+"/case1/PSL.nc","r")
in2=addfile(dir+"/case2/PSL.nc","r")
in3=addfile(dir+"/case3/PSL.nc","r")
;***********************************************************
;*****read month************************************
;***********************************************************
n=11
dec1=in1->PSL(11::12,:,:)
dec2=in2->PSL(11::12,:,:)
dec3=in3->PSL(11::12,:,:)
jan1=in1->PSL(0::12,:,:)
jan2=in2->PSL(0::12,:,:)
jan3=in3->PSL(0::12,:,:)
feb1=in1->PSL(1::12,:,:)
feb2=in2->PSL(1::12,:,:)
feb3=in3->PSL(1::12,:,:)

;***********************************************************
;******calculate season average if need:Temp1=(DEC1+JAN1+FEB1)/3.0********
;***********************************************************

Temp1=	(dec1+jan1+feb1)/3.0
Temp2=	(dec2+jan2+feb2)/3.0
Temp3=	(dec3+jan3+feb3)/3.0

copy_VarCoords(dec1,Temp1)
copy_VarCoords(dec1,Temp2)
copy_VarCoords(dec1,Temp3)

x=in1->PSL(0,:,:)
;***********************************************************
;******cal dif average*****************************
;***********************************************************

;Temp21=Temp2-Temp1
;Temp31=Temp3-Temp1
;Temp32=Temp3-Temp2

;copy_VarCoords(dec1,Temp21)
;copy_VarCoords(dec1,Temp31)
;copy_VarCoords(dec1,Temp32)

;T221=dim_avg_n_Wrap(Temp21,0)
;T231=dim_avg_n_Wrap(Temp31,0)
;T232=dim_avg_n_Wrap(Temp32,0)

;copy_VarCoords(x,T231)
;copy_VarCoords(x,T221)
;copy_VarCoords(x,T232)
;***********************************************************
;********calculate deviation *******************************
;***********************************************************
printVarSummary(Temp21)

  Dev1	= dim_stddev_n_Wrap(Temp1,0)	
  Dev2 = dim_stddev_n_Wrap(Temp2,0)
  Dev3 = dim_stddev_n_Wrap(Temp3,0)

printVarSummary(Dev1)
;********wks**********************
wks = gsn_open_wks("eps","deviationPSL")
gsn_define_colormap(wks,"gui_default")
;********dif res*************************
res21=True
res31=True
res32=True
res2 = True                            ; res2 probability plots
res2@gsnDraw             = False       ; Do not draw plot
res2@gsnFrame            = False       ; Do not advance frome
res2@cnLevelSelectionMode = "ManualLevels" ; set manual contour levels
;res2@cnMinLevelValF      = 0.00        ; set min contour level
;res2@cnMaxLevelValF      = 1.05        ; set max contour level
res2@cnLevelSpacingF     = 0.05        ; set contour spacing
res2@cnInfoLabelOn       = False       ; turn off info label
res2@cnLinesOn           = False       ; do not draw contour lines
res2@cnLineLabelsOn      = False       ; do not draw contour labels
res2@cnFillScaleF        = 0.6         ; add extra density
;***********res21/res31/res32 setting***********************									 
res = True

res21@tiMainString = "PSL deviation in winter"
res21@gsnLeftString = ""
res21@gsnCenterString = "case1"
res21@gsnRightString = "Pa"
res21@cnLevelSelectionMode = "ManualLevels"
;res21@cnMinLevelValF=-160
;res21@cnMaxLevelValF= 160
res21@cnLevelSpacingF = 1
res21@cnFillOn = True
res21@gsnSpreadColors = True
res21@gsnPolar    = "NH"
res21@gsnDraw=False
res21@gsnFrame=False 
res21@mpMinLatF = 30

res31@tiMainString = "PSL deviation in winter"
res31@gsnLeftString = ""
res31@gsnCenterString = "case2"
res31@gsnRightString = "Pa"
res31@cnLevelSelectionMode = "ManualLevels"
;res31@cnMinLevelValF= -160
;res31@cnMaxLevelValF= 160
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
res32@tiMainString = "PSL deviation in winter"
res32@gsnLeftString = ""
res32@gsnCenterString = "case3"
res32@gsnRightString = "Pa"
res32@cnLevelSelectionMode = "ManualLevels"
;res32@cnMinLevelValF= -160
;res32@cnMaxLevelValF= 160
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

DIF1 = gsn_csm_contour_map_polar(wks,Dev1, res21)  
;DIF21 = ZeroNegDashLineContour (DIF21)
DIF2 = gsn_csm_contour_map_polar(wks,Dev2, res31)  
;DIF31 = ZeroNegDashLineContour (DIF31)
DIF3 = gsn_csm_contour_map_polar(wks,Dev3, res32)  
;DIF32 = ZeroNegDashLineContour (DIF32)


;plot21   = gsn_csm_contour(wks,gsn_add_cyclic_point(p21), res2) 
;plot21   = ShadeLtContour(plot21, 0.12, 17)  ; shade all areas less than the
                                         ; 0.05 contour level
;plot31   = gsn_csm_contour(wks,gsn_add_cyclic_point(p31), res2) 
;plot31   = ShadeLtContour(plot31, 0.12, 17)  ; shade all areas less than the
                                         ; 0.05 contour level
;plot32   = gsn_csm_contour(wks,gsn_add_cyclic_point(p32), res2) 
;plot32   = ShadeLtContour(plot32, 0.12, 17)  ; shade all areas less than the
                                         ; 0.05 contour level
										 										 
	


;overlay (DIF21, plot21)

;overlay (DIF31, plot31)

;overlay (DIF32, plot32)


 


	draw (DIF1)
;	draw (DIF2)
;	draw (DIF3)
  frame(wks)






