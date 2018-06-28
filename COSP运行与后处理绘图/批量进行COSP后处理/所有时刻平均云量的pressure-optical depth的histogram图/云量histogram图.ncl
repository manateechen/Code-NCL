load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

cldfilenamelist=systemfunc("ls wrfout*/clisccp_1D_HadGEM2-ES_amip_r1i1p1_200801020000-200801020000.nc")
cldfile=addfiles(cldfilenamelist, "r")
ListSetType(cldfile,"cat")     
clisccp=dim_avg_n_Wrap(dim_avg_n_Wrap(cldfile[:]->clisccp, 3), 0)
plev=cldfile[0]->plev
tau=cldfile[0]->tau 
plev_bnds=cldfile[0]->plev_bnds
tau_bnds=cldfile[0]->tau_bnds
ntau=dimsizes(tau)+1
XVALUE=new(ntau,"float")
XVALUE(7)=100
XVALUE(0:6)=doubletofloat(tau_bnds(:,0)) 
YVALUE=new(ntau,"float")
YVALUE(7)=0
YVALUE(0:6)=doubletofloat(plev_bnds(:,0))/100

res                      = True
res@cnFillOn             = True
res@cnLinesOn            = False
res@cnLineLabelsOn       = False  
res@gsnSpreadColors      = True
res@gsnLeftString        = ""
res@gsnRightString       = ""
res@tiMainString         = clisccp@long_name
res@cnFillMode           = "RasterFill"
res@tmXBMinorOn          = False
res@trYReverse           = True  
res@cnLevelSpacingF      = 1.0
res@tmXBMode             = "Explicit"                
res@tmXBValues           = XVALUE
res@tmXBLabels           = XVALUE
res@sfXArray             = res@tmXBValues    
res@tmYLMode             = "Explicit"               
res@tmYLValues           = YVALUE
res@tmYLLabels           = YVALUE
res@sfYArray             = res@tmYLValues    
res@lbOrientation        = "vertical"
res@tiXAxisString        = tau@long_name    
res@tiYAxisString        = plev@long_name+ " [hPa]"

wks = gsn_open_wks("eps", "clisccp")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour(wks, clisccp, res)

