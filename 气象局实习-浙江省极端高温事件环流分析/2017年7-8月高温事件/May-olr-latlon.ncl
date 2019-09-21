load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

infile = addfile(root+"olr.mon.mean.nc", "r")

Cfile = addfile(root+"olr.mon.ltm.nc", "r")

myyear = 2017

lat = infile->lat
lon = infile->lon

year=calendar_decode2(infile->time,0)
year_idx=ind(year(:,0).eq.myyear)


data = short2flt(infile->olr)

hgt_201805 = data(year_idx(6:7),:,:)

hgt_clim05 = short2flt(Cfile->olr(6:7,:,:))

hgt_anom05 = dim_avg_n_Wrap(hgt_201805 - hgt_clim05,0)
copy_VarMeta(hgt_201805(0,:,:), hgt_anom05)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res@mpLimitMode = "LatLon"
res@mpMinLatF = -20
res@mpMaxLatF = 40
res@mpMinLonF = 30
res@mpMaxLonF = 180


res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res@mpOutlineOn              = True
res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last

res@mpOutlineSpecifiers = (/"China:Zhejiang"/)
res@mpMaskAreaSpecifiers = (/"China:Zhejiang"/)
res@mpPerimOn   = True

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(-20,20,5) 

res@tmXBLabelFontHeightF = 0.02

res@tmYLLabelFontHeightF = 0.02 


res@lbLabelFontHeightF = 0.017


res@lbOrientation="Vertical"

res@isShowProvince = False
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@boundaryColor = "black"
res@boundaryThickness = 1
setup_china_map(res)


wks = gsn_open_wks("eps", "May-olr-latlon")
gsn_define_colormap(wks,"MPL_coolwarm")

map = gsn_csm_contour_map(wks, hgt_anom05, res)

attach_china_map(wks, map)

draw(map)
frame(wks)
  
