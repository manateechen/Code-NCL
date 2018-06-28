; change.wrfinput.gridfill.ncl
; change landuse type and other variables in wrfinput
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/skewt_func.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/wind_rose.ncl"

begin

; constants
  ;piconst = 3.1415926535897932384626433
  piconst = acos (-1)
  DEGRAD  = piconst/180.
  Radius  = 6371009  ; meters
  Circle  = 2.*piconst*Radius
  ;dxEqu   = Circle/360.

; destination region
  Sta_Lat = 26.0
  End_Lat = 40.0
  Sta_Lon = 78.0
  End_Lon = 105.0

; destination landuse type, 3: Irrigated Cropland and Pasture, 16: Water Bodies
  landuse_0 = 17

;-----------------------------------------------------------------------

  setfileoption("nc","SuppressClose",False)

  f = addfile("/snfs01/yyx/scripts/wrfinput_d01.nc","w") ; Read file.
  f2 = addfile("/snfs01/yyx/scripts/wrfinput_d01_bak.nc","r") ; Read file.

  lat2d     = f->XLAT(0,:,:)
  lon2d     = f->XLONG(0,:,:)
  landuse2d = f2->LU_INDEX(0,:,:)

  landuse   = f->LU_INDEX
  landmask  = f->LANDMASK
  seaice    = f->SEAICE
  xland     = f->XLAND
  ivgtyp    = f->IVGTYP
  isltyp    = f->ISLTYP
  vegfra    = f->VEGFRA
  tsk       = f->TSK
  tmn       = f->TMN
  sst       = f->SST
  shdmax    = f->SHDMAX
  shdmin    = f->SHDMIN
  snoalb    = f->SNOALB
  var       = f->VAR
  albbck    = f->ALBBCK

  tslb      = f->TSLB
  smois     = f->SMOIS
  sh2o      = f->SH2O

  vegfra@_FillValue = -999.
  tsk@_FillValue    = -999.
  tmn@_FillValue    = -999.
  sst@_FillValue    = -999.
  shdmax@_FillValue = -999.
  shdmin@_FillValue = -999.
  snoalb@_FillValue = -999.
  var@_FillValue    = -999.
  albbck@_FillValue = -999.
  tslb@_FillValue   = -999.
  smois@_FillValue  = -999.
  sh2o@_FillValue   = -999.

  dims = dimsizes (lat2d)
  nlat = dims(0)
  nlon = dims(1)
  delete (dims)

  vgtyp = new (24,integer)
  do i=0,nlon-1
  do j=0,nlat-1
     k = ivgtyp(0,j,i)
     vgtyp(k-1) = k
  end do
  end do

  k = 0
  do i=0, 23
     if (ismissing(vgtyp(i))) then
        continue
     else
        k = k+1
        print ("New vgtyp "+vgtyp(i))
     end if
  end do
  print (k+" vegetable types.")

