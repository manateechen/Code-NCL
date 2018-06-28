load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

latfile="lat"
lonfile="lon"
prefile="PRE"

nlines=1015
nlat=300
nlon=300

lat=asciiread(latfile,(/nlines/),"float")
lon=asciiread(lonfile,(/nlines/),"float")
PRE=asciiread(prefile,(/nlines/),"float")

newlat=fspan(min(lat),max(lat),nlat)
newlat!0 = "lat"
newlat@long_name = "lat"
newlat@units = "degrees_north"
newlat&lat = newlat

newlon=fspan(min(lon),max(lon),nlon)
newlon!0 = "lon"
newlon@long_name = "lon"
newlon@units = "degrees_east"
newlon&lon = newlon

rscan = (/4, 3, 1, 0.5/)

newpre=obj_anal_ic_Wrap(lon,lat,PRE,newlon,newlat,rscan,False)
newpre!0="lat"
newpre&lat=newlat
newpre!1="lon"
newpre&lon=newlon
printVarSummary(newpre)
print(min(newpre))
print(max(newpre))

res=True

res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False

res@mpMinLatF=min(lat)
res@mpMaxLatF=max(lat)
res@mpMinLonF=min(lon)
res@mpMaxLonF=max(lon)

res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion = "MediumRes"
res@mpGridAndLimbOn = True
res@mpGridLineDashPattern = 2


res@cnFillOn=False
res@cnLinesOn=True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/10,40/)
res@cnLineThicknessF=10.0

res@pmTickMarkDisplayMode = "Always"  
res@lbLabelAutoStride = True
res@gsnMaximize     = True 

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)


wks=gsn_open_wks("pdf","mm")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot=gsn_csm_contour_map(wks,newpre,res)
attach_china_map(wks, plot)
draw(plot)

