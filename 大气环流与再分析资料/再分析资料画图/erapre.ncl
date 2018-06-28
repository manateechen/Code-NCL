load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

datafile=addfile("erapre.nc","r")

tmp=short2flt(datafile->tp)
PRE=tmp*1000
copy_VarMeta(tmp,PRE)

;pretmp=new((/29,241,480/),"float")
;do i=0,7
;  pretmp(i,:,:)=PRE(i*2+29,:,:)+PRE(i*2+29+1,:,:)
;end do

pre=dim_sum_n_Wrap(PRE(29:43,:,:),0)

wrfres=addfile("wrfout_d01_1998-06-16_00:00:00","r")
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
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)

res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/40,80,120,160,200,240,280,320,360,400,440/)
res@mpGridAndLimbOn     = True
res@mpGridSpacingF      = 10
res@mpGridLineDashPattern       = 2


res@gsnRightString="mm"
wks=gsn_open_wks("eps" ,"pre")
gsn_define_colormap(wks,"cmp_b2r")
plt=gsn_csm_contour_map(wks,pre,res)
attach_china_map(wks, plt)
draw(plt)
delete(wks)
