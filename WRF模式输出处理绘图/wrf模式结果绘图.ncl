load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

data=addfile("/home3_hn/qqf/runwrf/run/wrfout_d01_2007-01-01","r")
;data=addfile("wrfout_d01_2013-08-01_00:00:00.nc","r")

times=chartostring(data->Times)
T_2m=data->T2(0:5843,:,:)
U_10m=data->U10(0:5843,:,:)
V_10m=data->V10(0:5843,:,:)
irainnc=data->I_RAINNC(0:5843,:,:)
rainnc=data->RAINNC(0:5843,:,:)
irainc=data->I_RAINC(0:5843,:,:)
rainc=data->RAINC(0:5843,:,:)
pre=(irainnc+irainc)*100.0+rainnc+rainc
PRE=(pre(5843,:,:)-pre(0,:,:))/4.0
LAT=data->XLAT(0,:,:)
LON=data->XLONG(0,:,:)

t2_ave=dim_avg_n_Wrap(T_2m,0)
u10_ave=dim_avg_n_Wrap(U_10m,0)
v10_ave=dim_avg_n_Wrap(V_10m,0)


t2_ave@lat2d=LAT
t2_ave@lon2d=LON
u10_ave@lat2d=LAT
u10_ave@lon2d=LON
v10_ave@lat2d=LAT
v10_ave@lon2d=LON
PRE@lat2d=LAT
PRE@lon2d=LON

speed=sqrt(u10_ave^2+v10_ave^2)

wks = gsn_open_wks("png" ,"WRF_OUT")
gsn_define_colormap(wks,"cmp_b2r")

res=True
WRF_map_c(data,res,0)
res@tfDoNDCOverlay=True
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
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False

vcres=True
WRF_map_c(data,vcres,0)
vcres@tfDoNDCOverlay=True
vcres@pmTickMarkDisplayMode="Always"
vcres@gsnMaximize=True          
vcres@gsnSpreadColors=True         
vcres@mpDataSetName="Earth..4"
vcres@mpDataBaseVersion="MediumRes"
vcres@mpOutlineOn=True
vcres@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
vcres@vcFillArrowsOn=True
vcres@vcRefMagnitudeF=8.0
vcres@vcRefLengthF=0.050
vcres@vcGlyphStyle="CurlyVector"
vcres@vcMinDistanceF=0.020
vcres@vcLineArrowThicknessF=3
vcres@vcRefAnnoOrthogonalPosF=0.01
vcres@vcRefAnnoOn=False

plt=gsn_csm_contour_map(wks,t2_ave,res)

res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/5,10,15,25,50,75,100,150,200,250,500,750,1000,1500,2000/)
PRE@description="Precipitation"
PRE@unit="mm"
plt1=gsn_csm_contour_map(wks,PRE,res)

vcres@gsnLeftString="Wind"
vcres@gsnRightString="m/s"
plt2=gsn_csm_vector_scalar_map(wks,u10_ave,v10_ave,speed,vcres)

