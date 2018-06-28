load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wrfres=addfile("/home/qianqf/wrfout_d01_2013-08-01_00:00:00","r")

res=True
;WRF_map_c(wrfres,res,0)
res@tfDoNDCOverlay=True
res@pmTickMarkDisplayMode="Always"
res@gsnDraw=False
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
res@isAddMask = True
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5

res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/-100,-75,-50,-25,-10,-5,-2,0,2,5,10,25,50,75,100/)
;res@cnLevels=ispan(-10,10,1)

setup_china_map(res)

res@mpProjection = "LambertConformal"
res@mpLimitMode = "Corners"
res@mpLeftCornerLatF = 10.34379
res@mpLeftCornerLonF =    80.9162
res@mpRightCornerLatF =   52.64054
res@mpRightCornerLonF =   159.5966
res@mpCenterLonF =        107
res@mpCenterLatF =        38.00001
res@mpLambertParallel1F = 30
res@mpLambertParallel2F = 60
res@mpLambertMeridianF =  107
res@mpGridAndLimbOn     = True
res@mpGridSpacingF      = 10
res@mpGridLineDashPattern       = 2
res@mpDataBaseVersion   = "MediumRes"
res@mpDataSetName       = "Earth..4" 
res@mpMaskAreaSpecifiers     = (/"China","Taiwan","Disputed area between India and China","India:Arunachal Pradesh"/)
res@cnFillDrawOrder     = "PreDraw"
;res@mpOutlineOn              = True
;====================================================================================================

ctldata=addfile("ctl_pre.nc","r")
ctl=ctldata->ctl_pre
sendata=addfile("wind_pre.nc","r")
sen=sendata->wind_pre

diff=sen-ctl

;MAM=(diff(603,:,:)-diff(236,:,:)+diff(2063,:,:)-diff(1696,:,:)+diff(3523,:,:)-diff(3156,:,:))/3.0
JJA=(diff(971,:,:)-diff(604,:,:)+diff(2431,:,:)-diff(2064,:,:)+diff(3891,:,:)-diff(3524,:,:))/3.0
;SON=(diff(1335,:,:)-diff(972,:,:)+diff(2795,:,:)-diff(2432,:,:)+diff(4255,:,:)-diff(3892,:,:))/3.0
DJF=(diff(1695,:,:)-diff(1336,:,:)+diff(3155,:,:)-diff(2796,:,:)+diff(4615,:,:)-diff(4256,:,:))/3.0


wks=gsn_open_wks("eps" ,"pre_JJA")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt=gsn_csm_contour_map(wks,JJA,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)


wks=gsn_open_wks("eps" ,"pre_DJF")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt=gsn_csm_contour_map(wks,DJF,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)