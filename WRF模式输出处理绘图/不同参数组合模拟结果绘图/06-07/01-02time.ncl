load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

f = addfile("climate_pre.nc","r")
lat=f->lat
lon=f->lon
ind_lat=ind(lat.ge.18.and.lat.le.33)
ind_lon=ind(lon.ge.106.and.lon.le.123)
tmp=f->pre
climate_pre=tmp(15:21,ind_lat,ind_lon)
ny=dimsizes(ind_lat)
nx=dimsizes(ind_lon)
delete(tmp)

f1=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")

rainnc = wrf_user_getvar(f1,"RAINNC",-1)
irainnc = wrf_user_getvar(f1,"I_RAINNC",-1)
rainc = wrf_user_getvar(f1,"RAINC",-1)
irainc = wrf_user_getvar(f1,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc

total_pre1=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),total_pre1)

pretime1=rainnc(0:27,:,:)
do i=0,27
  pretime1(i,:,:)=tmp(i+1,:,:)-tmp(i,:,:)
end do
copy_VarMeta(rainnc(0:27,:,:),pretime1)

xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)

pretime1_new=new((/28,ny,nx/),"float")
do i=27,27
  pretime1_new(i,:,:)=rcm2rgrid_Wrap(xlat,xlon,pretime1(i,:,:),lat(ind_lat),lon(ind_lon), 1)
end do
printVarSummary(pretime1_new)




f2=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")

rainnc = wrf_user_getvar(f2,"RAINNC",-1)
irainnc = wrf_user_getvar(f2,"I_RAINNC",-1)
rainc = wrf_user_getvar(f2,"RAINC",-1)
irainc = wrf_user_getvar(f2,"I_RAINC",-1)
tmp=(irainnc+irainc)*100.0+rainnc+rainc

total_pre2=tmp(28,:,:)-tmp(0,:,:)
copy_VarMeta(rainnc(0,:,:),total_pre2)

pretime2=rainnc(0:27,:,:)
do i=0,27
  pretime2(i,:,:)=tmp(i+1,:,:)-tmp(i,:,:)
end do
copy_VarMeta(rainnc(0:27,:,:),pretime2)


pretime2_new=new((/28,ny,nx/),"float")
do i=27,27
  pretime2_new(i,:,:)=rcm2rgrid_Wrap(xlat,xlon,pretime2(i,:,:),lat(ind_lat),lon(ind_lon), 1)
end do
printVarSummary(pretime2_new)









res                 = True
res@cnFillOn        = True
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@gsnSpreadColors = True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/40,80,120,160,200,240,280,320,360,400,440/)
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnDraw         = False
res@gsnFrame        = False

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = True
res@riverColor = "black"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.5
setup_china_map(res)


wks = gsn_open_wks("eps", "sssss") 
map = gsn_csm_contour(wks,   pretime1_new(27,:,:)   , res)
attach_china_map(wks, map)

draw(map) 

