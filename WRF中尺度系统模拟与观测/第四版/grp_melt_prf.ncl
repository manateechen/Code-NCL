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

morg_grp_mlt=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(-tmp01,3),2),0)
morh_grp_mlt=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(-tmp02,3),2),0)
wdmg_grp_mlt=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(-tmp03,3),2),0)
wdmh_grp_mlt=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(-tmp04,3),2),0)

grpmelt=new((/4,30/),"float")
grpmelt(0,:)=morg_grp_mlt
grpmelt(1,:)=morh_grp_mlt
grpmelt(2,:)=wdmg_grp_mlt
grpmelt(3,:)=wdmh_grp_mlt

grpmelt=grpmelt*1e5

 wks=gsn_open_wks("pdf" ,"grpmelt")
 gsn_define_colormap(wks,"ncl_default")
 
 z=fspan(0.1,18.0,30)
 z@units="km"
 
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


 resss@tiMainString      = "GRAUP_MELT"
 resss@pmLegendWidthF               = 0.03
 resss@pmLegendHeightF              = 0.2 
 resss@lgLabelFontHeightF           = .015
 resss@pmLegendSide                 = "Top"
 resss@pmLegendParallelPosF         = .4
 resss@pmLegendOrthogonalPosF       = -0.7
 resss@pmLegendDisplayMode          = "Always"

plot=gsn_csm_xy(wks,grpmelt,z,resss)
