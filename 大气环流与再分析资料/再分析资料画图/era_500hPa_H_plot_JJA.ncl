load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"
wrfres=addfile("wrfout_d01_1998-05-28_00:00:00","r")
LAT=wrfres->XLAT(0,:,:)
LON=wrfres->XLONG(0,:,:)
nlat=dimsizes(LAT)
nlon=dimsizes(LON)

res                       = True   
res@gsnFrame	= False
res@gsnDraw=False
res@gsnSpreadColors       = True   
res@gsnAddCyclic          = False   
  
res@cnFillOn              = True    ; turn on color fill
res@cnLinesOn             = False    ; turn of contour lines

res@pmTickMarkDisplayMode  = "Always"

res@mpProjection           = "LambertConformal"
res@mpLambertParallel1F    = 30
res@mpLambertParallel2F    = 60
res@mpLambertMeridianF     = 110
res@mpLimitMode           = "Corners"          
res@mpLeftCornerLatF = LAT(180,0)
res@mpLeftCornerLonF =  LON(180,0)
res@mpRightCornerLatF = LAT(0,222)
res@mpRightCornerLonF = LON(0,222)
res@mpDataBaseVersion     = "MediumRes"       
res@mpDataSetName       = "Earth..4" 
res@mpOutlineOn              = True

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)

res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/552,556,560,564,568,572,576,580,584,588,592/)
res@mpGridAndLimbOn     = True
res@mpGridSpacingF      = 10
res@mpGridLineDashPattern       = 2

;====================================================================================================

f=addfile("era_500hPa_H.nc","r")
tmp=f->z
var=tmp*0.228064188557673+51662.5949522807


;lat=f->latitude
;lon=f->longitude
;ind_lat=ind(lat.ge.LAT(598,0).and.lat.le.LAT(0,706))
;ind_lon=ind(lon.ge.LON(598,0).and.lon.le.LON(0,706))
;JJA=dim_avg_n_Wrap(var(124:,ind_lat,ind_lon),0)
JJA=dim_avg_n_Wrap(var(184:212,:,:),0)
JJA=JJA/9.8/10
copy_VarMeta(tmp(0,:,:),JJA)

res@gsnRightString="dagpm"
wks=gsn_open_wks("eps" ,"500hPa_Geo_JJA")
gsn_define_colormap(wks,"cmp_b2r")
plt=gsn_csm_contour_map(wks,JJA,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)
