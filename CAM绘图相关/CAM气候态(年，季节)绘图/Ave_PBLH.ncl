load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011.nc","r")
f2=addfile("sensitive_1980_1991.nc","r")

var1=f1->PBLH(12:,:,:)
var2=f2->PBLH(12:,:,:)

var1_ave=dim_avg_n_Wrap(var1,0)
var2_ave=dim_avg_n_Wrap(var2,0)
diff=var1_ave-var2_ave
copy_VarMeta(var1_ave,diff)
    
res                      = True
res@cnFillOn             = True                       
res@cnLinesOn            = False             
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True              

wks  = gsn_open_wks("eps","PBLH_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800/)
plot = gsn_csm_contour_map_ce(wks,var1_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PBLH_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800/)
plot = gsn_csm_contour_map_ce(wks,var2_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PBLH_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-80,-70,-60,-50,-40,-30,-20,-10,0,10,20,30,40,50,60,70,80/)
plot = gsn_csm_contour_map_ce(wks,diff,res)
delete(wks)



