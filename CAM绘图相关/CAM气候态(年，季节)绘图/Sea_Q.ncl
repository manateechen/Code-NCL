load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011_seas_mean.nc","r")
f2=addfile("sensitive_1980_1991_seas_mean.nc","r")

Q1_spring=f1->Q(5::4,:,:,:)
Q2_spring=f2->Q(5::4,:,:,:)

Q1_summer=f1->Q(6::4,:,:,:)
Q2_summer=f2->Q(6::4,:,:,:)

Q1_autumn=f1->Q(7::4,:,:,:)
Q2_autumn=f2->Q(7::4,:,:,:)

Q1_winter=f1->Q(8::4,:,:,:)
Q2_winter=f2->Q(8::4,:,:,:)

hbcofa1=f1->hyai
hbcofb1=f1->hybi
hbcofa2=f2->hyai
hbcofb2=f2->hybi

plevo=(/1000,950,900,850,700/)

psfc1_spring=f1->PS(5::4,:,:)
psfc2_spring=f2->PS(5::4,:,:)

psfc1_summer=f1->PS(6::4,:,:)
psfc2_summer=f2->PS(6::4,:,:)

psfc1_autumn=f1->PS(7::4,:,:)
psfc2_autumn=f2->PS(7::4,:,:)

psfc1_winter=f1->PS(8::4,:,:)
psfc2_winter=f2->PS(8::4,:,:)

intyp=3

p0=1000.0

ii=1

kxtrp=False

Q1_p_spring = vinth2p(Q1_spring,hbcofa1,hbcofb1,plevo,psfc1_spring,intyp,p0,ii,kxtrp)*1000.0
Q2_p_spring = vinth2p(Q2_spring,hbcofa2,hbcofb2,plevo,psfc2_spring,intyp,p0,ii,kxtrp)*1000.0
copy_VarMeta(Q1_spring(:,0:4,:,:),Q1_p_spring)
copy_VarMeta(Q2_spring(:,0:4,:,:),Q2_p_spring)

Q1_p_spring_ave=dim_avg_n_Wrap(Q1_p_spring,0)
Q2_p_spring_ave=dim_avg_n_Wrap(Q2_p_spring,0)
Q_spring_diff=Q1_p_spring_ave-Q2_p_spring_ave
copy_VarMeta(Q1_p_spring_ave,Q_spring_diff)

Q1_p_summer = vinth2p(Q1_summer,hbcofa1,hbcofb1,plevo,psfc1_summer,intyp,p0,ii,kxtrp)*1000.0
Q2_p_summer = vinth2p(Q2_summer,hbcofa2,hbcofb2,plevo,psfc2_summer,intyp,p0,ii,kxtrp)*1000.0
copy_VarMeta(Q1_summer(:,0:4,:,:),Q1_p_summer)
copy_VarMeta(Q2_summer(:,0:4,:,:),Q2_p_summer)

Q1_p_summer_ave=dim_avg_n_Wrap(Q1_p_summer,0)
Q2_p_summer_ave=dim_avg_n_Wrap(Q2_p_summer,0)
Q_summer_diff=Q1_p_summer_ave-Q2_p_summer_ave
copy_VarMeta(Q1_p_summer_ave,Q_summer_diff)

Q1_p_autumn = vinth2p(Q1_autumn,hbcofa1,hbcofb1,plevo,psfc1_autumn,intyp,p0,ii,kxtrp)*1000.0
Q2_p_autumn = vinth2p(Q2_autumn,hbcofa2,hbcofb2,plevo,psfc2_autumn,intyp,p0,ii,kxtrp)*1000.0
copy_VarMeta(Q1_autumn(:,0:4,:,:),Q1_p_autumn)
copy_VarMeta(Q2_autumn(:,0:4,:,:),Q2_p_autumn)

Q1_p_autumn_ave=dim_avg_n_Wrap(Q1_p_autumn,0)
Q2_p_autumn_ave=dim_avg_n_Wrap(Q2_p_autumn,0)
Q_autumn_diff=Q1_p_autumn_ave-Q2_p_autumn_ave
copy_VarMeta(Q1_p_autumn_ave,Q_autumn_diff)

Q1_p_winter = vinth2p(Q1_winter,hbcofa1,hbcofb1,plevo,psfc1_winter,intyp,p0,ii,kxtrp)*1000.0
Q2_p_winter = vinth2p(Q2_winter,hbcofa2,hbcofb2,plevo,psfc2_winter,intyp,p0,ii,kxtrp)*1000.0
copy_VarMeta(Q1_winter(:,0:4,:,:),Q1_p_winter)
copy_VarMeta(Q2_winter(:,0:4,:,:),Q2_p_winter)

Q1_p_winter_ave=dim_avg_n_Wrap(Q1_p_winter,0)
Q2_p_winter_ave=dim_avg_n_Wrap(Q2_p_winter,0)
Q_winter_diff=Q1_p_winter_ave-Q2_p_winter_ave
copy_VarMeta(Q1_p_winter_ave,Q_winter_diff)

res                      = True
res@cnFillOn             = True                      
res@cnLinesOn            = False        
res@gsnLeftString="Specific humidity"
res@gsnRightString="g/Kg"
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True    

wks  = gsn_open_wks("eps","Q_SEN1_spring_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q1_p_spring_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN2_spring_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q2_p_spring_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_Diff_summer_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-0.6,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6/)
plot = gsn_csm_contour_map_ce(wks,Q_summer_diff(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN1_summer_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q1_p_summer_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN2_summer_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q2_p_summer_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_Diff_summer_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-0.6,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6/)
plot = gsn_csm_contour_map_ce(wks,Q_summer_diff(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN1_autumn_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q1_p_autumn_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN2_autumn_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q2_p_autumn_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_Diff_autumn_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-0.6,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6/)
plot = gsn_csm_contour_map_ce(wks,Q_autumn_diff(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN1_winter_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q1_p_winter_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN2_winter_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q2_p_winter_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_Diff_winter_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-0.6,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6/)
plot = gsn_csm_contour_map_ce(wks,Q_winter_diff(3,:,:),res)
delete(wks)