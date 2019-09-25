load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

system("rm -rf storm.nc")

yearS = 1979
yearE = 2018

yyyy=ispan(yearS,yearE,1)
allfiles = "hgt." + yyyy + ".nc"

fall = addfiles (allfiles, "r")
hgt = short2flt(fall[:]->hgt)

lev = fall[0]->level
idxLev = ind(lev.eq.200)

ca = 8
cb = 2.00001

fca   = 1.0/ca
fcb   = 1.0/cb

dims  = 0
opt   = False

hgt_bf = bw_bandpass_filter(hgt(:,idxLev,:,:),fca,fcb,opt,dims)
copy_VarMeta(hgt(:,idxLev,:,:), hgt_bf)
hgt_bf@long_name = "Band Pass: "+cb+"-"+ca+" day"
printVarSummary(hgt_bf)

storm_track_activity = new((/(yearE-yearS+1)*12,73,144/),"float")
ii = 0
countLeap = 0

do year = yearS,yearE
    if (year%4.eq.0) then
        countLeap = countLeap + 1
        leap=(/31,29,31,30,31,30,31,31,30,31,30,31/)
    else
        leap=(/31,28,31,30,31,30,31,31,30,31,30,31/)
    end if
    do month = 1,12
        if (month.eq.1) then
            idxStart = (year-yearS)*365 + countLeap
            idxEnd = (year-yearS)*365+countLeap+leap(month-1)-1
        else
            idxStart = (year-yearS)*365 + countLeap + sum(leap(:month-2))
            idxEnd = (year-yearS)*365 + countLeap + sum(leap(:month-2)) + leap(month-1) - 1
        end if
        storm_track_activity(ii,:,:) = dim_stddev_n_Wrap(hgt_bf(idxStart:idxEnd,:,:), 0)
        print(year+"-"+month+"-"+idxStart+"-"+idxEnd+": "+(idxEnd-idxStart+1))
        ii = ii + 1
    end do
end do

setfileoption("nc","Format","NetCDF4")
out = addfile("storm.nc","c")
out->storm = storm_track_activity