;-----------------------------------------------------------------------
; change the ivgtyp=19 "Barren or Sparsely Vegetated" to ivgtyp=17 "playa" or "Herbaceous Wetland"
; change water bodies (landuse type 17) to nearest land use type

  do i=0, nlon-1
  do j=0, nlat-1
     if (lat2d(j,i).gt.Sta_Lat .AND. lat2d(j,i).lt.End_Lat .AND. \
         lon2d(j,i).gt.Sta_Lon .AND. lon2d(j,i).lt.End_Lon) then
     if (landuse2d(j,i).eq.landuse_0) then ; lake point

        ;-----------------------------------------------------------------------
        ; add new code for search the nearest land point around lake
        ; Haifeng Zhuo, 2013/07/18

        lat     = lat2d(j,i)
        lon     = lon2d(j,i)
        distMax = Circle

        do il=0, nlon-1
        do jl=0, nlat-1
           if (lat2d(jl,il).gt.Sta_Lat .AND. lat2d(jl,il).lt.End_Lat .AND. \
               lon2d(jl,il).gt.Sta_Lon .AND. lon2d(jl,il).lt.End_Lon) then
           if (landuse2d(jl,il).ne.landuse_0) then ; not lake point, i.e. land points
              lat_in = lat2d(jl,il)
              lon_in = lon2d(jl,il)

              dLat = abs (lat - lat_in)
              dLon = abs (lon - lon_in)
              ; we have 2 points on earth: (lat,lon) and (lat_in,lon_in)
              ; distance at latitude and longitude are (dLat and dLon)
              ; First calculate delta_sigma use Vincenty Formula
              ; then get the distance on great circle
              delta_sigma = atan ( ( ( (cos(lat_in*DEGRAD)*sin(dLon*DEGRAD))^2. +                \
                                       (cos(lat*DEGRAD)*sin(lat_in*DEGRAD) -                     \
                                        sin(lat*DEGRAD)*cos(lat_in*DEGRAD)*cos(dLon*DEGRAD))^2.  \
                                     )^0.5                                                       \
                                   ) /                                                           \
                                   (    sin(lat*DEGRAD)*sin(lat_in*DEGRAD) +                     \
                                        cos(lat*DEGRAD)*cos(lat_in*DEGRAD)*cos(dLon*DEGRAD)      \
                                   )                                                             \
                                 )
              ;print ("")
              ;print ("delta_sigma= "+sprintf ("%20.18f",delta_sigma))

              ; new Formula by Haifeng Zhuo, 2013/07/19
              delta_sigma = 2.*asin ( 0.5*(                                                           \
                                            (sin(lat_in*DEGRAD)-sin(lat*DEGRAD))^2.+                  \
                                            (cos(lat*DEGRAD)-cos(lat_in*DEGRAD)*cos(dLon*DEGRAD))^2.+ \
                                            (cos(lat_in*DEGRAD)*sin(dLon*DEGRAD))^2.                  \
                                          )^0.5                                                       \
                                    )
              ;print ("delta_sigma= "+sprintf ("%20.18f",delta_sigma))

              dist = Radius * delta_sigma
              if (dist .lt. distMax) then
                 ;print ("distMax= "+distMax+" dist= "+dist+" m.")
                 distMax = dist
                 locX    = il
                 locY    = jl
                 ;print ("locX= "+locX+" locY= "+locY+" lat_in= "+lat_in+" lon_in= "+lon_in)
              end if
           end if
           end if
        end do
        end do
        print ("")
        print ("lat= "+lat+" lon= "+lon)
        print ("lat_in= "+lat2d(locY,locX)+" lon_in= "+lon2d(locY,locX))
        print ("dist= "+distMax+" m.")
        print ("locX= "+locX+" locY= "+locY)
        print ("")

        ; end of new code for search the nearest land point around lake
        ;-----------------------------------------------------------------------

        landuse(:,j,i) = landuse(:,locY,locX)
        landmask(:,j,i)= landmask(:,locY,locX)
        seaice(:,j,i)  = seaice(:,locY,locX)
        xland(:,j,i)   = xland(:,locY,locX)
        ivgtyp(:,j,i)  = ivgtyp(:,locY,locX)
        isltyp(:,j,i)  = isltyp(:,locY,locX)

        vegfra(:,j,i)  = vegfra@_FillValue
        tsk(:,j,i)     = tsk@_FillValue
        tmn(:,j,i)     = tmn@_FillValue
        sst(:,j,i)     = sst@_FillValue
        shdmax(:,j,i)  = shdmax@_FillValue
        shdmin(:,j,i)  = shdmin@_FillValue
        snoalb(:,j,i)  = snoalb@_FillValue
        var(:,j,i)     = var@_FillValue
        albbck(:,j,i)  = albbck@_FillValue

        tslb(:,:,j,i)  = tslb@_FillValue
        smois(:,:,j,i) = smois@_FillValue
        sh2o(:,:,j,i)  = sh2o@_FillValue
     end if
     end if
  end do
  end do

