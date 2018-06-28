load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   

f1=addfile("sensitive_2000_2011.nc","r")
f2=addfile("sensitive_1980_1991.nc","r")

Z1=f1->Z3(12:,:,:,:)
Z2=f2->Z3(12:,:,:,:)

hbcofa1=f1->hyai
hbcofb1=f1->hybi
hbcofa2=f2->hyai
hbcofb2=f2->hybi

plevo=(/500,200/)

psfc1=f1->PS(12:,:,:)
psfc2=f2->PS(12:,:,:)

intyp=3

p0=1000.0

ii=1

kxtrp=False

Z1_p = vinth2p(Z1,hbcofa1,hbcofb1,plevo,psfc1,intyp,p0,ii,kxtrp)/10.0
Z2_p = vinth2p(Z2,hbcofa2,hbcofb2,plevo,psfc2,intyp,p0,ii,kxtrp)/10.0
copy_VarMeta(Z1(:,0:1,:,:),Z1_p)
copy_VarMeta(Z2(:,0:1,:,:),Z2_p)

Z1_p_ave=dim_avg_n_Wrap(Z1_p,0)
Z2_p_ave=dim_avg_n_Wrap(Z2_p,0)
Z_diff=Z1_p_ave-Z2_p_ave
copy_VarMeta(Z1_p_ave,Z_diff)

res                      = True
res@cnFillOn             = True                      
res@cnLinesOn            = False        
res@gsnLeftString="Geopotential height"
res@gsnRightString="gpm"
res@cnLevelSelectionMode="ExplicitLevels"
res@gsnSpreadColors      = True    

wks  = gsn_open_wks("eps","Z_SEN1_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/450.,460.,470.,480.,490.,500.,510.,520.,530.,540.,550./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_ave(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_500")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_diff(0,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN1_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z1_p_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_SEN2_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/1020.,1040.,1060.,1080.,1100.,1120.,1140.,1160.,1180.,1200.,1220./)
plot = gsn_csm_contour_map_ce(wks,Z2_p_ave(1,:,:),res)
delete(wks)

wks  = gsn_open_wks("eps","Z_Diff_200")      
gsn_define_colormap(wks,"cmp_b2r")   
res@cnLevels=(/-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5/)
plot = gsn_csm_contour_map_ce(wks,Z_diff(1,:,:),res)
delete(wks)