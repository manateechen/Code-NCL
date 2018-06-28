load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

f1=addfile("AnaPre.nc","r")
climate=f1->climate_pre
case01=f1->case01_pre
case02=f1->case02_pre
case03=f1->case03_pre
case04=f1->case04_pre
case05=f1->case05_pre
case06=f1->case06_pre
case07=f1->case07_pre
case08=f1->case08_pre
case09=f1->case09_pre
case10=f1->case10_pre
case11=f1->case11_pre
case13=f1->case13_pre
case14=f1->case14_pre
era_pre=f1->era_pre
ensemble_pre=f1->ensemble

cli=dim_avg_n(dim_avg_n_Wrap(climate,2),1)
era=dim_avg_n(dim_avg_n_Wrap(era_pre,2),1)
ensemble=dim_avg_n(dim_avg_n_Wrap(ensemble_pre,2),1)
c01=dim_avg_n(dim_avg_n_Wrap(case01,2),1)
c02=dim_avg_n(dim_avg_n_Wrap(case02,2),1)
c03=dim_avg_n(dim_avg_n_Wrap(case03,2),1)
c04=dim_avg_n(dim_avg_n_Wrap(case04,2),1)
c05=dim_avg_n(dim_avg_n_Wrap(case05,2),1)
c06=dim_avg_n(dim_avg_n_Wrap(case06,2),1)
c07=dim_avg_n(dim_avg_n_Wrap(case07,2),1)
c08=dim_avg_n(dim_avg_n_Wrap(case08,2),1)
c09=dim_avg_n(dim_avg_n_Wrap(case09,2),1)
c10=dim_avg_n(dim_avg_n_Wrap(case10,2),1)
c11=dim_avg_n(dim_avg_n_Wrap(case11,2),1)
c13=dim_avg_n(dim_avg_n_Wrap(case13,2),1)
c14=dim_avg_n(dim_avg_n_Wrap(case14,2),1)

data=new((/16,7/),"float")
data(0,:)=c01
data(1,:)=c02
data(2,:)=c03
data(3,:)=c04
data(4,:)=c05
data(5,:)=c06
data(6,:)=c07
data(7,:)=c08
data(8,:)=c09
data(9,:)=c10
data(10,:)=c11
data(11,:)=c13
data(12,:)=c14
data(13,:)=cli
data(14,:)=era
data(15,:)=ensemble

print(data(5,:))
xxx=(/1,2,3,4,5,6,7/)
res=True
res@gsnMaximize=True
res@vpWidthF=0.7
res@vpHeightF=0.25
res@pmLegendOrthogonalPosF = -1.17
  res@pmLegendParallelPosF   = 0.08
  res@pmLegendDisplayMode    = "Always"
  res@pmLegendWidthF         = 0.1
  res@pmLegendHeightF        = 0.1
  res@xyExplicitLegendLabels = (/"case01","case02","case03","case04","case05","case06","case07","case08","case09","case10","case11","case12","case13","OBS","ERA","Ensemble"/)
res@xyLineColors=(/200,2,24,38,59,71,86,108,119,134,155,168,184,1,216,230/) 
wks = gsn_open_wks("eps","time")
gsn_define_colormap(wks,"ncl_default")
plot = gsn_csm_xy(wks,xxx,data,res)