;-----------------------------------------------------------------------
; set the poisson_grid_fill arguments

  guess     = 1                ; use zonal means
  is_cyclic = False            ; cyclic [global]
  nscan     = 2000             ; usually much less than this
  eps       = 1.e-2            ; variable dependent
  relc      = 0.6              ; relaxation coefficient
  opt       = 0                ; not used

  poisson_grid_fill( vegfra, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( tsk, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( tmn, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( sst, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( shdmax, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( shdmin, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( snoalb, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( var, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( albbck, is_cyclic, guess, nscan, eps, relc, opt)

  poisson_grid_fill( tslb, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( smois, is_cyclic, guess, nscan, eps, relc, opt)
  poisson_grid_fill( sh2o, is_cyclic, guess, nscan, eps, relc, opt)

;-----------------------------------------------------------------------
;rewrite data
  f->LU_INDEX = landuse
  f->LANDMASK = landmask
  f->SEAICE   = seaice
  f->XLAND    = xland

  f->IVGTYP   = ivgtyp
  f->ISLTYP   = isltyp
  f->VEGFRA   = vegfra
  f->TSK      = tsk
  f->TMN      = tmn
  f->SST      = sst
  f->SHDMAX   = shdmax
  f->SHDMIN   = shdmin
  f->SNOALB   = snoalb
  f->VAR      = var
  f->ALBBCK   = albbck

  f->TSLB     = tslb
  f->SMOIS    = smois
  f->SH2O     = sh2o

;-----------------------------------------------------------------------
; plot the locations of the stations we are interested in the choosed region

;  type = "x11"
;  type = "pdf"
;  type = "ps"
;  type = "eps"
;  type = "ncgm"
;   wks = gsn_open_wks(type,"plt.wrfinput")         ; Create a plot workstation

;  gsn_define_colormap(wks,"BlGrYeOrReVi200")
;  gsn_define_colormap(wks,"gui_default")
;  gsn_define_colormap(wks,"rainbow")

;  setvalues NhlGetWorkspaceObjectId() ; make maximum filesize larger
;  "wsMaximumSize" : 200000000
;  end setvalues

;  res                     = True
;  res@gsnDraw             = True            ; don't draw
;  res@gsnFrame            = False           ; don't advance frame
;  res@cnInfoLabelOn       = False           ; turn off cn info label
;  res@cnFillOn            = True
;  res@cnLinesOn           = False
;  res@cnLineLabelsOn      = False
;  res@gsnSpreadColors     = True            ; spread out color table
;  res@gsnAddCyclic        = False

;  res@cnLevelSelectionMode = "ExplicitLevels"   ; set explict contour levels
;  res@cnLevels            = (/2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24/)
;  res@lbOrientation       = "vertical"      ; vertical labels
;  res@lbLabelPosition     = "Center"    ; label position
;  res@lbLabelAlignment    = "BoxCenters"     ; label orientation
;  res@lbLabelStrings      = (/"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"/)
;  res@lbLabelFontHeightF  = 0.01
;  res@lbTitleString       = (/"0-100=percent of snow in cell, 107=lake ice, 111=night, 250=cloud obscured water, 253=data not mapped, 254=water mask, 255=fill"/)
;  res@lbTitlePosition     = "Bottom"
;  res@lbTitleFontHeightF  = 0.015

;  res@tiMainString       = "" ; Data@long_name           ; add a title
;  res@gsnLeftString      = ""
;  res@gsnRightString     = ""

;  res@tmXBLabelFontHeightF = 0.015
;  res@tmYLLabelFontHeightF = 0.015
;  res@mpFillOn             = False
;  res@mpDataSetName        = "Earth..4"   ; This new database contains
                                          ; divisions for other countries.
;  res@mpDataBaseVersion    = "MediumRes"  ; Medium resolution database
;  res@mpOutlineOn          = True         ; Turn on map outlines
;  res@mpOutlineSpecifiers  = (/"China:states","Taiwan"/)       ;China:states
;  res@mpOutlineSpecifiers  = (/"China","Taiwan"/)               ;China
;  res@mpGeophysicalLineThicknessF= 2.      ; double the thickness of geophysical boundaries
;  res@mpNationalLineThicknessF= 2.         ; double the thickness of national boundaries
;  res@mpOutlineBoundarySets = "GeophysicalAndUSStates" ; add state boundaries
;  res@mpUSStateLineColor    = "red"                    ; make them red

;  res@mpLimitMode          = "LatLon"            ; choose range of map
;  res@mpMinLatF            = 30
;  res@mpMaxLatF            = 50
;  res@mpMinLonF            = -125+360
;  res@mpMaxLonF            = -100+360
;  res@mpMinLatF            =  Sta_Lat ;min(lat2d)
;  res@mpMaxLatF            =  End_Lat ;max(lat2d)
;  res@mpMinLonF            =  Sta_Lon ;min(lon2d)
;  res@mpMaxLonF            =  End_Lon ;max(lon2d)

;  Data = ivgtyp(0,:,:)
;  Data = isltyp(0,:,:)
;  Data = landuse2d
;  Data@lat2d = lat2d
;  Data@lon2d = lon2d

;  plot = gsn_csm_contour_map_ce (wks, Data, res)

;  frame (wks)
;  delete (plot)
;  delete (wks)

;  exit
end