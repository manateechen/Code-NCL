load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

infile = addfile(root+"olr.day.mean.nc", "r")

Cfile = addfile(root+"olr.day.ltm.nc", "r")

myyear = 2017

in_lat = infile->lat(::-1)
in_lon = infile->lon

Clat = Cfile->lat
Clon = Cfile->lon

year=calendar_decode2(infile->time,0)
year_idx=ind(year(:,0).eq.myyear)


data = short2flt(infile->olr)

hgt_201805ss = data(15745:15764,::-1,:)

hgt_201805 = linint2(in_lon, in_lat, hgt_201805ss, True, Clon, Clat, 0)

hgt_clim05 = short2flt(Cfile->olr(190:209,:,:))

hgt_anom05 = dim_avg_n_Wrap(hgt_201805 - hgt_clim05,0)
copy_VarMeta(hgt_clim05(0,:,:), hgt_anom05)

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
res@cnLevels=ispan(-30,30,5) 


res@lbOrientation="Vertical"

res@isShowProvince = False
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@boundaryColor = "black"
res@boundaryThickness = 1
setup_china_map(res)


wks = gsn_open_wks("eps", "May-olr-latlon-7-10-29")
gsn_define_colormap(wks,"MPL_coolwarm")

map = gsn_csm_contour_map(wks, hgt_anom05, res)

attach_china_map(wks, map)

draw(map)
frame(wks)
  
