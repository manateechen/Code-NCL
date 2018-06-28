load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

prefile="r1_huanan_2014052208.txt"
dbzfile="1405221654DZ.dat"

;nlines=9111        ;04
;nlines=9102        ;05 
;nlines=9129        ;06
;nlines=9325        ;07
nlines=9445        ;08

data=asciiread(prefile,(/nlines,6/),"float")
lat=data(:,1)
lon=data(:,2)
pre=data(:,4)
pre@_FillValue=999999.0

timeslice="08-07"
Tfile="T"+timeslice
Pfile="P"+timeslice
Latfile="lat"+timeslice
Lonfile="lon"+timeslice

;nTPlines=9128     ;04-03
;nTPlines=9188     ;05-04
;nTPlines=9176     ;06-05
;nTPlines=9176     ;07-06
nTPlines=9188     ;08-07

T=asciiread(Tfile,nTPlines,"float")
latTP=asciiread(Latfile,nTPlines,"float")
lonTP=asciiread(Lonfile,nTPlines,"float")

xx = fbindirread(dbzfile, -1, (/31,401,401/), "float")

nlat=401
nlon=401

newlat=fspan(23.004-1.8,23.004+1.8,nlat)
newlat!0 = "lat"
newlat@long_name = "lat"
newlat@units = "degrees_north"
newlat&lat = newlat

newlon=fspan(113.355-1.8,113.355+1.8,nlon)
newlon!0 = "lon"
newlon@long_name = "lon"
newlon@units = "degrees_east"
newlon&lon = newlon

rscan = (/3, 1, 0.5/)

newpre=obj_anal_ic_Wrap(lon,lat,pre,newlon,newlat,rscan,False)
newpre!0="lat"
newpre&lat=newlat
newpre!1="lon"
newpre&lon=newlon
printVarSummary(newpre)
print(min(newpre))
print(max(newpre))

newt=obj_anal_ic_Wrap(lonTP,latTP,T,newlon,newlat,rscan,False)
newt!0="lat"
newt&lat=newlat
newt!1="lon"
newt&lon=newlon
printVarSummary(newt)
print(min(newt))
print(max(newt))

res=True
res@gsnAddCyclic=False
res@gsnDraw         = False
res@gsnFrame        = False
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnMaximize=True
res@tiMainOffsetYF=-0.04
res@tiMainFontHeightF=0.02
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@cnFillOn=True
res@gsnSpreadColors=True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(5,55,5)
res@lbOrientation       = "Vertical"

res@pmTickMarkDisplayMode = "Always"         
res@mpMinLatF=min(newlat)
res@mpMaxLatF=max(newlat)
res@mpMinLonF=min(newlon)
res@mpMaxLonF=max(newlon)

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "gray"
res@riverThickness = 0.5 
res@boundaryColor = "black"
res@boundaryThickness = 0.2 
setup_china_map(res)
res@sfXArray=newlon
res@sfYArray=newlat

res_t                 = True
res_t@gsnAddCyclic=False
res_t@gsnDraw         = False
res_t@gsnFrame        = False
res_t@gsnLeftString = ""
res_t@gsnRightString = ""
res_t@cnLinesOn       = True
res_t@cnLineLabelsOn  = True
res_t@cnInfoLabelOn   = False
res_t@cnLineColor="red"
res_t@cnLineDashPattern=1
res_t@cnLineThicknessF=7.0
res_t@cnLineLabelFontHeightF=0.015
res_t@cnLineLabelFontColor="red"
res_t@cnLevelSelectionMode = "ExplicitLevels"
res_t@cnLevels=(/-8.0,-7.0,-6.0,-5.0,-4.0,-3.0,-2.0,-1.0/)
res_t@cnLineLabelBackgroundColor=0

res_p                 = True
res_p@gsnAddCyclic=False
res_p@gsnDraw         = False
res_p@gsnFrame        = False
res_p@gsnLeftString = ""
res_p@gsnRightString = ""
res_p@cnLinesOn       = True
res_p@cnLineLabelsOn  = True
res_p@cnInfoLabelOn   = False
res_p@cnLineColor="blue"
res_p@cnLineThicknessF=7.0
res_p@cnLineLabelFontHeightF=0.015
res_p@cnLineLabelFontColor="blue"
res_p@cnLevelSelectionMode = "ExplicitLevels"
res_p@cnLevels=ispan(4,100,4)
res_p@cnLineLabelBackgroundColor=0


wks=gsn_open_wks("pdf","surface"+timeslice)
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot=gsn_csm_contour_map(wks,xx(0,:,0:399),res)
plot01=gsn_csm_contour(wks,newpre,res_p)
plot02=gsn_csm_contour(wks,newt,res_t)
overlay(plot,plot01)
overlay(plot,plot02)
attach_china_map(wks, plot)
draw(plot)
