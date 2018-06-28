load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011_seas_mean.nc","r")
f2=addfile("sensitive_1980_1991_seas_mean.nc","r")

Z1_spring=f1->Z3(5::4,:,:,:)
Z2_spring=f2->Z3(5::4,:,:,:)

Z1_summer=f1->Z3(6::4,:,:,:)
Z2_summer=f2->Z3(6::4,:,:,:)

Z1_autumn=f1->Z3(7::4,:,:,:)
Z2_autumn=f2->Z3(7::4,:,:,:)

Z1_winter=f1->Z3(8::4,:,:,:)
Z2_winter=f2->Z3(8::4,:,:,:)

hbcofa1=f1->hyai
hbcofb1=f1->hybi
hbcofa2=f2->hyai
hbcofb2=f2->hybi

plevo=(/500,200/)

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

Z1_p_spring = vinth2p(Z1_spring,hbcofa1,hbcofb1,plevo,psfc1_spring,intyp,p0,ii,kxtrp)/10.0
Z2_p_spring = vinth2p(Z2_spring,hbcofa2,hbcofb2,plevo,psfc2_spring,intyp,p0,ii,kxtrp)/10.0
copy_VarMeta(Z1_spring(:,0:1,:,:),Z1_p_spring)
copy_VarMeta(Z2_spring(:,0:1,:,:),Z2_p_spring)

Z1_p_spring_ave=dim_avg_n_Wrap(Z1_p_spring,0)
Z2_p_spring_ave=dim_avg_n_Wrap(Z2_p_spring,0)
Z_spring_diff=Z1_p_spring_ave-Z2_p_spring_ave
copy_VarMeta(Z1_p_spring_ave,Z_spring_diff)

Z1_p_summer = vinth2p(Z1_summer,hbcofa1,hbcofb1,plevo,psfc1_summer,intyp,p0,ii,kxtrp)/10.0
Z2_p_summer = vinth2p(Z2_summer,hbcofa2,hbcofb2,plevo,psfc2_summer,intyp,p0,ii,kxtrp)/10.0
copy_VarMeta(Z1_summer(:,0:1,:,:),Z1_p_summer)
copy_VarMeta(Z2_summer(:,0:1,:,:),Z2_p_summer)

Z1_p_summer_ave=dim_avg_n_Wrap(Z1_p_summer,0)
Z2_p_summer_ave=dim_avg_n_Wrap(Z2_p_summer,0)
Z_summer_diff=Z1_p_summer_ave-Z2_p_summer_ave
copy_VarMeta(Z1_p_summer_ave,Z_summer_diff)

Z1_p_autumn = vinth2p(Z1_autumn,hbcofa1,hbcofb1,plevo,psfc1_autumn,intyp,p0,ii,kxtrp)/10.0
Z2_p_autumn = vinth2p(Z2_autumn,hbcofa2,hbcofb2,plevo,psfc2_autumn,intyp,p0,ii,kxtrp)/10.0
copy_VarMeta(Z1_autumn(:,0:1,:,:),Z1_p_autumn)
copy_VarMeta(Z2_autumn(:,0:1,:,:),Z2_p_autumn)

Z1_p_autumn_ave=dim_avg_n_Wrap(Z1_p_autumn,0)
Z2_p_autumn_ave=dim_avg_n_Wrap(Z2_p_autumn,0)
Z_autumn_diff=Z1_p_autumn_ave-Z2_p_autumn_ave
copy_VarMeta(Z1_p_autumn_ave,Z_autumn_diff)

Z1_p_winter = vinth2p(Z1_winter,hbcofa1,hbcofb1,plevo,psfc1_winter,intyp,p0,ii,kxtrp)/10.0
Z2_p_winter = vinth2p(Z2_winter,hbcofa2,hbcofb2,plevo,psfc2_winter,intyp,p0,ii,kxtrp)/10.0
copy_VarMeta(Z1_winter(:,0:1,:,:),Z1_p_winter)
copy_VarMeta(Z2_winter(:,0:1,:,:),Z2_p_winter)

Z1_p_winter_ave=dim_avg_n_Wrap(Z1_p_winter,0)
Z2_p_winter_ave=dim_avg_n_Wrap(Z2_p_winter,0)
Z_winter_diff=Z1_p_winter_ave-Z2_p_winter_ave
copy_VarMeta(Z1_p_winter_ave,Z_winter_diff)

res                      = True
res@cnFillOn             = True                      
res@cnLinesOn            = False        
res@gsnLeftString="Geopotential height"
res@gsnRightString="gpm"
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True    

wks  = gsn_open_wks("eps","Z_SEN1_spring_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_spring_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_spring_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_spring_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_spring_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_spring_diff(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_spring_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_spring_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_spring_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_spring_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_spring_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_spring_diff(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_summer_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_summer_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_summer_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_summer_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_summer_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_summer_diff(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_summer_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_summer_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_summer_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_summer_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_summer_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_summer_diff(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_autumn_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_autumn_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_autumn_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_autumn_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_autumn_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_autumn_diff(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_autumn_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_autumn_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_autumn_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_autumn_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_autumn_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_autumn_diff(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_winter_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_winter_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_winter_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_winter_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_winter_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_winter_diff(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_winter_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_winter_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_winter_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_winter_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_winter_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_winter_diff(1,:,:),res)
delete(wks)