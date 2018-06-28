load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

data=addfile("wrfout_d01_2013-08-01_00:00:00.nc","r")
cru=addfile("cru_ts3.21.2001.2010.pre.dat.nc","r")

time=ut_calendar(cru->time,-1)
time=time/100

indpre=ind(time.ge.2007)
print(time(indpre))
pre=cru->pre(indpre,:,:)

PRE=dim_sum_n_Wrap(pre,0)
PRE=PRE/4.0
copy_VarCoords(pre(0,:,:),PRE)


lat=wrf_user_getvar(data,"lat",0)
lon=wrf_user_getvar(data,"lon",0)

wks = gsn_open_wks("eps" ,"CRU")
gsn_define_colormap(wks,"cmp_b2r")



res=True
res@pmTickMarkDisplayMode="Always"
res@gsnMaximize=True          
res@gsnSpreadColors=True         
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@mpDataSetName="Earth..4"
res@mpDataBaseVersion="MediumRes"
res@mpOutlineOn=True
res@mpOutlineSpecifiers=(/"China:states","Taiwan"/) 
res@mpLimitMode="LatLon"
res@mpProjection="LambertConformal"
res@mpLambertParallel1F=30.
res@mpLambertParallel2F=60.
res@mpLambertMeridianF=107.
res@mpLimitMode="Corners"
res@mpLeftCornerLatF=10.34379
res@mpLeftCornerLonF=80.9162
res@mpRightCornerLatF=52.64054
res@mpRightCornerLonF=159.5966
res@mpCenterLonF=107
res@mpCenterLatF=38.00001
res@mpLambertParallel1F=30
res@mpLambertParallel2F=60
res@mpLambertMeridianF=107
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/5,10,15,25,50,75,100,150,200,250,500,750,1000,1500,2000/)
PRE@description="Precipitation"
PRE@unit="mm"

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5

setup_china_map(res)

plt1=gsn_csm_contour_map(wks,PRE,res)

attach_china_map(wks, plt1)
draw(plt1)

