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

;res@cnLevelSelectionMode="ExplicitLevels"
;res@cnLevels=fspan(-1,1,21)

setup_china_map(res)

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

ctldata_u=addfile("ctl_10m_U.nc","r")
ctl_u=ctldata_u->ctl_10m_U
ctldata_v=addfile("ctl_10m_V.nc","r")
ctl_v=ctldata_v->ctl_10m_V

diff_u=ctl_u
diff_v=ctl_v
diff_spd=sqrt(ctl_u^2+ctl_v^2)

JJA_u=(dim_avg_n_Wrap(diff_u(604:971,:,:),0)+dim_avg_n_Wrap(diff_u(2064:2431,:,:),0)+dim_avg_n_Wrap(diff_u(3524:3891,:,:),0))/3.0
DJF_u=(dim_avg_n_Wrap(diff_u(1336:1695,:,:),0)+dim_avg_n_Wrap(diff_u(2796:3155,:,:),0)+dim_avg_n_Wrap(diff_u(4256:4615,:,:),0))/3.0

JJA_v=(dim_avg_n_Wrap(diff_v(604:971,:,:),0)+dim_avg_n_Wrap(diff_v(2064:2431,:,:),0)+dim_avg_n_Wrap(diff_v(3524:3891,:,:),0))/3.0
DJF_v=(dim_avg_n_Wrap(diff_v(1336:1695,:,:),0)+dim_avg_n_Wrap(diff_v(2796:3155,:,:),0)+dim_avg_n_Wrap(diff_v(4256:4615,:,:),0))/3.0

JJA_diff=(dim_avg_n_Wrap(diff_spd(604:971,:,:),0)+dim_avg_n_Wrap(diff_spd(2064:2431,:,:),0)+dim_avg_n_Wrap(diff_spd(3524:3891,:,:),0))/3.0
DJF_diff=(dim_avg_n_Wrap(diff_spd(1336:1695,:,:),0)+dim_avg_n_Wrap(diff_spd(2796:3155,:,:),0)+dim_avg_n_Wrap(diff_spd(4256:4615,:,:),0))/3.0

wks=gsn_open_wks("eps" ,"10m_V_JJA_CTL")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt1=gsn_csm_contour_map(wks,JJA_diff,res)
plt2=gsn_csm_vector(wks,JJA_u,JJA_v,vcres)
overlay(plt1,plt2)
attach_china_map(wks, plt1)
draw(plt1)
delete(wks)

wks=gsn_open_wks("eps" ,"10m_V_DJF_CTL")
gsn_define_colormap(wks,"BlueWhiteOrangeRed")
plt1=gsn_csm_contour_map(wks,DJF_diff,res)
plt2=gsn_csm_vector(wks,DJF_u,DJF_v,vcres)
overlay(plt1,plt2)
attach_china_map(wks, plt1)
draw(plt1)
delete(wks)