load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011.nc","r")
f2=addfile("sensitive_1980_1991.nc","r")

var1=f1->TS(12:,:,:)
var2=f2->TS(12:,:,:)

var1_ave=dim_avg_n_Wrap(var1,0)
var2_ave=dim_avg_n_Wrap(var2,0)
diff=var1_ave-var2_ave
copy_VarMeta(var1_ave,diff)
    
res                      = True
res@cnFillOn             = True                       
res@cnLinesOn            = False             
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True              

wks  = gsn_open_wks("eps","TS_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/223,233,243,253,263,273,283,293,303,313,323/)
plot = gsn_csm_contour_map_ce(wks,var1_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TS_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/223,233,243,253,263,273,283,293,303,313,323/)
plot = gsn_csm_contour_map_ce(wks,var2_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TS_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-5,-4,-3,-2,-1,0,1,2,3,4,5/)
plot = gsn_csm_contour_map_ce(wks,diff,res)
delete(wks)



