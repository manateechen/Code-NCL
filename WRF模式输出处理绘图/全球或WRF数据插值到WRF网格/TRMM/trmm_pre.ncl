load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

trmmfilea=addfile("3B43.20080601.7A.nc","r")
trmmfileb=addfile("3B43.20080701.7A.nc","r")
trmmfilec=addfile("3B43.20080801.7A.nc","r")

pre_tmp=new((/3,400,1440/),"float")

pre_tmp(0,:,:)=dim_sum_n_Wrap(trmmfilea->pcp,0)*720.0
pre_tmp(1,:,:)=dim_sum_n_Wrap(trmmfileb->pcp,0)*744.0
pre_tmp(2,:,:)=dim_sum_n_Wrap(trmmfilec->pcp,0)*744.0
pre=dim_sum_n_Wrap(pre_tmp,0)

tmp=trmmfilea->pcp
copy_VarMeta(tmp(0,:,:),pre)

lon=trmmfilea->longitude
lat=trmmfilea->latitude

out=addfile("TRMM_pre_sum_2008.nc","c")
out->pre=pre
