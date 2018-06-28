load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011_seas_mean.nc","r")
f2=addfile("sensitive_1980_1991_seas_mean.nc","r")

PRECC1_spring=f1->PRECC(5::4,:,:)
PRECC2_spring=f2->PRECC(5::4,:,:)
PRECC1_summer=f1->PRECC(6::4,:,:)
PRECC2_summer=f2->PRECC(6::4,:,:)
PRECC1_autumn=f1->PRECC(7::4,:,:)
PRECC2_autumn=f2->PRECC(7::4,:,:)
PRECC1_winter=f1->PRECC(8::4,:,:)
PRECC2_winter=f2->PRECC(8::4,:,:)

PRECL1_spring=f1->PRECL(5::4,:,:)
PRECL2_spring=f2->PRECL(5::4,:,:)
PRECL1_summer=f1->PRECL(6::4,:,:)
PRECL2_summer=f2->PRECL(6::4,:,:)
PRECL1_autumn=f1->PRECL(7::4,:,:)
PRECL2_autumn=f2->PRECL(7::4,:,:)
PRECL1_winter=f1->PRECL(8::4,:,:)
PRECL2_winter=f2->PRECL(8::4,:,:)

PRECSH1_spring=f1->PRECSH(5::4,:,:)
PRECSH2_spring=f2->PRECSH(5::4,:,:)
PRECSH1_summer=f1->PRECSH(6::4,:,:)
PRECSH2_summer=f2->PRECSH(6::4,:,:)
PRECSH1_autumn=f1->PRECSH(7::4,:,:)
PRECSH2_autumn=f2->PRECSH(7::4,:,:)
PRECSH1_winter=f1->PRECSH(8::4,:,:)
PRECSH2_winter=f2->PRECSH(8::4,:,:)

PRECC1_spring_ave=dim_avg_n_Wrap(PRECC1_spring,0)*31536000.0*1000.0
copy_VarMeta(PRECC1_spring(0,:,:),PRECC1_spring_ave)
PRECC2_spring_ave=dim_avg_n_Wrap(PRECC2_spring,0)*31536000.0*1000.0
copy_VarMeta(PRECC2_spring(0,:,:),PRECC2_spring_ave)
PRECL1_spring_ave=dim_avg_n_Wrap(PRECL1_spring,0)*31536000.0*1000.0
copy_VarMeta(PRECL1_spring(0,:,:),PRECL1_spring_ave)
PRECL2_spring_ave=dim_avg_n_Wrap(PRECL2_spring,0)*31536000.0*1000.0
copy_VarMeta(PRECL2_spring(0,:,:),PRECL2_spring_ave)
PRECSH1_spring_ave=dim_avg_n_Wrap(PRECSH1_spring,0)*31536000.0*1000.0
copy_VarMeta(PRECSH1_spring(0,:,:),PRECSH1_spring_ave)
PRECSH2_spring_ave=dim_avg_n_Wrap(PRECSH2_spring,0)*31536000.0*1000.0
copy_VarMeta(PRECSH2_spring(0,:,:),PRECSH2_spring_ave)
TOTAL1_spring_ave=PRECC1_spring_ave+PRECL1_spring_ave+PRECSH1_spring_ave
copy_VarMeta(PRECSH1_spring_ave,TOTAL1_spring_ave)
TOTAL2_spring_ave=PRECC2_spring_ave+PRECL2_spring_ave+PRECSH2_spring_ave
copy_VarMeta(PRECSH2_spring_ave,TOTAL2_spring_ave)

PRECC1_summer_ave=dim_avg_n_Wrap(PRECC1_summer,0)*31536000.0*1000.0
copy_VarMeta(PRECC1_summer(0,:,:),PRECC1_summer_ave)
PRECC2_summer_ave=dim_avg_n_Wrap(PRECC2_summer,0)*31536000.0*1000.0
copy_VarMeta(PRECC2_summer(0,:,:),PRECC2_summer_ave)
PRECL1_summer_ave=dim_avg_n_Wrap(PRECL1_summer,0)*31536000.0*1000.0
copy_VarMeta(PRECL1_summer(0,:,:),PRECL1_summer_ave)
PRECL2_summer_ave=dim_avg_n_Wrap(PRECL2_summer,0)*31536000.0*1000.0
copy_VarMeta(PRECL2_summer(0,:,:),PRECL2_summer_ave)
PRECSH1_summer_ave=dim_avg_n_Wrap(PRECSH1_summer,0)*31536000.0*1000.0
copy_VarMeta(PRECSH1_summer(0,:,:),PRECSH1_summer_ave)
PRECSH2_summer_ave=dim_avg_n_Wrap(PRECSH2_summer,0)*31536000.0*1000.0
copy_VarMeta(PRECSH2_summer(0,:,:),PRECSH2_summer_ave)
TOTAL1_summer_ave=PRECC1_summer_ave+PRECL1_summer_ave+PRECSH1_summer_ave
copy_VarMeta(PRECSH1_summer_ave,TOTAL1_summer_ave)
TOTAL2_summer_ave=PRECC2_summer_ave+PRECL2_summer_ave+PRECSH2_summer_ave
copy_VarMeta(PRECSH2_summer_ave,TOTAL2_summer_ave)

