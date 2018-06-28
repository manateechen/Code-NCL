load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

erafile=addfile("summer_2008.nc","r")

tmp=short2flt(erafile->tp)
PRE=tmp*1000.0
PRE(0,:,:)=PRE(0,:,:)*30.0
PRE(1,:,:)=PRE(1,:,:)*31.0
PRE(1,:,:)=PRE(1,:,:)*31.0
copy_VarMeta(tmp,PRE)

lon=erafile->longitude
lat=erafile->latitude

pre=dim_sum_n_Wrap(PRE,0)

out=addfile("ERA_pre_sum_2008.nc","c")
out->pre=pre
