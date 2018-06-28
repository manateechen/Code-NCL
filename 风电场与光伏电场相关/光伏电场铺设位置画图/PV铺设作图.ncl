load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

;data=addfile("/home3_hn/qqf/runwrf/run/wrfout_d01_2007-01-01","r")
data=addfile("wrfout_d01_2013-08-01_00:00:00.nc","r")

ALBBCK=data->ALBBCK
LAT=data->XLAT(0,:,:)
LON=data->XLONG(0,:,:)



ALBBCK@lat2d=LAT
ALBBCK@lon2d=LON
ALBBCK@description=""
wks = gsn_open_wks("eps" ,"ALBBCK")
gsn_define_colormap(wks,"WhiteBlue")

res=True
WRF_map_c(data,res,0)
res@tfDoNDCOverlay=True
res@pmTickMarkDisplayMode="Always"
res@gsnMaximize=True          
;res@gsnSpreadColors=True         
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
res@lbLabelBarOn       = False 

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5

setup_china_map(res)




plt=gsn_csm_contour_map(wks,ALBBCK(0,:,:),res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)
