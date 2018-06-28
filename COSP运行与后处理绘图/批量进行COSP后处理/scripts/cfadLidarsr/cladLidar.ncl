load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

cldfilenamelist=systemfunc("ls cosp/cfadLidarsr532_*.nc")
cldfile=addfiles(cldfilenamelist, "r")
ListSetType(cldfile,"cat")     
tmp=dim_avg_n_Wrap(dim_avg_n_Wrap(cldfile[:]->cfadLidarsr532, 3), 0)
cfadLidarsr532=tmp*100.0
copy_VarMeta(tmp,cfadLidarsr532)
delete(tmp)

alt40=cldfile[0]->alt40
scatratio=cldfile[0]->scatratio
alt40_bnds=cldfile[0]->alt40_bnds
scatratio_bnds=cldfile[0]->scatratio_bnds

nscatratio=dimsizes(scatratio)+1
XVALUE=new(nscatratio,"float")
XVALUE(nscatratio-1)=100
XVALUE(0:nscatratio-2)=doubletofloat(scatratio_bnds(:,0))

nalt40=dimsizes(alt40)+1
YVALUE=new(nalt40,"float")
YVALUE(0)=19200
YVALUE(1:nalt40-1)=doubletofloat(alt40_bnds(::-1,0))
YVALUE=YVALUE/1000.0

res                      = True
res@cnFillOn             = True
res@cnLinesOn            = False
res@cnLineLabelsOn       = False  
res@gsnSpreadColors      = True
res@gsnLeftString        = "mean"
res@gsnRightString       = ""
res@tiMainString         = cfadLidarsr532@long_name
res@cnFillMode           = "RasterFill"
res@tmXBMinorOn          = False
res@trYReverse           = True  
res@cnLevelSpacingF      = 1.0
res@tmXBMode             = "Explicit"                
res@tmXBValues           = ispan(1,nscatratio,1)
res@tmXBLabels           = XVALUE
res@sfXArray             = res@tmXBValues    
res@tmYLMode             = "Explicit"               
res@tmYLValues           = ispan(1,nalt40,1)
res@tmYLLabels           = YVALUE
res@tmYLLabelFontHeightF = 0.01
res@sfYArray             = res@tmYLValues    
res@lbOrientation        = "vertical"
res@tiXAxisString        = scatratio@long_name    
res@tiYAxisString        = alt40@long_name+ " [km]"
res@cnLevelSelectionMode        = "ExplicitLevels"
res@cnLevels    = fspan(1,6,6)

wks = gsn_open_wks("eps", "cfadLidarsr532_mean")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour(wks, cfadLidarsr532(alt40|:,scatratio|:), res)


