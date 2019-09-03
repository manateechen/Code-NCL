load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

infile = addfile(root+"nswrs.sfc.mon.mean.nc", "r")

Cfile = addfile(root+"nswrs.sfc.mon.1981-2010.ltm.nc", "r")

myyear = 2018

lat = infile->lat
lon = infile->lon

year=calendar_decode2(infile->time,0)
year_idx=ind(year(:,0).eq.myyear)


data = infile->nswrs

hgt_201805s = data(year_idx(4),:,:)
printVarSummary(hgt_201805s)

hgt_clim05 = Cfile->nswrs(4,:,:)

hgt_anom05 = hgt_201805 - hgt_clim05
copy_VarMeta(hgt_201805, hgt_anom05)

res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res@mpLimitMode = "LatLon"
res@mpMinLatF = 20
res@mpMaxLatF = 40
res@mpMinLonF = 105
res@mpMaxLonF = 125


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
res@cnLevels=ispan(-60,60,10) ;(/-120,-100,-80,-60,-40,-20,-10,0,10,20,40,60,80,100,120/)
;res@cnFillColors=(/4,5,6,7,8,9,10,0,0,11,12,13,14,15,16,17/)

res@lbOrientation="Vertical"

res@isShowProvince = False
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@boundaryColor = "black"
res@boundaryThickness = 1
setup_china_map(res)


wks = gsn_open_wks("eps", "May-nswrs-latlon")
gsn_define_colormap(wks,"BlueDarkRed18")

map = gsn_csm_contour_map(wks, hgt_anom05, res)

attach_china_map(wks, map)

draw(map)
frame(wks)
  
