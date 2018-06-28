load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

erafile=addfile("ERA-pre.nc","r")

tmp=short2flt(erafile->tp)
PRE=tmp*1000.0
PRE(0:3,:,:)=PRE(0:3,:,:)*31.0
PRE(4:7,:,:)=PRE(4:7,:,:)*28.0
PRE(8:11,:,:)=PRE(8:11,:,:)*31.0
PRE(12:15,:,:)=PRE(12:15,:,:)*30.0
PRE(16:19,:,:)=PRE(16:19,:,:)*31.0
PRE(20:23,:,:)=PRE(20:23,:,:)*30.0
PRE(24:27,:,:)=PRE(24:27,:,:)*31.0
PRE(28:31,:,:)=PRE(28:31,:,:)*31.0
PRE(32:35,:,:)=PRE(32:35,:,:)*30.0
PRE(36:39,:,:)=PRE(36:39,:,:)*31.0
PRE(40:43,:,:)=PRE(40:43,:,:)*30.0
PRE(44:47,:,:)=PRE(44:47,:,:)*31.0

copy_VarMeta(tmp,PRE)

lon=erafile->longitude
lat=erafile->latitude

pre=dim_sum_n_Wrap(PRE,0)

out=addfile("ERA_pre_sum.nc","c")
out->pre=pre
