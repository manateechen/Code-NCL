load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin
	system("rm -rf T2mevev_ts.nc")

	latS   =  30.
  	latN   =  90. 
  	lonL   =  0
  	lonR   =  360

	
	neof	=	5		
	optEOF = False      
	optETS = False
	optEOF@pcrit = 100

;===================================================================

;-----------------------------------------------------------------
;       Read and process the Giss temperature
;-----------------------------------------------------------------

        dir1	=       "/home/wjh/arctic-seaice2/output/case3"
	dir2	=	"/home/wjh/arctic-seaice2/output/case1"

        f1	=       addfile(dir1+"/T2m.nc","r")        ;600 time
	f2	=	addfile(dir2+"/T2m.nc","r")

        air1	=       f1->T2m
	air2	=	f2->T2m

        tdec1	=       air1(0::15,:,:)         ;
        tjan1	=       air1(1::15,:,:)         ;
        tfeb1	=       air1(2::15,:,:)         ;

	tdec2	=	air2(0::15,:,:)
	tjan2	=	air2(1::15,:,:)
	tfeb2	=	air2(2::15,:,:)

;-----------------------------------------------

        twin1	= (tdec1+tjan1+tfeb1)/3.0		
	twin2	= (tdec2+tjan2+tfeb2)/3.0

	twin	= twin1 - twin2

        copy_VarCoords(tdec1,twin)


;===================================================================
	year	=	ispan(1,50,1)

	pmo	=	lonFlip(twin)
	
;**************** alternative**************

	pmon	=	pmo({lat|latS:latN},lon|:,time|:)


;	pmon	=	dtrend(pmon,False)	;***************************

	clat	=	pmon&lat*2*3.1415926/360
printVarSummary(pmon&lat)

	pano	=	pmon*conform(pmon,cos(clat),0)
	pano!0	=	"lat"
	pano!1	=	"lon"
	pano&lat=	pmon&lat
	pano!2	=	"time"
	pano&lon=	pmon&lon

printVarSummary(pano)

	peof	=	pano(lat|:,lon|:,time|:)
	nclat	=	peof&lat*2*3.1415926/360

	dims	=	dimsizes(peof)

	eof    = eofunc(peof, neof, optEOF)      
	eof_ts = eofunc_ts(peof, eof, optETS)

 	wgt	=	dims(1)*sum(cos(nclat))
	eof_ts	=	eof_ts/wgt

 	eof!0	=	"num"
	eof!1	=	"lat"
	eof!2	=	"lon"
	eof&lat	=	peof&lat
	eof&lon	=	peof&lon
	eof_ts!0=	"numod"
	eof_ts!1=	"var"
	eof_ts&var=	year
printVarSummary(eof)
printVarSummary(eof_ts)

;********************print ncfile***************************
	fnc	=	addfile("T2mevev_ts.nc","c")
	eof@long_name	=	"eof modes"
	fnc@long_name	=	"eof principal component of T2m from case3-case1"
	eof_ts@time	=	"DJF for 50 members"
	fnc@author	=	"HUANG Jianbin"
	fnc->ev	=	eof
	fnc->ev_ts	=	eof_ts


end
