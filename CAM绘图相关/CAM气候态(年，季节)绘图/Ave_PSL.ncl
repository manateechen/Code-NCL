load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011.nc","r")
f2=addfile("sensitive_1980_1991.nc","r")

var1=f1->PSL(12:,:,:)
var2=f2->PSL(12:,:,:)

var1_ave=dim_avg_n_Wrap(var1,0)/100.0
var2_ave=dim_avg_n_Wrap(var2,0)/100.0
diff=var1_ave-var2_ave
copy_VarMeta(var1(0,:,:),var1_ave)
copy_VarMeta(var1(0,:,:),var2_ave)
copy_VarMeta(var1(0,:,:),diff)
    
res                      = True
res@cnFillOn             = True                      
res@cnLinesOn            = False             
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True    
res@gsnRightString="hPa"

wks  = gsn_open_wks("eps","PSL_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var1_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var2_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-200,-160,-120,-80,-40,0,40,80,120,160,200/)
plot = gsn_csm_contour_map_ce(wks,diff,res)
delete(wks)



