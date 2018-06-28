;**************************************************
; skewt_2.ncl
;
; Concepts illustrated:
;   - Drawing Skew-T plots
;   - Drawing a Skew-T plot with and without wind barbs
;   - Customizing the background of a Skew-T plot
;*************************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/skewt_func.ncl"
;***********************************************
 begin

; --- Read Data; no winds; set to _FillValue------------;
  diri = "./"
  fili = "Z_UPAR_I_59265_20140522051523_O_TEMP-L.txt"
  nlvl = 3138
  ncol = 12
  TestData = asciiread (diri+fili , (/nlvl,ncol/), "float") 

  p    = TestData (:,2)
  z    = TestData (:,11)
  q    = TestData (:,3)
  tc   = TestData (:,1)     ; for demo purposes
  tk=tc+273.15

  tdc  = dewtemp_trh(tk,q)-273.15
                                ; create BOGUS winds
  wspd = TestData (:,10)  ; wspd@_FillValue = -999.
  wdir = TestData (:,9)   ; wdir@_FillValue = -999.
aa=40
;*************************
; create plot
;*************************
  wks  = gsn_open_wks ("pdf", "skewt")

; --- Create background skew-T; plot sounding ---------------------

  skewtOpts                 = True
  skewtOpts@DrawColAreaFill = True    ; default is False
  skewtOpts@tiMainString    = "Wuzhou-2014052205UTC" 

  dataOpts   = True        ; no options
  dataOpts@DrawFahrenheit=False
  dataOpts@ThermoInfo=True
;  dataOpts@PrintZ = False
  skewt_bkgd = skewT_BackGround (wks, skewtOpts)
  skewt_data = skewT_PlotData   (wks, skewt_bkgd, p(::aa),tc(::aa),tdc(::aa),z(::aa) \
                                    , wspd(::aa),wdir(::aa), dataOpts)
  draw (skewt_bkgd)
  draw (skewt_data)
  frame(wks)

  print(skewt_data@Cape)
  print(skewt_data@Pwat)
  print(skewt_data@Shox)
  print(skewt_data@Plcl)
  print(skewt_data@Tlcl)

 end
