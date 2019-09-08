load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "./interannual.ncl"

season="MAM"
idx_A = 2
idx_B = 3
idx_C = 4

ttestval = 1.995

latU = 50.
latL = 1
lonL = 97.5
lonR = 145.

yy = 1971

year_start = 1971
year_end = 2018
nyears = year_end - year_start + 1
nmonths = nyears*12

varfile = addfile("./pre.nc","r")

lat = varfile->lat
lon = varfile->lon

lat_idx=ind(lat.ge.latL.and.lat.le.latU)
lon_idx=ind(lon.ge.lonL.and.lon.le.lonR)

vars = varfile->pre(0:575,:,:)

vA = vars(idx_A::12,:,:)
vB = vars(idx_B::12,:,:)
vC = vars(idx_C::12,:,:)

vClim = (vA + vB + vC)
copy_VarMeta(vA, vClim)
vClim = SqrtCosWeight(vClim)

interan = vClim

do i = 0, dimsizes(lat)-1
    do j = 0, dimsizes(lon)-1
        interan(:,i,j) = 0
        interannual(vClim(:,i,j),interan(:,i,j),dimsizes(vClim(:,i,j)))   
    end do
end do

copy_VarMeta(vA, interan)

neof   = 3    

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

out = addfile("eof-mam.nc", "c")
out->eof1 = rc
out->tval1 = tval
out->ts1 = ts
out->var1 = eof@pcvar(0)

itheof = 1
ts2 = dim_standardize_n_Wrap(eof_ts(itheof,:), 0, 0)
rc2 = regCoef_n(ts2,interan, 0, 0)
copy_VarMeta(interan(0,:,:),rc2)
tval2 = reshape(rc2@tval,(/dimsizes(interan(0,:,0)),dimsizes(interan(0,0,:))/))
copy_VarMeta(interan(0,:,:),tval2)

out->eof2 = rc2
out->tval2 = tval2
out->ts2 = ts2
out->var2 = eof@pcvar(1)