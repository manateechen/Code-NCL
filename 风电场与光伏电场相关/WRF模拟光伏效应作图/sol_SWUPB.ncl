load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wrfres=addfile("/home/qianqf/wrfout_d01_2013-08-01_00:00:00","r")

res=True
WRF_map_c(wrfres,res,0)
res@tfDoNDCOverlay=True
res@pmTickMarkDisplayMode="Always"
res@gsnMaximize=True          
res@gsnSpreadColors=True         
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5

res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=ispan(-10,10,1)

setup_china_map(res)

;====================================================================================================

ctldata=addfile("ctl_SWUPB.nc","r")
ctl=ctldata->ctl_SWUPB
sendata=addfile("solar_SWUPB.nc","r")
sen=sendata->solar_SWUPB

diff=sen-ctl

;MAM=(dim_avg_n_Wrap(diff(236:603,:,:),0)+dim_avg_n_Wrap(diff(1696:2063,:,:),0)+dim_avg_n_Wrap(diff(3156:3523,:,:),0))/3.0
JJA=(dim_avg_n_Wrap(diff(604:971,:,:),0)+dim_avg_n_Wrap(diff(2064:2431,:,:),0)+dim_avg_n_Wrap(diff(3524:3891,:,:),0))/3.0
;SON=(dim_avg_n_Wrap(diff(972:1335,:,:),0)+dim_avg_n_Wrap(diff(2432:2795,:,:),0)+dim_avg_n_Wrap(diff(3892:4255,:,:),0))/3.0
DJF=(dim_avg_n_Wrap(diff(1336:1695,:,:),0)+dim_avg_n_Wrap(diff(2796:3155,:,:),0)+dim_avg_n_Wrap(diff(4256:4615,:,:),0))/3.0

;wks=gsn_open_wks("eps" ,"2m_T_MAM")
;gsn_define_colormap(wks,"BlueWhiteOrangeRed")
;plt=gsn_csm_contour_map(wks,MAM,res)
;attach_china_map(wks, plt)
;draw(plt)
;delete(wks)

wks=gsn_open_wks("eps" ,"JJA_SW")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt=gsn_csm_contour_map(wks,JJA,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)

;wks=gsn_open_wks("eps" ,"2m_T_SON")
;gsn_define_colormap(wks,"BlueWhiteOrangeRed")
;plt=gsn_csm_contour_map(wks,SON,res)
;attach_china_map(wks, plt)
;draw(plt)
;delete(wks)

wks=gsn_open_wks("eps" ,"DJF_SW")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt=gsn_csm_contour_map(wks,DJF,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)