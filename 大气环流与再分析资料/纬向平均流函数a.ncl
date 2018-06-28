load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl" 

f1=addfile("ECMWF_monthly_681905210.nc","r")

u=f1->U

u_ave = dim_avg_n_Wrap(u,3)
wks=gsn_open_wks ("png", "u_ave")

res=True
res@cnLineLabelsOn       = True
res@cnFillOn             = True
res@cnLevelSpacingF      = 5.0
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/-40,-35,-30,-25,-20,-15,-10,-5,0,5,10,15,20,25,30,35,40/)

res@tiMainString="Zonal Mean zonal winds in Jan"
plot1=gsn_csm_pres_hgt(wks, u_ave(0,:,:), res) 

res@tiMainString="Zonal Mean zonal winds in Jul"
plot2=gsn_csm_pres_hgt(wks, u_ave(6,:,:), res) 
