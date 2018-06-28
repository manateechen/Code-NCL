load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

era_hgt_file=addfile("ERA-GEO.nc","r")

hgt=((era_hgt_file->z)*4.866332663207372+156219.190124684)/9.8/10.0
copy_VarCoords(era_hgt_file->z,hgt)
lev=era_hgt_file->level
print(lev)
printVarSummary(hgt)

hgt_spring=month_to_season(hgt,"MAM")
;hgt_summer=month_to_season(hgt,"JJA")
;hgt_autumn=month_to_season(hgt,"SON")
;hgt_winter=month_to_season(hgt,"DJF")
;hgt_winter=hgt_winter*2.0
;do i=1,34
;  hgt_winter(i,:,:,:)=hgt_winter(i,:,:,:)+hgt((i-1)*12+11,:,:,:)
;end do
;hgt_winter=hgt_winter/3.0
;printVarSummary(hgt_winter)

res=True
res@pmTickMarkDisplayMode="Always"         
res@gsnSpreadColors=True  
res@mpDataSetName="Earth..4"
res@mpDataBaseVersion="MediumRes"
res@mpOutlineOn=True
res@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
res@mpLimitMode="LatLon"
res@mpMinLatF=0.0
res@mpMaxLatF=70.0
res@mpMinLonF=50
res@mpMaxLonF=180
res@cnFillOn=False
res@cnLinesOn=True
res@cnLineLabelsOn=True
res@cnLineThicknessF=6
res@cnLineLabelInterval=1
res@mpLandFillColor="white"
res@cnInfoLabelOn=False
;res@cnLevelSelectionMode="ExplicitLevels"
;res@cnLevels=(/548,552,556,560,564,568,572,576,580,584,588,592/)
;res@cnLevels=(/1176,1184,1192,1200,1208,1216,1224,1232,1240,1248,1250,1252,1254/)

wks=gsn_open_wks("x11","southern asian high")
;res@tiMainString="JJA 500hPa Geopotential Height"
;res@tiMainString="JJA 200 hPa Geopotential Height"
;res@tiMainString="JJA 850 hPa Geopotential Height"
;res@tiMainString="MAM 500hPa Geopotential Height"
;plt=gsn_csm_contour_map(wks,dim_avg_n_Wrap(hgt_summer(:,11,:,:),0),res)
;plt=gsn_csm_contour_map(wks,dim_avg_n_Wrap(hgt_summer(:,7,:,:),0),res)
;plt=gsn_csm_contour_map(wks,dim_avg_n_Wrap(hgt_spring(:,11,:,:),0),res)
;plt=gsn_csm_contour_map(wks,dim_avg_n_Wrap(hgt_winter(1:,11,:,:),0),res)
;plt=gsn_csm_contour_map(wks,dim_avg_n_Wrap(hgt_summer(:,14,:,:),0),res)
plt=gsn_csm_contour_map(wks,hgt_spring(19,11,:,:),res)