PRECC1_autumn_ave=dim_avg_n_Wrap(PRECC1_autumn,0)*31536000.0*1000.0
copy_VarMeta(PRECC1_autumn(0,:,:),PRECC1_autumn_ave)
PRECC2_autumn_ave=dim_avg_n_Wrap(PRECC2_autumn,0)*31536000.0*1000.0
copy_VarMeta(PRECC2_autumn(0,:,:),PRECC2_autumn_ave)
PRECL1_autumn_ave=dim_avg_n_Wrap(PRECL1_autumn,0)*31536000.0*1000.0
copy_VarMeta(PRECL1_autumn(0,:,:),PRECL1_autumn_ave)
PRECL2_autumn_ave=dim_avg_n_Wrap(PRECL2_autumn,0)*31536000.0*1000.0
copy_VarMeta(PRECL2_autumn(0,:,:),PRECL2_autumn_ave)
PRECSH1_autumn_ave=dim_avg_n_Wrap(PRECSH1_autumn,0)*31536000.0*1000.0
copy_VarMeta(PRECSH1_autumn(0,:,:),PRECSH1_autumn_ave)
PRECSH2_autumn_ave=dim_avg_n_Wrap(PRECSH2_autumn,0)*31536000.0*1000.0
copy_VarMeta(PRECSH2_autumn(0,:,:),PRECSH2_autumn_ave)
TOTAL1_autumn_ave=PRECC1_autumn_ave+PRECL1_autumn_ave+PRECSH1_autumn_ave
copy_VarMeta(PRECSH1_autumn_ave,TOTAL1_autumn_ave)
TOTAL2_autumn_ave=PRECC2_autumn_ave+PRECL2_autumn_ave+PRECSH2_autumn_ave
copy_VarMeta(PRECSH2_autumn_ave,TOTAL2_autumn_ave)

PRECC1_winter_ave=dim_avg_n_Wrap(PRECC1_winter,0)*31536000.0*1000.0
copy_VarMeta(PRECC1_winter(0,:,:),PRECC1_winter_ave)
PRECC2_winter_ave=dim_avg_n_Wrap(PRECC2_winter,0)*31536000.0*1000.0
copy_VarMeta(PRECC2_winter(0,:,:),PRECC2_winter_ave)
PRECL1_winter_ave=dim_avg_n_Wrap(PRECL1_winter,0)*31536000.0*1000.0
copy_VarMeta(PRECL1_winter(0,:,:),PRECL1_winter_ave)
PRECL2_winter_ave=dim_avg_n_Wrap(PRECL2_winter,0)*31536000.0*1000.0
copy_VarMeta(PRECL2_winter(0,:,:),PRECL2_winter_ave)
PRECSH1_winter_ave=dim_avg_n_Wrap(PRECSH1_winter,0)*31536000.0*1000.0
copy_VarMeta(PRECSH1_winter(0,:,:),PRECSH1_winter_ave)
PRECSH2_winter_ave=dim_avg_n_Wrap(PRECSH2_winter,0)*31536000.0*1000.0
copy_VarMeta(PRECSH2_winter(0,:,:),PRECSH2_winter_ave)
TOTAL1_winter_ave=PRECC1_winter_ave+PRECL1_winter_ave+PRECSH1_winter_ave
copy_VarMeta(PRECSH1_winter_ave,TOTAL1_winter_ave)
TOTAL2_winter_ave=PRECC2_winter_ave+PRECL2_winter_ave+PRECSH2_winter_ave
copy_VarMeta(PRECSH2_winter_ave,TOTAL2_winter_ave)

PRECC_spring_diff=PRECC1_spring_ave-PRECC2_spring_ave
copy_VarMeta(PRECC1_spring_ave,PRECC_spring_diff)
PRECL_spring_diff=PRECL1_spring_ave-PRECL2_spring_ave
copy_VarMeta(PRECL1_spring_ave,PRECL_spring_diff)
PRECSH_spring_diff=PRECSH1_spring_ave-PRECSH2_spring_ave
copy_VarMeta(PRECSH1_spring_ave,PRECSH_spring_diff)
TOTAL_spring_diff=TOTAL1_spring_ave-TOTAL2_spring_ave
copy_VarMeta(TOTAL1_spring_ave,TOTAL_spring_diff)

PRECC_summer_diff=PRECC1_summer_ave-PRECC2_summer_ave
copy_VarMeta(PRECC1_summer_ave,PRECC_summer_diff)
PRECL_summer_diff=PRECL1_summer_ave-PRECL2_summer_ave
copy_VarMeta(PRECL1_summer_ave,PRECL_summer_diff)
PRECSH_summer_diff=PRECSH1_summer_ave-PRECSH2_summer_ave
copy_VarMeta(PRECSH1_summer_ave,PRECSH_summer_diff)
TOTAL_summer_diff=TOTAL1_summer_ave-TOTAL2_summer_ave
copy_VarMeta(TOTAL1_summer_ave,TOTAL_summer_diff)

