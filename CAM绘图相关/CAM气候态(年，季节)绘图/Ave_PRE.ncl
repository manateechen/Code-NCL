load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011.nc","r")
f2=addfile("sensitive_1980_1991.nc","r")

PRECC1=f1->PRECC(12:,:,:)
PRECC2=f2->PRECC(12:,:,:)
PRECL1=f1->PRECL(12:,:,:)
PRECL2=f2->PRECL(12:,:,:)
PRECSH1=f1->PRECSH(12:,:,:)
PRECSH2=f2->PRECSH(12:,:,:)

PRECC1_ave=dim_avg_n_Wrap(PRECC1,0)*31536000.0*1000.0
copy_VarMeta(PRECC1(0,:,:),PRECC1_ave)
PRECC2_ave=dim_avg_n_Wrap(PRECC2,0)*31536000.0*1000.0
copy_VarMeta(PRECC2(0,:,:),PRECC2_ave)
PRECL1_ave=dim_avg_n_Wrap(PRECL1,0)*31536000.0*1000.0
copy_VarMeta(PRECL1(0,:,:),PRECL1_ave)
PRECL2_ave=dim_avg_n_Wrap(PRECL2,0)*31536000.0*1000.0
copy_VarMeta(PRECL2(0,:,:),PRECL2_ave)
PRECSH1_ave=dim_avg_n_Wrap(PRECSH1,0)*31536000.0*1000.0
copy_VarMeta(PRECSH1(0,:,:),PRECSH1_ave)
PRECSH2_ave=dim_avg_n_Wrap(PRECSH2,0)*31536000.0*1000.0
copy_VarMeta(PRECSH2(0,:,:),PRECSH2_ave)

TOTAL1=PRECC1_ave+PRECL1_ave+PRECSH1_ave
copy_VarMeta(PRECSH1_ave,TOTAL1)
TOTAL2=PRECC2_ave+PRECL2_ave+PRECSH2_ave
copy_VarMeta(PRECSH2_ave,TOTAL2)
PRECC_diff=PRECC1_ave-PRECC2_ave
copy_VarMeta(PRECC1_ave,PRECC_diff)
PRECL_diff=PRECL1_ave-PRECL2_ave
copy_VarMeta(PRECL1_ave,PRECL_diff)
PRECSH_diff=PRECSH1_ave-PRECSH2_ave
copy_VarMeta(PRECSH1_ave,PRECSH_diff)
TOTAL_diff=TOTAL1-TOTAL2
copy_VarMeta(PRECSH1_ave,TOTAL_diff)
    
res                      = True
res@cnFillOn             = True                      
res@cnLinesOn            = False             
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True              

wks  = gsn_open_wks("eps","TOTAL_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,TOTAL_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,PRECC_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Large-scale (stable) precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-100,-80,-60,-40,-20,0,20,40,60,80,100/)
plot = gsn_csm_contour_map_ce(wks,PRECL_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Shallow Convection precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,PRECSH_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL1,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL2,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC1_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC2_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Large-scale (stable) precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,30,60,90,120,150,180,210,240,270,300/)
plot = gsn_csm_contour_map_ce(wks,PRECL1_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Large-scale (stable) precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,30,60,90,120,150,180,210,240,270,300/)
plot = gsn_csm_contour_map_ce(wks,PRECL2_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Shallow Convection precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,30,60,90,120,150,180,210,240,270,300/)
plot = gsn_csm_contour_map_ce(wks,PRECSH1_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Shallow Convection precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,30,60,90,120,150,180,210,240,270,300/)
plot = gsn_csm_contour_map_ce(wks,PRECSH1_ave,res)
delete(wks)