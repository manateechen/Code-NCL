load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

infile = addfile(root+"uwnd.mon.mean.nc", "r")

Cfile = addfile(root+"uwnd.mon.1981-2010.ltm.nc", "r")

mylev = 200
myyear = 2018

lev = infile->level

lat = infile->lat
lon = infile->lon

year=calendar_decode2(infile->time,0)
year_idx=ind(year(:,0).eq.myyear)

lev_idx = ind(lev.eq.mylev)

data = infile->uwnd

hgt_201805 = data(year_idx(4),lev_idx,:,:)

hgt_clim05 = Cfile->uwnd(4,lev_idx,:,:)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res2 = res
res3 = res

res@mpLimitMode = "LatLon"
res@mpMinLatF = 0
res@mpMaxLatF = 80
res@mpMinLonF = 70
res@mpMaxLonF = 210

res@mpCenterLonF=180

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
res@cnLevels=ispan(-45,45,5)   ;(/-80,-70,-60,-50,-40,-30,-20,0,20,30,40,50,60,70,80/)
;res@cnFillColors=(/4,5,6,7,8,9,10,0,0,11,12,13,14,15,16,17/)

res@lbOrientation="Vertical"

res@isShowProvince = False
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@boundaryColor = "black"
res@boundaryThickness = 1
setup_china_map(res)

res2@cnFillOn = False
res2@cnLinesOn=True
res2@cnInfoLabelOn=False
res2@cnLevelSelectionMode = "ExplicitLevels"
res2@cnLevels=(/30/)
res2@cnLineThicknessF = 4

res3@cnFillOn = False
res3@cnLinesOn=True
res3@cnInfoLabelOn=False
res3@cnLevelSelectionMode = "ExplicitLevels"
res3@cnLevels=(/30/)
res3@cnLineDashPattern = 16
res3@cnLineThicknessF = 4


wks = gsn_open_wks("eps", "May-"+mylev+"-uwnd-latlon")
gsn_define_colormap(wks,"BlWhRe")

map = gsn_csm_contour_map(wks, hgt_201805, res)

map2 = gsn_csm_contour(wks, hgt_201805, res2)
overlay(map, map2)

map3 = gsn_csm_contour(wks, hgt_clim05, res3)
overlay(map, map3)

attach_china_map(wks, map)

draw(map)
frame(wks)
  