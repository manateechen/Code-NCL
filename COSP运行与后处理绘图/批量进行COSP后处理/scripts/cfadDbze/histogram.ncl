load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

cldfilenamelist=systemfunc("ls cosp/cfadDbze94_*.nc")
cldfile=addfiles(cldfilenamelist, "r")
ListSetType(cldfile,"cat")     
tmp=dim_avg_n_Wrap(dim_avg_n_Wrap(cldfile[:]->cfadDbze94, 3), 0)
cfadDbze94=tmp*100.0
copy_VarMeta(tmp,cfadDbze94)
delete(tmp)
alt40=cldfile[0]->alt40
dbze=cldfile[0]->dbze
alt40_bnds=cldfile[0]->alt40_bnds
dbze_bnds=cldfile[0]->dbze_bnds

ndbze=dimsizes(dbze)+1
XVALUE=new(ndbze,"float")
XVALUE(ndbze-1)=25
XVALUE(0:ndbze-2)=doubletofloat(dbze_bnds(:,0))

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
res@tiMainString         = cfadDbze94@long_name
res@cnFillMode           = "RasterFill"
res@tmXBMinorOn          = False
res@trYReverse           = True  
res@cnLevelSpacingF      = 1.0
res@tmXBMode             = "Explicit"                
res@tmXBValues           = ispan(1,ndbze,1)
res@tmXBLabels           = XVALUE
res@sfXArray             = res@tmXBValues    
res@tmYLMode             = "Explicit"               
res@tmYLValues           = ispan(1,nalt40,1)
res@tmYLLabels           = YVALUE
res@tmYLLabelFontHeightF = 0.01
res@sfYArray             = res@tmYLValues    
res@lbOrientation        = "vertical"
res@tiXAxisString        = dbze@long_name    
res@tiYAxisString        = alt40@long_name+ " [km]"
res@cnLevelSelectionMode        = "ExplicitLevels"
res@cnLevels    = fspan(1,6,6)

wks = gsn_open_wks("eps", "cfadDbze94_mean")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour(wks, cfadDbze94(alt40|:,dbze|:), res)


