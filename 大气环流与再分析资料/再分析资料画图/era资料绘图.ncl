load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

data=addfile("wrfout_d01_2013-08-01_00:00:00.nc","r")
era=addfile("netcdf-web237-20140323130959-16342-10494.nc","r")

u_10=short2flt(era->u10)
v_10=short2flt(era->v10)
t_2=short2flt(era->t2m)
tp=short2flt(era->tp)
tp=tp*1000.0
;print(ut_calendar(era->time,-3))
u10_ave=dim_avg_n_Wrap(u_10,0)
v10_ave=dim_avg_n_Wrap(v_10,0)
t2_ave=dim_avg_n_Wrap(t_2,0)

PRE=(dim_sum_n_Wrap(tp(1:47,:,:),0)+dim_sum_n_Wrap(tp(49:95,:,:),0)+dim_sum_n_Wrap(tp(97:143,:,:),0)+dim_sum_n_Wrap(tp(145:191,:,:),0) \
+dim_sum_n_Wrap(tp(192:251,:,:),0)+dim_sum_n_Wrap(tp(252:311,:,:),0)+dim_sum_n_Wrap(tp(312:371,:,:),0)+dim_sum_n_Wrap(tp(372:431,:,:),0))*4.0
;PRE=dim_sum_n_Wrap(tp,0)

copy_VarCoords(tp(0,:,:),PRE)
speed=sqrt(u10_ave^2+v10_ave^2)

lat=wrf_user_getvar(data,"lat",0)
lon=wrf_user_getvar(data,"lon",0)

wks = gsn_open_wks("eps" ,"ERA")
gsn_define_colormap(wks,"cmp_b2r")

res=True
res@pmTickMarkDisplayMode="Always"
res@gsnMaximize=True          
res@gsnSpreadColors=True         
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@mpDataSetName="Earth..4"
res@mpDataBaseVersion="MediumRes"
res@mpOutlineOn=True
res@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
res@mpLimitMode="LatLon"
res@mpProjection="LambertConformal"
res@mpLambertParallel1F=30.
res@mpLambertParallel2F=60.
res@mpLambertMeridianF=107.
res@mpLimitMode="Corners"
res@mpLeftCornerLatF=10.34379
res@mpLeftCornerLonF=80.9162
res@mpRightCornerLatF=52.64054
res@mpRightCornerLonF=159.5966
res@mpCenterLonF=107
res@mpCenterLatF=38.00001
res@mpLambertParallel1F=30
res@mpLambertParallel2F=60
res@mpLambertMeridianF=107
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/252,256,260,264,268,272,276,280,284,288,292,296,300/)

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5

setup_china_map(res)
plt=gsn_csm_contour_map(wks,t2_ave,res)
attach_china_map(wks, plt)
draw(plt)
frame(wks)
delete(res)
delete(wks)

wks = gsn_open_wks("eps" ,"ERA1")
gsn_define_colormap(wks,"cmp_b2r")
res=True
res@pmTickMarkDisplayMode="Always"
res@gsnMaximize=True          
res@gsnSpreadColors=True         
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@mpDataSetName="Earth..4"
res@mpDataBaseVersion="MediumRes"
res@mpOutlineOn=True
res@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
res@mpLimitMode="LatLon"
res@mpProjection="LambertConformal"
res@mpLambertParallel1F=30.
res@mpLambertParallel2F=60.
res@mpLambertMeridianF=107.
res@mpLimitMode="Corners"
res@mpLeftCornerLatF=10.34379
res@mpLeftCornerLonF=80.9162
res@mpRightCornerLatF=52.64054
res@mpRightCornerLonF=159.5966
res@mpCenterLonF=107
res@mpCenterLatF=38.00001
res@mpLambertParallel1F=30
res@mpLambertParallel2F=60
res@mpLambertMeridianF=107
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/5,10,15,25,50,75,100,150,200,250,500,750,1000,1500,2000/)
PRE@description="Precipitation"
PRE@unit="mm"

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5

setup_china_map(res)
plt1=gsn_csm_contour_map(wks,PRE,res)
attach_china_map(wks, plt1)
draw(plt1)
frame(wks)
delete(wks)

wks = gsn_open_wks("eps" ,"ERA2")
gsn_define_colormap(wks,"cmp_b2r")
vcres=True
vcres@pmTickMarkDisplayMode="Always"

vcres@mpDataSetName="Earth..4"
vcres@mpDataBaseVersion="MediumRes"
vcres@mpOutlineOn=True
vcres@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
vcres@mpFillOn=False
vcres@mpLimitMode="LatLon"
vcres@mpProjection="LambertConformal"
vcres@mpLambertParallel1F=30.
vcres@mpLambertParallel2F=60.
vcres@mpLambertMeridianF=107.
vcres@mpLimitMode="Corners"
vcres@mpLeftCornerLatF=10.34379
vcres@mpLeftCornerLonF=80.9162
vcres@mpRightCornerLatF=52.64054
vcres@mpRightCornerLonF=159.5966
vcres@mpCenterLonF=107
vcres@mpCenterLatF=38.00001
vcres@mpLambertParallel1F=30
vcres@mpLambertParallel2F=60
vcres@mpLambertMeridianF=107
vcres@vcFillArrowsOn=True
vcres@vcRefMagnitudeF=8.0
vcres@vcRefLengthF=0.050
vcres@vcGlyphStyle="CurlyVector"
vcres@vcMinDistanceF=0.020
vcres@vcLineArrowThicknessF=3
vcres@vcRefAnnoOrthogonalPosF=0.01
vcres@vcRefAnnoOn=False
vcres@vcLevelSelectionMode="ExplicitLevels"
vcres@vcLevels=(/0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5/)
vcres@gsnMaximize=True      
vcres@gsnSpreadColors=True
vcres@gsnLeftString="Wind"
vcres@gsnRightString="m/s"

vcres@isShowProvince = True
vcres@isShowSouthChinaSea = True
vcres@isAddMask = False
vcres@isShowRivers = True
vcres@riverColor = "black"
vcres@riverThickness = 0.5
vcres@boundaryColor = "black"
vcres@boundaryThickness = 0.5
setup_china_map(vcres)
plt2=gsn_csm_vector_scalar_map(wks,u10_ave,v10_ave,speed,vcres)
attach_china_map(wks, plt2)
draw(plt2)
frame(wks)
