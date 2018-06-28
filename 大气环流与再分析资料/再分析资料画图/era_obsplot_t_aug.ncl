load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"
 

f = addfile("era_2mt.nc","r")
tmp=f->2mt
tas  = dim_avg_n_Wrap(tmp(61:91,:,:),0)-273.15
copy_VarMeta(tmp(0,:,:),tas)

wks = gsn_open_wks("eps" ,"tm_aug")                ; open a ps file
gsn_define_colormap(wks,"cmp_b2r")        ; choose colormap

res                       = True   
res@gsnFrame	= False
res@gsnDraw=False
res@gsnSpreadColors       = True   
res@gsnAddCyclic          = False   
  
res@cnFillOn              = True    ; turn on color fill
res@cnLinesOn             = False    ; turn of contour lines
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/2,4,6,8,10,12,14,16,18,20,22,24,26,28,30/)

res@pmTickMarkDisplayMode  = "Always"

res@mpLandFillColor=-1
res@mpProjection           = "LambertConformal"
res@mpLambertParallel1F    = 30
res@mpLambertParallel2F    = 60
res@mpLambertMeridianF     = 110
res@mpLimitMode           = "Corners"          
res@mpLeftCornerLatF      = 10
res@mpLeftCornerLonF      = 80
res@mpRightCornerLatF     = 53
res@mpRightCornerLonF     = 160
res@mpDataBaseVersion     = "MediumRes"         

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = True
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)

res@gsnLeftString=""
res@gsnRightString=""
res@tiMainString="Temperature of August in 1998"
plot = gsn_csm_contour_map(wks,tas, res)
attach_china_map(wks, plot)
draw(plot) 
frame(wks)
 