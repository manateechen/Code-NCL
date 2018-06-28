load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

f1=addfile("sensitive_2000_2011.nc","r")
f2=addfile("sensitive_1980_1991.nc","r")

PRECC1=f1->PRECC(12:,:,:)
PRECC2=f2->PRECC(12:,:,:)
PRECL1=f1->PRECL(12:,:,:)
PRECL2=f2->PRECL(12:,:,:)
PRECSH1=f1->PRECSH(12:,:,:)
PRECSH2=f2->PRECSH(12:,:,:)
gw1=f1->gw
gw2=f2->gw
time1=f1->time
time2=f2->time

PRECC1_ave=PRECC1*31536000.0*1000.0
copy_VarMeta(PRECC1,PRECC1_ave)
PRECC2_ave=PRECC2*31536000.0*1000.0
copy_VarMeta(PRECC2,PRECC2_ave)
PRECL1_ave=PRECL1*31536000.0*1000.0
copy_VarMeta(PRECL1,PRECL1_ave)
PRECL2_ave=PRECL2*31536000.0*1000.0
copy_VarMeta(PRECL2,PRECL2_ave)
PRECSH1_ave=PRECSH1*31536000.0*1000.0
copy_VarMeta(PRECSH1,PRECSH1_ave)
PRECSH2_ave=PRECSH2*31536000.0*1000.0
copy_VarMeta(PRECSH2,PRECSH2_ave)

TOTAL1=PRECC1_ave+PRECL1_ave+PRECSH1_ave
copy_VarMeta(PRECSH1_ave,TOTAL1)
TOTAL2=PRECC2_ave+PRECL2_ave+PRECSH2_ave
copy_VarMeta(PRECSH2_ave,TOTAL2)
    
total1_time=wgt_areaave(TOTAL1,gw1,1.0,0)   
total2_time=wgt_areaave(TOTAL2,gw2,1.0,0)
total_diff=total1_time-total2_time
    
res                      = True
res@gsnMaximize=True
res@vpWidthF=0.75
res@vpHeightF=0.3
res@trXMaxF=2011
restick=True
restick@ttmFormat="%Y"

time_axis_labels(time1,res,restick)
wks  = gsn_open_wks("eps","PRE_TIME1")
plot=gsn_csm_xy(wks,time1,total1_time,res)
delete(wks)

time_axis_labels(time2,res,restick)
wks  = gsn_open_wks("eps","PRE_TIME2")
plot=gsn_csm_xy(wks,time2,total1_time,res)
delete(wks)

time_axis_labels(time2,res,restick)
wks  = gsn_open_wks("eps","PRE_DIFF")
plot=gsn_csm_xy(wks,time2,total_diff,res)
delete(wks)