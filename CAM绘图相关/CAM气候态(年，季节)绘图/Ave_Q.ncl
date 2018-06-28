load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011.nc","r")
f2=addfile("sensitive_1980_1991.nc","r")

Q1=f1->Q(12:,:,:,:)
Q2=f2->Q(12:,:,:,:)

hbcofa1=f1->hyai
hbcofb1=f1->hybi
hbcofa2=f2->hyai
hbcofb2=f2->hybi

plevo=(/1000,950,900,850,700/)

psfc1=f1->PS(12:,:,:)
psfc2=f2->PS(12:,:,:)

intyp=3

p0=1000.0

ii=1

kxtrp=False

Q1_p = vinth2p(Q1,hbcofa1,hbcofb1,plevo,psfc1,intyp,p0,ii,kxtrp)*1000.0
Q2_p = vinth2p(Q2,hbcofa2,hbcofb2,plevo,psfc2,intyp,p0,ii,kxtrp)*1000.0
copy_VarMeta(Q1(:,0:4,:,:),Q1_p)
copy_VarMeta(Q2(:,0:4,:,:),Q2_p)

Q1_p_ave=dim_avg_n_Wrap(Q1_p,0)
Q2_p_ave=dim_avg_n_Wrap(Q2_p,0)
Q_diff=Q1_p_ave-Q2_p_ave
copy_VarMeta(Q1_p_ave,Q_diff)

res                      = True
res@cnFillOn             = True                      
res@cnLinesOn            = False        
res@gsnLeftString="Specific humidity"
res@gsnRightString="g/Kg"
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True    

wks  = gsn_open_wks("eps","Q_SEN1_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q1_p_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_SEN2_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0/)
plot = gsn_csm_contour_map_ce(wks,Q2_p_ave(3,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Q_Diff_850")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-0.6,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6/)
plot = gsn_csm_contour_map_ce(wks,Q_diff(3,:,:),res)
delete(wks)