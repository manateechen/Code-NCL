load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011_seas_mean.nc","r")
f2=addfile("sensitive_1980_1991_seas_mean.nc","r")

var1_spring=f1->PSL(5::4,:,:)
var2_spring=f2->PSL(5::4,:,:)

var1_summer=f1->PSL(6::4,:,:)
var2_summer=f2->PSL(6::4,:,:)

var1_autumn=f1->PSL(7::4,:,:)
var2_autumn=f2->PSL(7::4,:,:)

var1_winter=f1->PSL(8::4,:,:)
var2_winter=f2->PSL(8::4,:,:)

var1_spring_ave=dim_avg_n_Wrap(var1_spring,0)/100.0
var2_spring_ave=dim_avg_n_Wrap(var2_spring,0)/100.0
var_diff_spring=var1_spring_ave-var2_spring_ave
copy_VarMeta(var1_spring(0,:,:),var1_spring_ave)
copy_VarMeta(var2_spring(0,:,:),var2_spring_ave)
copy_VarMeta(var1_spring_ave,var_diff_spring)

var1_summer_ave=dim_avg_n_Wrap(var1_summer,0)/100.0
var2_summer_ave=dim_avg_n_Wrap(var2_summer,0)/100.0
var_diff_summer=var1_summer_ave-var2_summer_ave
copy_VarMeta(var1_summer(0,:,:),var1_summer_ave)
copy_VarMeta(var2_summer(0,:,:),var2_summer_ave)
copy_VarMeta(var1_summer_ave,var_diff_summer)

var1_autumn_ave=dim_avg_n_Wrap(var1_autumn,0)/100.0
var2_autumn_ave=dim_avg_n_Wrap(var2_autumn,0)/100.0
var_diff_autumn=var1_autumn_ave-var2_autumn_ave
copy_VarMeta(var1_autumn(0,:,:),var1_autumn_ave)
copy_VarMeta(var2_autumn(0,:,:),var2_autumn_ave)
copy_VarMeta(var1_autumn_ave,var_diff_autumn)

var1_winter_ave=dim_avg_n_Wrap(var1_winter,0)/100.0
var2_winter_ave=dim_avg_n_Wrap(var2_winter,0)/100.0
var_diff_winter=var1_winter_ave-var2_winter_ave
copy_VarMeta(var1_winter(0,:,:),var1_winter_ave)
copy_VarMeta(var2_winter(0,:,:),var2_winter_ave)
copy_VarMeta(var1_winter_ave,var_diff_winter)

res                      = True
res@cnFillOn             = True                       
res@cnLinesOn            = False             
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True              

wks  = gsn_open_wks("eps","PSL_SEN1_Spring")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var1_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN2_Spring")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var2_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_Diff_Spring")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,var_diff_spring,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN1_Summer")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var1_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN2_Summer")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var2_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_Diff_Summer")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,var_diff_summer,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN1_Autumn")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var1_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN2_Autumn")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var2_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_Diff_Autumn")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,var_diff_autumn,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN1_Winter")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var1_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_SEN2_Winter")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/972,976,980,984,992,1000,1008,1016,1024,1028,1032/)
plot = gsn_csm_contour_map_ce(wks,var2_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PSL_Diff_Winter")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,var_diff_winter,res)
delete(wks)