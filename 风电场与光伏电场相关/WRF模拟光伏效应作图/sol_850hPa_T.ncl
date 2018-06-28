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
res@cnLevels=(/-0.4,-0.3,-0.2,-0.1,-0.075,-0.05,-0.025,0,0.025,0.05,0.075,0.1,0.2,0.3,0.4/)

setup_china_map(res)

;====================================================================================================

ctldata=addfile("ctl_850hPa_T.nc","r")
ctl=ctldata->ctl_850hPa_T
sendata=addfile("solar_850hPa_T.nc","r")
sen=sendata->solar_850hPa_T

diff=sen-ctl

JJA=(dim_avg_n_Wrap(diff(604:971,:,:),0)+dim_avg_n_Wrap(diff(2064:2431,:,:),0)+dim_avg_n_Wrap(diff(3524:3891,:,:),0)+dim_avg_n_Wrap(diff(4984:5351,:,:),0))/4.0
DJF=(dim_avg_n_Wrap(diff(1336:1695,:,:),0)+dim_avg_n_Wrap(diff(2796:3155,:,:),0)+dim_avg_n_Wrap(diff(4256:4615,:,:),0))/3.0

JJA=JJA/9.8
DJF=DJF/9.8

wks=gsn_open_wks("eps" ,"850hPa_T_JJA")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt=gsn_csm_contour_map(wks,JJA,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)


wks=gsn_open_wks("eps" ,"850hPa_T_DJF")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt=gsn_csm_contour_map(wks,DJF,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)