load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

filepath="radiation.txt"
data=asciiread(filepath,(/51,62/),"float")

lon=ispan(73,135,1)
lat=ispan(53,3,1)

wks=gsn_open_wks("png","Precipitation")

res=True

res@sfXArray=lon
res@sfYArray=lat
res@gsnMaximize=True
res@mpLimitMode="LatLon"
res@mpMinLatF = 3
res@mpMaxLatF = 53
res@mpMinLonF = 74
res@mpMaxLonF = 135
res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion = "MediumRes"
res@mpOutlineOn = True
res@mpOutlineSpecifiers = (/"China:states","Taiwan"/) 
res@cnFillOn = True
res@cnLineLabelsOn = False
res@cnLinesOn = False
res@tiMainString="Mean Direct Normal Radiation"
res@gsnRightString="kWh/m2/day"

plot=gsn_csm_contour_map(wks,data,res)