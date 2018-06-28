load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

datafile=addfile("pre_monthly.nc","r")

pre=datafile->pre

ave=dim_avg_n_Wrap(dim_avg_n_Wrap(pre,2),1)

printVarSummary(ave)

pdfcurve=pdfx(ave,30,False)

printVarSummary(pdfcurve)

wks = gsn_open_wks("eps" ,"PDF_Pre")    
res=True
res@xyLineThicknessF=2
res@tiYAxisString="PDF (%)"
res@tiMainString="PDF of mean daily precipitation"
res@gsnMaximize=True

plot=gsn_csm_xy(wks,pdfcurve@bin_center,pdfcurve,res)


