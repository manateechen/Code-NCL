load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"      	; functions required to
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"           	; plot.  include before
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"         	; begin

name	= "case2-1"

calc_div=1
show_accel=0
scale_by_sqrt_p=1

outnameps = "epflux"
sf=5

	fra	= addfile("./test/epfluxwinter-case1.nc","r")	
	frb	= addfile("./test/epfluxwinter-case2.nc","r")

	Fphi_inta	= fra->Fphi_int		;(vertical or meridional)
	Fp_inta		= fra->Fp_int		;(vertical or meridional)
	dudt_inta	= fra->dudt_int		;divergence of ep divided by radius of 
	EPdiv_inta	= fra->EPdiv_int	;divergence of ep
	Uzmtm_inta	= fra->Uzmtm_int	;zonal wind	

	level		= fra->level
   	level_int	= fra->level_int
   	lat		= fra->lat


	Fphi_intb	= frb->Fphi_int
        Fp_intb 	= frb->Fp_int
        dudt_intb	= frb->dudt_int
        EPdiv_intb	= frb->EPdiv_int
        Uzmtm_intb	= frb->Uzmtm_int


	Fphi_int	= Fphi_intb-Fphi_inta
	Fp_int		= Fp_intb-Fp_inta
	dudt_int	= dudt_intb-dudt_inta
	EPdiv_int	= EPdiv_intb-EPdiv_inta
	Uzmtm_int	= Uzmtm_intb-Uzmtm_inta

copy_VarCoords(Fphi_inta,Fphi_int)
copy_VarCoords(Fp_inta,Fp_int)
copy_VarCoords(dudt_inta,dudt_int)
copy_VarCoords(EPdiv_inta,EPdiv_int)
copy_VarCoords(Uzmtm_inta,Uzmtm_int)

;************************************************
; Create Plot 
;************************************************
; create vector plot resources for pressure-level grid  (not used for plotting in this version)
  res_vec = True
  res_vec@vfYArray              = level                ; use pressure for y axis
  res_vec@vfXArray              = lat             ; use lat for x axis
  res_vec@tiXAxisString         = "latitude"           ; x-axis label
  res_vec@tiYAxisString         = "pressure (mb)"         ; y-axis label
  res_vec@trYReverse            = True                 ; reverse y-axis
  res_vec@gsnSpreadColors       = True		       	    ; use full colormap
  res_vec@vcRefMagnitudeF       = 10                 ; add a reference vector
  res_vec@vcRefLengthF          = 0.1                ; what the ref length is
  res_vec@vcMonoLineArrowColor  = False                ; vec's colored by their mag
  res_vec@pmLabelBarDisplayMode = "Always"          ; Turn on a label bar.
  res_vec@pmLabelBarWidthF      = 0.08              ; make it thinner
  res_vec@lbPerimOn             = False             ; no box around it
  res_vec@gsnYAxisIrregular2Log = True                 ; set y-axis to log scale
  res_vec@tiMainString          = "EPflux"+"-"+name	; plot title
  res_vec@tiMainFontHeightF     = 0.0185
  res_vec@tiXAxisFontHeightF    = 0.0185
  res_vec@tiYAxisFontHeightF    = 0.0185

;  You can't assign new coordinates to a resource because the attributes are of different sizes
;  You can't delete just the one attribute, so you have to list them all over again.

;  Create vector plot resources for interpolated grid

  res_vec_int = res_vec
  delete(res_vec_int@vfXArray)
  delete(res_vec_int@vfYArray)
  res_vec_int@vfYArray              = level_int                ; use pressure for y axis
  res_vec_int@vfXArray              = lat(1:95:2)             ; use lat for x axis
  res_vec_int@tiXAxisString         = "latitude"           ; x-axis label
  res_vec_int@tiYAxisString         = "pressure (mb)  log-scale"         ; y-axis label
  res_vec_int@vpWidthF              = 0.60
  res_vec_int@vpHeightF             = 0.35
;  res_vec_int@lbLabelBarOn          = False                     ; turn off label bar
;  res_vec_int@gsnMaximize           = True
 res_vec_int@gsnDraw                = False                     ; turn off automatic draw -- allows for manual overalying of plots
 res_vec_int@gsnFrame               = False                     ; turn off automatic frame -- allows for manual overalying of plots
