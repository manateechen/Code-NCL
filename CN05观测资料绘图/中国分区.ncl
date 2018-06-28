load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"
 

f = addfile("climate_pre.nc","r")
lat=f->lat
lon=f->lon


lon1=fspan(98.6,120.5,100)
lat1=lon1
lat1=27

lat2=lon1
lat2=33
lon2=lon1

lon3=fspan(110.5,130.5,100)
lat3=lon3
lat3=43

lon4=fspan(78,98.6,100)
lat4=lon3
lat4=35

lat5=fspan(27,42.5,100)
lon5=lat5
lon5=98.6

wks = gsn_open_wks("eps" ,"region")                ; open a ps file

res                       = True   
res@gsnFrame	= False
res@gsnDraw=False 
  
res@pmTickMarkDisplayMode  = "Always"

res@mpLandFillColor=-1
res@mpProjection           = "LambertConformal"
res@mpLambertParallel1F    = 30
res@mpLambertParallel2F    = 60
res@mpLambertMeridianF     = 110
res@mpLimitMode           = "Corners"          
res@mpLeftCornerLatF      = 10
res@mpLeftCornerLonF      = 80
res@mpRightCornerLatF     = 53
res@mpRightCornerLonF     = 160
res@mpDataBaseVersion     = "MediumRes"         

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = True
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)

res@gsnLeftString=""
res@gsnRightString=""
res@tiMainString="Region"
plot = gsn_csm_map(wks, res)

poly_res=True
poly_res@gsLineThicknessF=7
s=gsn_add_polyline(wks,plot,lon1,lat1,True)
s1=gsn_add_polyline(wks,plot,lon2,lat2,True)
s2=gsn_add_polyline(wks,plot,lon3,lat3,True)
s3=gsn_add_polyline(wks,plot,lon4,lat4,True)
s4=gsn_add_polyline(wks,plot,lon5,lat5,True)
attach_china_map(wks, plot)
draw(plot) 
frame(wks)
 