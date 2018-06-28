load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

data=addfile("wrfout_d01_2013-08-01_00:00:00","r")

hgt=data->HGT

res=True
res@gsnMaximize           = True

;res@cnFillOn              = True 
res@cnLinesOn             = False
res@cnLineLabelsOn        = False
res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion = "MediumRes"
res@mpOutlineOn = True
res@mpOutlineSpecifiers = (/"China:states","Taiwan"/) 
res@mpGridAndLimbOn   = True
res@mpGridLatSpacingF = 0.5               ; spacing for lat lines
  res@mpGridLonSpacingF = 0.5               ; spacing for lon lines


wrf_mapres_c(data,res,0)

 res@tfDoNDCOverlay       = True  
   if (.not.res@tfDoNDCOverlay) then
      pre@lat2d = data->XLAT(0,:,:)                      ; direct assignment
      pre@lon2d = data->XLONG(0,:,:)
  end if


wks = gsn_open_wks("x11" ,"WRF_lc")
plot                 = gsn_csm_contour_map(wks,hgt(0,:,:),res)