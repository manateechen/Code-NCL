load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

fileqv=addfile("QVS_VT.nc","r")

vt=fileqv->vt
qvqvs=fileqv->qvqvs

do ii=0,39
qvqvs(:,ii,:,:)=where(vt(:,ii,:,:).gt.0.0,qvqvs(:,ii,:,:),qvqvs@_FillValue)
end do
tmp=dim_avg_n_Wrap(dim_avg_n_Wrap(dim_avg_n_Wrap(qvqvs,3),2),0)

wks=gsn_open_wks("pdf" ,"qvqvs")
gsn_define_colormap(wks,"ncl_default")

z=fspan(1.0,7.0,40)
z@units="km"

resss=True
resss@gsnFrame           = False
resss@vpHeightF          = 0.7
resss@vpWidthF           = 0.35
resss@tiMainFontHeightF  = 0.018
resss@tiXAxisFontHeightF = 0.018
resss@tiYAxisFontHeightF = 0.018
resss@xyLineThicknessF   = 2.0
;resss@xyLineColors=(/"red","black","orange","blue"/)
;resss@xyExplicitLegendLabels = (/"MOR_GRAUP","MOR_HAIL","WDM_GRAUP","WDM_HAIL"/)
resss@tiXAxisString=""
resss@tiYAxisString="km"
resss@vpXF              = 0.6
resss@vpYF              = 0.85
resss@tiMainString      = "Fall Speed"
resss@pmLegendWidthF               = 0.03
resss@pmLegendHeightF              = 0.2
resss@lgLabelFontHeightF           = .015
resss@pmLegendSide                 = "Top"
resss@pmLegendParallelPosF         = .75
resss@pmLegendOrthogonalPosF       = -0.4
resss@pmLegendDisplayMode          = "Always"

plot=gsn_csm_xy(wks,tmp,z,resss)

