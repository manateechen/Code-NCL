load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

harfilea=addfile("har_d30km_m_2d_prcp_2006.nc","r")
harfileb=addfile("har_d30km_m_2d_prcp_2007.nc","r")
harfilec=addfile("har_d30km_m_2d_prcp_2008.nc","r")

pre_tmp=new((/3,200,200/),"float")

pre_tmp(0,:,:)=harfilea->prcp(5,:,:)*720.0
pre_tmp(1,:,:)=harfilea->prcp(6,:,:)*744.0
pre_tmp(2,:,:)=harfilea->prcp(7,:,:)*744.0
pre=dim_sum_n_Wrap(pre_tmp,0)

tmp=harfilea->prcp(5,:,:)
copy_VarMeta(tmp,pre)

lon=harfilea->lon
lat=harfilea->lat

out=addfile("HAR_pre_sum_2006.nc","c")
out->pre=pre
out->lat=lat
out->lon=lon

pre_tmp1=new((/3,200,200/),"float")
pre_tmp1(0,:,:)=harfileb->prcp(5,:,:)*720.0
pre_tmp1(1,:,:)=harfileb->prcp(6,:,:)*744.0
pre_tmp1(2,:,:)=harfileb->prcp(7,:,:)*744.0
pre1=dim_sum_n_Wrap(pre_tmp1,0)

tmp=harfileb->prcp(5,:,:)
copy_VarMeta(tmp,pre1)

out=addfile("HAR_pre_sum_2007.nc","c")
out->pre=pre1
out->lat=lat
out->lon=lon


pre_tmp2=new((/3,200,200/),"float")
pre_tmp2(0,:,:)=harfilec->prcp(5,:,:)*720.0
pre_tmp2(1,:,:)=harfilec->prcp(6,:,:)*744.0
pre_tmp2(2,:,:)=harfilec->prcp(7,:,:)*744.0
pre2=dim_sum_n_Wrap(pre_tmp2,0)

tmp=harfilec->prcp(5,:,:)
copy_VarMeta(tmp,pre2)

out=addfile("HAR_pre_sum_2008.nc","c")
out->pre=pre2
out->lat=lat
out->lon=lon

