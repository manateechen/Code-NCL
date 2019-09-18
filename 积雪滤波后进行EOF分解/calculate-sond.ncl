load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "./interannual.ncl"



season="SON"
idx_A = 8 
idx_B = 9
idx_C = 10
idx_D = 11

yearstart = 1979
yearend = 2018
nyear = yearend - yearstart + 1
nyears = yearend - yearstart + 1

varfile = addfile("../../PhD-Working2/ncfile/rutgersnownc/mysnowcover.nc","r")

vars = varfile->snowcover

lat=varfile->lat
lon=varfile->lon

lat_idx=ind(lat.ge.25.and.lat.le.40)
lon_idx=ind(lon.ge.70.and.lon.le.105)

year=calendar_decode2(varfile->time,0)
year_idx=ind(year(:,0).ge.yearstart.and.year(:,0).le.yearend)
;printVarSummary(year_idx)
;print(year(year_idx,0))

varss = vars(year_idx,:,:)

varA = varss(idx_A::12,:,:)
varB = varss(idx_B::12,:,:)
varC = varss(idx_C::12,:,:)
varD = varss(idx_D::12,:,:)

var = (varA+varB+varC+varD)/4.0
copy_VarMeta(varA,var)
var = SqrtCosWeight(var)

var = dim_standardize_n_Wrap(var, 0, 0)


interan = var

do i = 0, dimsizes(lat)-1
    do j = 0, dimsizes(lon)-1
        interan(:,i,j) = 0
        interannual(var(:,i,j),interan(:,i,j),dimsizes(var(:,i,j)))   
    end do
end do

copy_VarMeta(varA, interan)

neof   = 2 

optEOF = True       
optEOF@jopt = 0

optETS = False

itheof = 0

eof=eofunc_n_Wrap(interan(:,lat_idx,lon_idx),neof,optEOF,0)
eof_ts=eofunc_ts_n_Wrap(interan(:,lat_idx,lon_idx),eof,optETS,0)

sig_ev  = eofunc_north(eof@eval, nyears, True)

ts = dim_standardize_n_Wrap(eof_ts(itheof,:), 0, 0)
rc = regCoef_n(ts,interan, 0, 0)
copy_VarMeta(interan(0,:,:),rc)
tval = reshape(rc@tval,(/dimsizes(interan(0,:,0)),dimsizes(interan(0,0,:))/))
copy_VarMeta(interan(0,:,:),tval)
delete(rc@tval)

system("rm -rf eof-son.nc")
out = addfile("eof-son.nc", "c")
out->eof1 = rc
out->tval1 = tval
out->ts1 = ts
out->var1 = eof@pcvar(0)

asciiwrite("./sc.txt",ts)
asciiwrite("./ts1.txt",eof_ts(itheof,:)) 
