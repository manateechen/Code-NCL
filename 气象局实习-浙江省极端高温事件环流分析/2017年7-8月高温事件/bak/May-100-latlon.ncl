load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

infile = addfile(root+"hgt.mon.mean.nc", "r")

Cfile = addfile(root+"hgt.mon.1981-2010.ltm.nc", "r")

mylev = 100
myyear = 2017

lev = infile->level

lat = infile->lat
lon = infile->lon

year=calendar_decode2(infile->time,0)
year_idx=ind(year(:,0).eq.myyear)

lev_idx = ind(lev.eq.mylev)

data = infile->hgt

hgt_201805 = data(year_idx(6:7),lev_idx,:,:)

hgt_clim05 = Cfile->hgt(6:7,lev_idx,:,:)

hgt_anom05 = hgt_201805 - hgt_clim05
copy_VarMeta(hgt_201805, hgt_anom05)

hgt_clim05_dagpm = hgt_clim05 / 10.0
copy_VarMeta(hgt_clim05, hgt_clim05_dagpm)

fugao = hgt_201805 / 10.0
copy_VarMeta(hgt_clim05, fugao)


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
res4 = res

res@mpLimitMode = "LatLon"
res@mpMinLatF = 0
res@mpMaxLatF = 80
res@mpMinLonF = 10
res@mpMaxLonF = 150

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
res@cnLevels=(/-120,-100,-80,-60,-40,-20,-10,0,10,20,40,60,80,100,120/)/2.0
res@cnFillColors=(/4,5,6,7,8,9,10,0,0,11,12,13,14,15,16,17/)

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
res2@cnLevels=ispan(1600, 1800, 8)

res3@cnFillOn = False
res3@cnLinesOn=True
res3@cnInfoLabelOn=False
res3@cnLevelSelectionMode = "ExplicitLevels"
res3@cnLevels=(/1684/)
res3@cnLineThicknessF = 4

res4@cnFillOn = False
res4@cnLinesOn=True
res4@cnInfoLabelOn=False
res4@cnLevelSelectionMode = "ExplicitLevels"
res4@cnLevels=(/1684/)
res4@cnLineThicknessF = 4
res4@cnLineDashPattern = 16

wks = gsn_open_wks("eps", "May-"+mylev+"-latlon")
gsn_define_colormap(wks,"BlueDarkRed18")

map = gsn_csm_contour_map(wks, dim_avg_n_Wrap(hgt_anom05,0), res)

map2 = gsn_csm_contour(wks, dim_avg_n_Wrap(hgt_clim05_dagpm,0), res2)
overlay(map, map2)

map3 = gsn_csm_contour(wks, dim_avg_n_Wrap(fugao,0), res3)
overlay(map, map3)

map4 = gsn_csm_contour(wks, dim_avg_n_Wrap(hgt_clim05_dagpm,0), res4)
overlay(map, map4)

attach_china_map(wks, map)

draw(map)
frame(wks)
  