load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

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

data = short2flt(infile->hgt)

hgt_201805 = dim_avg_n_Wrap(data(year_idx(6:7),lev_idx,:,:),0)
hgt_anom05 = hgt_201805/10.0
copy_VarMeta(hgt_201805, hgt_anom05)



res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res2 = res

res@gsnPolar   = "NH"  

res@mpCenterLonF=120

res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res@mpOutlineOn              = True
res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last

res@mpMinLatF=30

res@mpOutlineSpecifiers = (/"China","China:Zhejiang"/)
;res@mpMaskAreaSpecifiers = (/"China","China:Zhejiang"/)
res@mpPerimOn   = True

res@cnFillOn=False
res@cnLinesOn=True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(1600, 1800, 8)
;res@cnFillColors=(/4,5,6,7,8,9,10,0,0,11,12,13,14,15,16,17/)
;res@lbOrientation="Vertical"
res@cnInfoLabelOn=False
res@cnLineThicknessF = 5


wks = gsn_open_wks("eps", "May-"+mylev+"-polar")
gsn_define_colormap(wks,"BlueDarkRed18")

map = gsn_csm_contour_map_polar(wks, hgt_anom05, res)

draw(map)
frame(wks)
