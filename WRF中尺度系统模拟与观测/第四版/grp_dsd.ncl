load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

file01=addfile("MOR/graup.nc","r")
file02=addfile("MOR_H/graup.nc","r")
file03=addfile("WDM6/graup.nc","r")
file04=addfile("WDM6_H/graup.nc","r")

tmp01=file01->graup_melt
tmp02=file02->graup_melt
tmp03=file03->graup_melt
tmp04=file04->graup_melt

tmp01=where(tmp01.lt.0,tmp01,tmp01@_FillValue)
tmp01=where(tmp01.gt.-0.001,tmp01,tmp01@_FillValue)
tmp02=where(tmp02.lt.0,tmp02,tmp02@_FillValue)
tmp02=where(tmp02.gt.-0.001,tmp02,tmp02@_FillValue)
tmp03=where(tmp03.lt.0,tmp03,tmp03@_FillValue)
tmp04=where(tmp04.lt.0,tmp04,tmp04@_FillValue)

morg_n0=file01->graup_n0
morg_lam=file01->graup_lamb

morg_n0=where(tmp01.lt.0,morg_n0,morg_n0@_FillValue)
morg_lam=where(tmp01.lt.0,morg_lam,morg_lam@_FillValue)
print(max(morg_n0))
print(max(morg_lam))

morh_n0=file02->graup_n0
morh_lam=file02->graup_lamb

morh_n0=where(tmp02.lt.0,morh_n0,morh_n0@_FillValue)
morh_lam=where(tmp02.lt.0,morh_lam,morh_lam@_FillValue)
print(max(morh_n0))
print(max(morh_lam))

wdmg_n0=file03->graup_n0
wdmg_lam=file03->graup_lamb

wdmg_n0=where(tmp03.lt.0,wdmg_n0,wdmg_n0@_FillValue)
wdmg_lam=where(tmp03.lt.0,wdmg_lam,wdmg_lam@_FillValue)
print(max(wdmg_n0))
print(max(wdmg_lam))

wdmh_n0=file04->graup_n0
wdmh_lam=file04->graup_lamb

wdmh_n0=where(tmp04.lt.0,wdmh_n0,wdmh_n0@_FillValue)
wdmh_lam=where(tmp04.lt.0,wdmh_lam,wdmh_lam@_FillValue)
print(max(wdmh_n0))
print(max(wdmh_lam))

;morg_n0_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(morg_n0,3),2),0)
;morg_lam_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(morg_lam,3),2),0)
;
;morh_n0_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(morh_n0,3),2),0)
;morh_lam_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(morh_lam,3),2),0)
;
;wdmg_n0_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(wdmg_n0,3),2),0)
;wdmg_lam_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(wdmg_lam,3),2),0)
;
;wdmh_n0_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(wdmh_n0,3),2),0)
;wdmh_lam_prf=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(wdmh_lam,3),2),0)

morg_n0_prf=dim_avg_n_Wrap(ndtooned(morg_n0),0)
morg_lam_prf=dim_avg_n_Wrap(ndtooned(morg_lam),0)

morh_n0_prf=dim_avg_n_Wrap(ndtooned(morh_n0),0)
morh_lam_prf=dim_avg_n_Wrap(ndtooned(morh_lam),0)

wdmg_n0_prf=dim_avg_n_Wrap(ndtooned(wdmg_n0),0)
wdmg_lam_prf=dim_avg_n_Wrap(ndtooned(wdmg_lam),0)

wdmh_n0_prf=dim_avg_n_Wrap(ndtooned(wdmh_n0),0)
wdmh_lam_prf=dim_avg_n_Wrap(ndtooned(wdmh_lam),0)


rain_size=fspan(0,20,100)/1000.0

morg=morg_n0_prf*2.718^(-morg_lam_prf*rain_size)
morh=morh_n0_prf*2.718^(-morh_lam_prf*rain_size)
wdmg=wdmg_n0_prf*2.718^(-wdmg_lam_prf*rain_size)
wdmh=wdmh_n0_prf*2.718^(-wdmh_lam_prf*rain_size)

print("===========")
print(morg_n0_prf)
print(morg_lam_prf)
print(morh_n0_prf)
print(morh_lam_prf)
print(wdmg_n0_prf)
print(wdmg_lam_prf)
print(wdmh_n0_prf)
print(wdmh_lam_prf)

grpmelt=new((/4,100/),"float")
grpmelt(0,:)=morg
grpmelt(1,:)=morh
grpmelt(2,:)=wdmg
grpmelt(3,:)=wdmh

 wks=gsn_open_wks("pdf" ,"grpdsd")
 gsn_define_colormap(wks,"ncl_default")
 
 resss=True
 resss@gsnFrame           = False
 resss@gsnMaximize=True
 resss@vpHeightF          = 0.7 
 resss@vpWidthF           = 0.35
 resss@tiMainFontHeightF  = 0.018
 resss@tiXAxisFontHeightF = 0.01
 resss@tiYAxisFontHeightF = 0.018                                                                                  
 resss@xyLineThicknessF   = 2.0 
 resss@xyLineColors=(/"red","blue","green","black"/)
 resss@xyExplicitLegendLabels = (/"MOR_G","MOR_H","WDM6_G","WDM6_H"/)
 resss@tiXAxisString="scale factor: 1e5"
 resss@tiYAxisString="km"

 resss@xyYStyle="Log"

resss@trXMaxF=3.0


 resss@tiMainString      = "GRAUP_MELT"
 resss@pmLegendWidthF               = 0.03
 resss@pmLegendHeightF              = 0.2 
 resss@lgLabelFontHeightF           = .015
 resss@pmLegendSide                 = "Top"
 resss@pmLegendParallelPosF         = .4
 resss@pmLegendOrthogonalPosF       = -0.7
 resss@pmLegendDisplayMode          = "Always"

plot=gsn_csm_xy(wks,rain_size*1000.0,grpmelt,resss)
