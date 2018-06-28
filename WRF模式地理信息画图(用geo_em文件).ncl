load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wrfres=addfile("geo_em.d01.nc","r")
LAT=wrfres->XLAT_M(0,:,:)
LON=wrfres->XLONG_M(0,:,:)
nlat=dimsizes(LAT)
nlon=dimsizes(LON)

res=True
res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)
res@gsnDraw=False
res@gsnFrame=False

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

res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1250,1500,1750,2000,2250,2500,2750,3000,3250,3500,3750,4000,4250,4500,4750,5000,5250,5500,5750,6000/)

res@mpProjection = "LambertConformal"
res@mpLimitMode = "Corners"
res@mpLeftCornerLatF = LAT(598,0)
res@mpLeftCornerLonF =  LON(598,0)
res@mpRightCornerLatF = LAT(0,706)
res@mpRightCornerLonF = LON(0,706)
res@mpCenterLonF =        107
res@mpCenterLatF =        38
res@mpLambertParallel1F = 30
res@mpLambertParallel2F = 60
res@mpLambertMeridianF =  107
res@mpGridAndLimbOn     = True
res@mpGridSpacingF      = 10
res@mpGridLineDashPattern       = 2
res@mpDataBaseVersion   = "MediumRes"
res@mpDataSetName       = "Earth..4" 
res@mpOutlineOn              = True

geo=wrfres->HGT_M

wks=gsn_open_wks("eps" ,"GEO")
gsn_define_colormap(wks,"OceanLakeLandSnow")
plt=gsn_csm_contour_map(wks,geo(0,:,:),res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)