load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin
out=addfile("1degreesst.nc","c")
data=new((/12,180,360/),"float")
do i=0,11
	name	=	"Spring"
	;seas	=	"MAM"
psig	=	0.102		;0.002
mons = (/"Jan.","Feb.","Mar.","Apr.","May.","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec."/)
	system("rm -rf "+name+".eps")

	latS   =  -90.
  	latN   =  90. 
  	lonL   =  0
  	lonR   =  360

	yst	= 1870
        yra	= 1988
	yrb	= 1994

	yrc	= 2007
	yrd	= 2013
	
;===================================================================

;-----------------------------------------------------------------
;       Read and process the Giss temperature
;-----------------------------------------------------------------

        dir	=       "."

        f	=       addfile(dir+"/MODEL.SST.HAD187001-198110.OI198111-201403.nc","r")        ;msl	
	fmsl    =       f->SST(:1731-4,:,:)

	;tsum	=	month_to_season(fmsl,seas)
tsum = fmsl
printVarSummary(tsum)
print(yra-yst+i)
print(yrb-yst+i)
	suma	=	tsum(time|(yra-yst)*12+i:(yrb-yst)*12+i:12,{lat|latS:latN},{lon|lonL:lonR})
	sumb	=	tsum(time|(yrc-yst)*12+i:(yrd-yst)*12+i:12,{lat|latS:latN},{lon|lonL:lonR})
;--------------------------------------------------------------------------------------------
printVarSummary(suma)        
        avg1   =       dim_avg_n_Wrap(suma,0)
        avg2   =       dim_avg_n_Wrap(sumb,0)
	diff	=	avg2-avg1

	var1	=	dim_variance_n_Wrap(suma,0)
	var2	=	dim_variance_n_Wrap(sumb,0)
data(i,:,:)=avg1



end do
out->data=data
end