res_vec_int@vcLevelSelectionMode = "ManualLevels"
res_vec_int@vcLevelSpacingF  = 2
res_vec_int@vcMinLevelValF = 0
res_vec_int@vcMaxLevelValF = 16
 res_vec_int@vcRefAnnoOn             = False              ; turn off ref wind barb


; Create contour plot resources for interpolated grid
  res_con_int                       = True
  res_con_int@sfYArray              = level_int                ; use pressure for y axis
  res_con_int@sfXArray              = lat(1:95:2)             ; use lat for x axis
;  res_con_int@cnFillOn             = True     ; turn on color fill
  res_con_int@trYReverse            = True                 ; reverse y-axis
  res_con_int@gsnYAxisIrregular2Log = True                 ; set y-axis to log scale
 res_con_int@gsnDraw                = False
 res_con_int@gsnFrame               = False
 res_con_int@gsnContourZeroLineThicknessF = 2
 res_con_int@gsnContourPosLineDashPattern = 2
 res_con_int@gsnContourNegLineDashPattern = 1
 res_con_int@cnSmoothingOn          = True
 res_con_int@cnLineLabelsOn         = False
 res_con_int@gsnContourLineThicknessesScale  = .3

;res_con_int@cnFillOn	= True
res_con_int@cnLinesOn	= True
 
;res_con_int@cnFillColors        = (/"transparent","gray"/)

res_con_int@cnLevelSelectionMode = "ManualLevels"
res_con_int@cnLevelSpacingF  = 5
res_con_int@cnMinLevelValF = -20
res_con_int@cnMaxLevelValF = 20


res_con_int@cnLineColor   = (/"red"/)
; Hide the 1000 mb level for the divergence and acceleration
dudt_int@_FillValue = -999.0
dudt_int(0,:)=dudt_int@_FillValue
EPdiv_int@_FillValue = -999.0
EPdiv_int(0,:)=EPdiv_int@_FillValue

;====================================
printVarSummary(Uzmtm_int)

print("*********** max(Uzmtm_int) = "+max(Uzmtm_int(:,:20))+" ************")
print("*********** min(Uzmtm_int) = "+min(Uzmtm_int(:,:20))+" ************")

;====================================

; open file and create graphic
;  print(filename)
;**********************************************************************************

  wksvec_int  = gsn_open_wks("eps","plot"+name)                ; Opens a ps file 
  gsn_define_colormap(wksvec_int,"rainbow") 

  plotvec = gsn_vector(wksvec_int,Fphi_int,Fp_int,res_vec_int)     ; creates plot
  if (calc_div .eq. 1) then
    if (show_accel .eq. 1) then 
;      res_con_int@cnLevelSpacingF        = 5.                   ;Contour level Spacing
      plotvec2 = gsn_contour(wksvec_int,dudt_int,res_con_int)     ; creates plot for du/dt = div(F)/(a*cos(phi))
    else
;      res_con_int@cnLevelSpacingF        = 100.                   ;Contour level Spacing
      plotvec2 = gsn_contour(wksvec_int,EPdiv_int,res_con_int)     ; creates plot for div(F)
    end if
    overlay(plotvec,plotvec2)
  end if

res=True
; Create contour plot resources for interpolated grid
res @sfYArray              = level_int                ; use pressure for y axis
res @sfXArray              = lat(1:95:2)             ; use lat for x axis
;  res_con_int@cnFillOn             = True     ; turn on color fill
res@trYReverse            = True                 ; reverse y-axis
res@gsnYAxisIrregular2Log = True                 ; set y-axis to log scale
res@gsnDraw                = False
res@gsnFrame               = False
res@gsnContourZeroLineThicknessF = 2.0
res@gsnContourPosLineDashPattern = 2
res@gsnContourNegLineDashPattern = 1
res@cnSmoothingOn          = True
res@cnLineLabelsOn         = False
res@cnInfoLabelOn   = False
res@cnLevelSelectionMode = "ManualLevels"
res@cnLevelSpacingF  = 0.2
res@cnMinLevelValF = -1
res@cnMaxLevelValF = 1

;res@cnLevelSpacingF = 0.2
res@gsnContourLineThicknessesScale  = 1.0
res@cnLineColor   = (/"black"/)
plotvec3 = gsn_csm_contour(wksvec_int,Uzmtm_int,res) 
overlay(plotvec,plotvec3)
  draw(plotvec)
frame(wksvec_int)
