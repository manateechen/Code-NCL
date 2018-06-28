load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./WRFUserARW.ncl"

begin

a=addfile("/home2_hn/QQF/MCS/2014/SBU_YSU/wrfout/wrfout_d03_2014-05-23_17:50:00","r")

;  type = "x11"
; type = "pdf"
 type = "ps"
; type="png"

wks = gsn_open_wks(type, "wrfout_d03_2014-05-23_17:50:00")
  gsn_define_colormap(wks, "BlAqGrYeOrRe")

; Set some basic resources
  res = True
  res@MainTitle                   = "REAL-TIME WRF"

  pltres = True
  mpres = True
mpres@mpDataBaseVersion           = "HighRes"

  times  = wrf_user_list_times(a)   ; get times in the file
  ntimes = dimsizes(times)          ; number of times in the file

  do it =0,ntimes-1
res@TimeLabel = times(it)
    up_hel = wrf_user_getvar(a,"updraft_helicity",it)    			; here default values of 2-5km are used
    ;up_hel = wrf_user_getvar(a,(/"updraft_helicity","2500","6000"/),it)	; here user values of 2.5 and 6km are used    
    ;up_hel = wrf_user_getvar(a,(/"updraft_helicity","1000"/),it)    	; this is WRONG and will default back to 2-5km
  
    cnres                      = res
    cnres@cnFillOn             = True
    cnres@cnSmoothingOn        = True
    cnres@cnSmoothingDistanceF = .005
  ; cnres@ContourParameters    = (/ -20., 90., 5./)
  ; cnres@gsnSpreadColorEnd    = -3  ; End 3rd from the last color in color map

    contour = wrf_contour(a,wks,up_hel,cnres)
    plot   = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)

  end do

end
