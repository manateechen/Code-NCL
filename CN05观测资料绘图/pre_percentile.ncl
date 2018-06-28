load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

datafile=addfile("pre_monthly.nc","r")

pre=datafile->pre

ave=dim_avg_n_Wrap(dim_avg_n_Wrap(pre,2),1)

printVarSummary(ave)

;calculate two terciles

ip=dim_pqsort(ave,1)
;print(ip)

pre_0667=pre(ip(61),:,:)
pre_0333=pre(ip(30),:,:)

res                       = True   
res@gsnFrame	= False
res@gsnDraw=False
res@gsnSpreadColors       = True   
res@gsnAddCyclic          = False   
  
res@cnFillOn              = True    ; turn on color fill
res@cnLinesOn             = False    ; turn of contour lines
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100/)

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


wks = gsn_open_wks("eps" ,"tercile_0.333")                ; open a ps file
gsn_define_colormap(wks,"cmp_b2r")        ; choose colormap
res@gsnLeftString=""
res@gsnRightString=""
res@tiMainString="first tercile 0.333"
plot = gsn_csm_contour_map(wks,pre_0333, res)
attach_china_map(wks, plot)
draw(plot) 
frame(wks)

wks = gsn_open_wks("eps" ,"tercile_0.667")                ; open a ps file
gsn_define_colormap(wks,"cmp_b2r")        ; choose colormap
res@gsnLeftString=""
res@gsnRightString=""
res@tiMainString="second tercile 0.667"
plot = gsn_csm_contour_map(wks,pre_0667, res)
attach_china_map(wks, plot)
draw(plot)
frame(wks)

