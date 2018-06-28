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
res@gsnFrame=False
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
res@cnLevels=ispan(-5,5,1)

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
;res@mpMaskAreaSpecifiers     = (/"China","Taiwan","Disputed area between India and China","India:Arunachal Pradesh"/)
;res@cnFillDrawOrder     = "PreDraw"
res@mpOutlineOn              = True

vcres=True
vcres@tfDoNDCOverlay=True
vcres@vcFillArrowsOn=False
vcres@vcRefLengthF=0.050
vcres@vcGlyphStyle="CurlyVector"
vcres@vcMinDistanceF=0.020
vcres@vcLineArrowThicknessF=3
vcres@vcRefAnnoOrthogonalPosF=0.01
vcres@vcRefAnnoOn=False
vcres@gsnMaximize=True 
vcres@gsnRightString          = ""
vcres@gsnLeftString           = ""
vcres@gsnDraw                 = False
vcres@gsnFrame                = False   

;====================================================================================================

ctldata_u=addfile("ctl_100m_U.nc","r")
ctl_u=ctldata_u->ctl_100m_U
ctldata_v=addfile("ctl_100m_V.nc","r")
ctl_v=ctldata_v->ctl_100m_V
sendata_u=addfile("wind_100m_U.nc","r")
sen_u=sendata_u->wind_100m_U
sendata_v=addfile("wind_100m_V.nc","r")
sen_v=sendata_v->wind_100m_V

diff_u=sen_u-ctl_u
diff_v=sen_v-ctl_v
diff_spd=sqrt(sen_u^2+sen_v^2)-sqrt(ctl_u^2+ctl_v^2)

;MAM_u=(dim_avg_n_Wrap(diff_u(236:603,:,:),0)+dim_avg_n_Wrap(diff_u(1696:2063,:,:),0)+dim_avg_n_Wrap(diff_u(3156:3523,:,:),0))/3.0
JJA_u=(dim_avg_n_Wrap(diff_u(604:971,:,:),0)+dim_avg_n_Wrap(diff_u(2064:2431,:,:),0)+dim_avg_n_Wrap(diff_u(3524:3891,:,:),0))/3.0
;SON_u=(dim_avg_n_Wrap(diff_u(972:1335,:,:),0)+dim_avg_n_Wrap(diff_u(2432:2795,:,:),0)+dim_avg_n_Wrap(diff_u(3892:4255,:,:),0))/3.0
DJF_u=(dim_avg_n_Wrap(diff_u(1336:1695,:,:),0)+dim_avg_n_Wrap(diff_u(2796:3155,:,:),0)+dim_avg_n_Wrap(diff_u(4256:4615,:,:),0))/3.0

;MAM_v=(dim_avg_n_Wrap(diff_v(236:603,:,:),0)+dim_avg_n_Wrap(diff_v(1696:2063,:,:),0)+dim_avg_n_Wrap(diff_v(3156:3523,:,:),0))/3.0
JJA_v=(dim_avg_n_Wrap(diff_v(604:971,:,:),0)+dim_avg_n_Wrap(diff_v(2064:2431,:,:),0)+dim_avg_n_Wrap(diff_v(3524:3891,:,:),0))/3.0
;SON_v=(dim_avg_n_Wrap(diff_v(972:1335,:,:),0)+dim_avg_n_Wrap(diff_v(2432:2795,:,:),0)+dim_avg_n_Wrap(diff_v(3892:4255,:,:),0))/3.0
DJF_v=(dim_avg_n_Wrap(diff_v(1336:1695,:,:),0)+dim_avg_n_Wrap(diff_v(2796:3155,:,:),0)+dim_avg_n_Wrap(diff_v(4256:4615,:,:),0))/3.0

;MAM_diff=(dim_avg_n_Wrap(diff_spd(236:603,:,:),0)+dim_avg_n_Wrap(diff_spd(1696:2063,:,:),0)+dim_avg_n_Wrap(diff_spd(3156:3523,:,:),0))/3.0
JJA_diff=(dim_avg_n_Wrap(diff_spd(604:971,:,:),0)+dim_avg_n_Wrap(diff_spd(2064:2431,:,:),0)+dim_avg_n_Wrap(diff_spd(3524:3891,:,:),0))/3.0
;SON_diff=(dim_avg_n_Wrap(diff_spd(972:1335,:,:),0)+dim_avg_n_Wrap(diff_spd(2432:2795,:,:),0)+dim_avg_n_Wrap(diff_spd(3892:4255,:,:),0))/3.0
DJF_diff=(dim_avg_n_Wrap(diff_spd(1336:1695,:,:),0)+dim_avg_n_Wrap(diff_spd(2796:3155,:,:),0)+dim_avg_n_Wrap(diff_spd(4256:4615,:,:),0))/3.0

;wks=gsn_open_wks("eps" ,"100m_V_MAM")
;gsn_define_colormap(wks,"BlueWhiteOrangeRed")
;plt1=gsn_csm_contour_map(wks,MAM_diff,res)
;plt2=gsn_csm_vector(wks,MAM_u,MAM_v,vcres)
;overlay(plt1,plt2)
;attach_china_map(wks, plt1)
;draw(plt1)
;delete(wks)

wks=gsn_open_wks("eps" ,"100m_V_JJA")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt1=gsn_csm_contour_map(wks,JJA_diff,res)
plt2=gsn_csm_vector(wks,JJA_u,JJA_v,vcres)
overlay(plt1,plt2)
attach_china_map(wks, plt1)
draw(plt1)
delete(wks)

;wks=gsn_open_wks("eps" ,"100m_V_SON")
;gsn_define_colormap(wks,"BlueWhiteOrangeRed")
;plt1=gsn_csm_contour_map(wks,SON_diff,res)
;plt2=gsn_csm_vector(wks,SON_u,SON_v,vcres)
;overlay(plt1,plt2)
;attach_china_map(wks, plt1)
;draw(plt1)
;delete(wks)

wks=gsn_open_wks("eps" ,"100m_V_DJF")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt1=gsn_csm_contour_map(wks,DJF_diff,res)
plt2=gsn_csm_vector(wks,DJF_u,DJF_v,vcres)
overlay(plt1,plt2)
attach_china_map(wks, plt1)
draw(plt1)
delete(wks)