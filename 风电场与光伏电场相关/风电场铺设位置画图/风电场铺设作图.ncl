load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

wr=addfile("wrfout_d01_2013-08","r")
data=asciiread("loc",(/450900,2/),"float")

lat=data(:,0)-1.6
lon=data(:,1)
lon(12599:27899)=lon(12599:27899)+0.7
lon(0:238499)=lon(0:238499)+0.7

asciiwrite("wind_lat",lat)
asciiwrite("wind_lon",lon)

wks   = gsn_open_wks ("eps","scatter")

res             = True
res@gsnMaximize = True
res@gsnFrame    = False
WRF_map_c(wr,res,0)


res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5


;res@mpDataSetName="Earth..4"
;res@mpDataBaseVersion="MediumRes"
;res@mpOutlineOn=True
;res@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
setup_china_map(res)
map = gsn_csm_map(wks,res)
attach_china_map(wks, map)
draw(map)
mkres               = True
mkres@gsMarkerIndex = 1
mkres@gsMarkerSizeF=0.001
mkres@gsMarkerColor = "Blue"

gsn_polymarker(wks,map,lon,lat,mkres)


frame(wks)