load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"
wrfres=addfile("wrfout_d01_1998-06-16_00:00:00","r")
LAT=wrfres->XLAT(0,:,:)
LON=wrfres->XLONG(0,:,:)
nlat=dimsizes(LAT)
nlon=dimsizes(LON)

res=True
res@isShowProvince = True
res@isShowSouthChinaSea = False
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
res@cnLevels=(/552,556,560,564,568,572,576,580,584,588,592/)

res@mpProjection = "LambertConformal"
res@mpLimitMode = "Corners"
res@mpLeftCornerLatF = LAT(180,0)
res@mpLeftCornerLonF =  LON(180,0)
res@mpRightCornerLatF = LAT(0,222)
res@mpRightCornerLonF = LON(0,222)
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

;====================================================================================================

f=addfile("wrfpress_d01_1998-06-16_00:00:00","r")
var=f->GHT_PL

JJA=dim_avg_n_Wrap(var(:,12,:,:),0)
JJA=JJA/10

res@gsnRightString="dagpm"
wks=gsn_open_wks("eps" ,"500hPa_Geo_JJA")
gsn_define_colormap(wks,"cmp_b2r")
plt=gsn_csm_contour_map(wks,JJA,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)
