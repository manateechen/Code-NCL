load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
       
	name	= "lat-case3-1eof"


do	n	= 0,4   ;modes

	system("rm -rf "+name+(n+1)+".eps")

	f	=	addfile("./lat-T2mevev_ts.nc","r")
	ev	=	f->ev
	ev_ts	=	f->ev_ts
	plot	=	new(2,graphic)
	
	x	=	ispan(1,50,1)

	rc	= 	regline(x,ev_ts(n,:))

	y	=	rc*(x-rc@xave) + rc@yave	

;---------------------------------------------------------
 pnum    =       num(ev_ts(n,:).gt.0)
print("************ "+"positive = "+pnum+" *************")
;---------------------------------------------------------
;------- Significance test -------------------------------
;---------------------------------------------------------
	df	= rc@nptxy-2

	prob	= (1-betainc(df/(df+rc@tval^2),df/2.0,0.5))

print("********* prob"+(n+1)+" = "+prob+" ************")

;-----------------------------------------------------
;PLOt
;-----------------------------------------------------

	wks	=	gsn_open_wks("eps",name+(1+n))

	gsn_define_colormap(wks,"BlueYellowRed")

	res     =       True

	res@gsnAddCyclic=	False
	res@mpShapeMode	=	"FreeAspect"

        res@cnFillOn    =       True
	res@cnLinesOn	=	False

	res@gsnDraw	=	False
	res@gsnFrame	=	False

	res@lbLabelBarOn=	True
	res@pmLabelBarOrthogonalPosF = 0.1	
	
	res@cnLevelSelectionMode      = "ExplicitLevels"
	res@cnLevels  = fspan(-0.04,0.04,9)

	
	res@mpMinLatF            = 30     ; range to zoom in on
;	res@mpMaxLatF            = 60.
;	res@mpMinLonF            = -20
;	res@mpMaxLonF            = 180.

;	res@vpXF      = 0.50        ; change start locations
;	res@vpYF      = 0.9        ; the plot

	res@gsnPolar	=	"NH"
;	res@mpCenterLonF=	90
	res@gsnLeftString       =       name+(n+1)
	res@gsnLeftStringFontHeightF    = 0.026

;	res@gsnCenterString	=	"EOF"+(n+1)
	res@gsnRightString      =       sprintf("%5.1f",ev@pcvar(n))+"%"
	res@gsnRightStringFontHeightF    = 0.026

 	res@mpGeophysicalLineThicknessF  = 2.0

   	res@mpDataBaseVersion     = "Ncarg4_1"
   ;	res@mpOutlineBoundarySets = "Noboudary"		;"National"

	res@mpFillOn          =       False	

;	res@vpWidthF		=	0.9
;	res@vpHeightF		=	0.4

	plot(0)	=	gsn_csm_contour_map_polar(wks,ev(n,:,:),res)

;---------------------------------------------------------
; Add box
;---------------------------------------------------------		
	lat1	= (/ 30, 30, 60, 60, 30/)
	lon1	= (/-130,-70,-70,-130,-130/)	;N.A
	
	lat2	= (/ 45, 45, 70, 70, 45/)	;Eu
	lon2	= (/  0, 60, 60,  0,  0/)

	lat3	= (/ 50, 50, 70, 70, 50/)	;Asia
	lon3	= (/ 60,130,130, 60, 60/)  

	lat4    = (/ 20, 20, 50, 50, 20/)       ;EA2
        lon4    = (/105,150,150,105,105/)
	
	polyres	= True
	polyres@gsLineColor	= "black"
	polyres@LineThicknessF	= 4.0

	dum1	= new(4,graphic)
	dum2	= new(4,graphic)
	dum3	= new(4,graphic)
	dum4    = new(4,graphic)

;	do m = 0,3

;	dum1(m)	= gsn_add_polyline(wks,plot(0),lon1(m:m+1),lat1(m:m+1),polyres)
;	dum2(m)	= gsn_add_polyline(wks,plot(0),lon2(m:m+1),lat2(m:m+1),polyres)
;	dum3(m)	= gsn_add_polyline(wks,plot(0),lon3(m:m+1),lat3(m:m+1),polyres)
;	dum4(m) = gsn_add_polyline(wks,plot(0),lon4(m:m+1),lat4(m:m+1),polyres)

;	end do


;**********************************************************************************
;add Yangtzi and Yellow rivers
;**********************************************************************************
;	fr     =       addfile("/raid/home/hjb/map/Chinamap.nc","r")

;	nplot=new(3,graphic)

;	rl = True
;	rl@gsLineColor = "black"
;	rl@gsLineThicknessF = 1.5

;	nplot(0) = gsn_add_polyline(wks,plot(0),fr->mplon,fr->mplat,rl)
;	nplot(1) = gsn_add_polyline(wks,plot(0),fr->Yslon,fr->Yslat,rl)
;	nplot(2) = gsn_add_polyline(wks,plot(0),fr->Yrlon,fr->Yrlat,rl)

;----------------------------------------------------------------------
	
	rts           = True

	rts@gsnDraw   = False       ; don't draw yet
	rts@gsnFrame  = False       ; don't advance frame yet
	rts@gsnScale  = True        ; force text scaling

; these four rtsources allow the user to stretch the plot size, and
; decide exactly where on the page to draw it.

	rts@vpHeightF = 0.3       ; Changes the aspect ratio
	rts@vpWidthF  = 0.9
	rts@trXMinF	= 1

;	rts@vpXF      = 0.1      ; change start locations
;	rts@vpYF      = 0.95        ; the plot

	rts@gsnYRefLine           = 0.              ; reference line

	rts@gsnLeftString  = "PC"+(n+1)

	tr	= rc*10

	rts@gsnRightString = " "	;"Trend = "+sprintf("%5.1f", tr) +"%"+"/10yr"
	plot(1) = gsn_csm_xy (wks,f->ev_ts&var,ev_ts(n,:),rts)
;----------------------------------------
; Add regline
;----------------------------------------

	polyres@gsLineColor     = "blue"
        polyres@LineThicknessF  = 6.0

	rtsline = gsn_add_polyline(wks,plot(1),x,y,polyres)

;-------------------------------------------------------------------
		
	resp	= True             ; modify the panel plot

	resp@Draw                = False
	resp@Frame               = False

	resp@txString		 = "               EOF"+(n+1) 
	resp@gsnPanelLeft	 = 0.1
;	resp@gsnPanelLabelBarOn	 = True
;	resp@gsnPanelBottom   = 0.02
		
;	resp@gsnMaximize         = True             ; large format
	gsn_panel(wks,plot,(/2,1/),resp)     ; now draw as one plot

system("rm -rf "+name+(n+1)+".png")
;system("convert -trim -density 300 "+name+(n+1)+".eps "+name+(n+1)+".png")

end do
end