PRECC_autumn_diff=PRECC1_autumn_ave-PRECC2_autumn_ave
copy_VarMeta(PRECC1_autumn_ave,PRECC_autumn_diff)
PRECL_autumn_diff=PRECL1_autumn_ave-PRECL2_autumn_ave
copy_VarMeta(PRECL1_autumn_ave,PRECL_autumn_diff)
PRECSH_autumn_diff=PRECSH1_autumn_ave-PRECSH2_autumn_ave
copy_VarMeta(PRECSH1_autumn_ave,PRECSH_autumn_diff)
TOTAL_autumn_diff=TOTAL1_autumn_ave-TOTAL2_autumn_ave
copy_VarMeta(TOTAL1_autumn_ave,TOTAL_autumn_diff)

PRECC_winter_diff=PRECC1_winter_ave-PRECC2_winter_ave
copy_VarMeta(PRECC1_winter_ave,PRECC_winter_diff)
PRECL_winter_diff=PRECL1_winter_ave-PRECL2_winter_ave
copy_VarMeta(PRECL1_winter_ave,PRECL_winter_diff)
PRECSH_winter_diff=PRECSH1_winter_ave-PRECSH2_winter_ave
copy_VarMeta(PRECSH1_winter_ave,PRECSH_winter_diff)
TOTAL_winter_diff=TOTAL1_winter_ave-TOTAL2_winter_ave
copy_VarMeta(TOTAL1_winter_ave,TOTAL_winter_diff)

res                      = True
res@cnFillOn             = True                      
res@cnLinesOn            = False             
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True              

wks  = gsn_open_wks("eps","TOTAL_spring_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,TOTAL_spring_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_spring_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,PRECC_spring_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_spring_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Large-scale (stable) precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-100,-80,-60,-40,-20,0,20,40,60,80,100/)
plot = gsn_csm_contour_map_ce(wks,PRECL_spring_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_spring_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Shallow Convection precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,PRECSH_spring_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_spring_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL1_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_spring_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL2_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_spring_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC1_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_spring_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC2_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_spring_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL1_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_spring_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL2_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_spring_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH1_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_spring_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH2_spring_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_summer_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,TOTAL_summer_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_summer_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,PRECC_summer_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_summer_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Large-scale (stable) precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-100,-80,-60,-40,-20,0,20,40,60,80,100/)
plot = gsn_csm_contour_map_ce(wks,PRECL_summer_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_summer_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Shallow Convection precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,PRECSH_summer_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_summer_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL1_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_summer_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL2_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_summer_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC1_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_summer_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC2_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_summer_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL1_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_summer_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL2_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_summer_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH1_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_summer_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH2_summer_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_autumn_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,TOTAL_autumn_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_autumn_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,PRECC_autumn_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_autumn_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Large-scale (stable) precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-100,-80,-60,-40,-20,0,20,40,60,80,100/)
plot = gsn_csm_contour_map_ce(wks,PRECL_autumn_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_autumn_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Shallow Convection precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,PRECSH_autumn_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_autumn_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL1_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_autumn_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL2_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_autumn_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC1_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_autumn_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC2_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_autumn_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL1_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_autumn_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL2_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_autumn_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH1_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_autumn_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH2_autumn_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_winter_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,TOTAL_winter_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_winter_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-500,-400,-300,-200,-100,0,100,200,300,400,500/)
plot = gsn_csm_contour_map_ce(wks,PRECC_winter_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_winter_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Large-scale (stable) precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-100,-80,-60,-40,-20,0,20,40,60,80,100/)
plot = gsn_csm_contour_map_ce(wks,PRECL_winter_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_winter_Diff")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Shallow Convection precipitation"
res@gsnRightString="mm"
res@cnLevels=(/-50,-40,-30,-20,-10,0,10,20,30,40,50/)
plot = gsn_csm_contour_map_ce(wks,PRECSH_winter_diff,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_winter_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL1_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","TOTAL_winter_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Total precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,TOTAL2_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_winter_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC1_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECC_winter_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECC2_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_winter_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL1_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECL_winter_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECL2_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_winter_SEN1")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH1_winter_ave,res)
delete(wks)

wks  = gsn_open_wks("eps","PRECSH_winter_SEN2")      
gsn_define_colormap(wks,"cmp_b2r")   
res@gsnLeftString="Convective precipitation"
res@gsnRightString="mm"
res@cnLevels=(/0,400,800,1200,1600,2000,2400,2800,3200,3600,4000/)
plot = gsn_csm_contour_map_ce(wks,PRECSH2_winter_ave,res)
delete(wks)