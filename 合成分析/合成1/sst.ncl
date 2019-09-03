load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"


; SON
season = "SON"
idx_A = 8
idx_B = 9
idx_C = 10

yearstart = 1979
yearend = 2017
nyear = yearend - yearstart + 1

mylev = 200

hgtfile = addfile("/home/qqf/Documents/PhD-Working/mypaper/ncfile/HadISST/sst.nc","r")
uwindfile = addfile("/home/qqf/Documents/PhD-Working/mypaper/ncfile/ncep2nc/uwnd.10m.mon.mean.nc","r")
vwindfile = addfile("/home/qqf/Documents/PhD-Working/mypaper/ncfile/ncep2nc/vwnd.10m.mon.mean.nc","r")

hgts = short2flt(hgtfile->sst)
uwinds = short2flt(uwindfile->uwnd)
vwinds = short2flt(vwindfile->vwnd)



lat_wind = hgtfile->lat
lon_wind = hgtfile->lon
year=calendar_decode2(hgtfile->time,0)
year_idx=ind(year(:,0).ge.(yearstart).and.year(:,0).le.(yearend))
y2 = calendar_decode2(uwindfile->time,0)
y2idx=ind(y2(:,0).ge.(yearstart).and.y2(:,0).le.(yearend))

hgt = hgts(year_idx,:,:)
uwind= uwinds(y2idx,0,:,:)
vwind = vwinds(y2idx,0,:,:)

hA = hgt(idx_A::12,:,:)
hB = hgt(idx_B::12,:,:)
hC = hgt(idx_C::12,:,:)
hgt_season = dtrend_leftdim((hA + hB + hC) / 3.0 ,False)
copy_VarMeta(hC,hgt_season)

uA = uwind(idx_A::12,:,:)
uB = uwind(idx_B::12,:,:)
uC = uwind(idx_C::12,:,:)
uwind_season = dtrend_leftdim((uA + uB + uC) / 3.0 ,False)
copy_VarMeta(uC,uwind_season)

vA = vwind(idx_A::12,:,:)
vB = vwind(idx_B::12,:,:)
vC = vwind(idx_C::12,:,:)
vwind_season = dtrend_leftdim((vA + vB + vC) / 3.0 ,False)
copy_VarMeta(vC,vwind_season)

high_ind = (/3,7,8,12,15,18,25,30,36/)
n_high = dimsizes(high_ind)

hgt_high = hgt_season(high_ind,:,:)
hgt_high_ave = dim_avg_n_Wrap(hgt_high,0)-dim_avg_n_Wrap(hgt_season,0)
hgt_high_ave = where(hgt_high_ave.ge.100.or.hgt_high_ave.le.-100, hgt_high_ave@_FillValue, hgt_high_ave)
copy_VarMeta(hgt_season(0,:,:),hgt_high_ave)

uwnd_high = uwind_season(high_ind,:,:)
uwnd_high_ave = dim_avg_n_Wrap(uwnd_high,0)-dim_avg_n_Wrap(uwind_season,0)
 copy_VarMeta(uwind_season(0,:,:),uwnd_high_ave)

vwnd_high = vwind_season(high_ind,:,:)
vwnd_high_ave = dim_avg_n_Wrap(vwnd_high,0)-dim_avg_n_Wrap(vwind_season,0)
 copy_VarMeta(vwind_season(0,:,:),vwnd_high_ave)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True


res@mpLimitMode = "LatLon"
res@mpMinLatF = -20
;res@mpMinLonF = 40
;res@mpMaxLonF = 285

res@mpCenterLonF=-60

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/-0.5,-0.4,-0.3,-0.2,0,0.2,0.3,0.4,0.5/)
res@cnFillColors=(/4,5,6,7,0,0,12,13,14,15/)

res@lbOrientation="Vertical"

res@gsnLeftString=""
res@gsnRightString=""

wks = gsn_open_wks("eps", "sst-EL-TP+")
gsn_define_colormap(wks,"BlueDarkRed18")

map = gsn_csm_contour_map(wks, hgt_high_ave, res)

resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

topo=asciiread("../tibet_shape",(/2066,2/),"float")
poli=gsn_add_polyline(wks,map,topo(:,0),topo(:,1),resp)



resvc                  = True                      ; plot mods desired
resvc@gsnDraw=False
resvc@gsnFrame=False

resvc@gsnLeftString=""
resvc@gsnRightString=""
resvc@gsnAddCyclic=True

resvc@vcMinDistanceF=0.02

resvc@vcRefMagnitudeF  = 3
resvc@vcRefLengthF     = 0.025

resvc@vcGlyphStyle="FillArrow"
resvc@vcLineArrowThicknessF=2.6

resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "3"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -0.125
resvc@vcRefAnnoParallelPosF     = 0.999
resvc@vcRefAnnoBackgroundColor  = "green"
resvc@vcVectorDrawOrder         = "PostDraw"
resvc@vcFillArrowWidthF=0.05
resvc@vcFillArrowHeadYF=0.07

resvc@vcMonoFillArrowFillColor =True
resvc@vcFillArrowFillColor="black"
resvc@vcFillArrowEdgeColor="black"
resvc@vcGlyphOpacityF = 0.3

;map1 = gsn_csm_vector(wks,rc_uwind_200,rc_vwind_200,resvc)

;map1 = gsn_csm_vector(wks,u_not_sig,v_not_sig,resvc)

;overlay(map,map1)


resvc@vcFillArrowFillColor = "black"
resvc@vcFillArrowEdgeColor = "black"
resvc@vcGlyphOpacityF = 1

map2 = gsn_csm_vector(wks,uwnd_high_ave,vwnd_high_ave,resvc)
overlay(map,map2)


tibet_lat_low = 30
tibet_lat_high = 40.0
tibet_lon_left = 70.0
tibet_lon_right = 82.0
ypts = (/tibet_lat_low,  tibet_lat_low, tibet_lat_high ,  tibet_lat_high, tibet_lat_low/)
xpts = (/tibet_lon_left, tibet_lon_right, tibet_lon_right, tibet_lon_left, tibet_lon_left/)
resc=True
resc@gsLineColor      = "red4"                     ; color of lines
resc@gsLineThicknessF = 3.0                       ; thickness of lines
dum5 = new(4,graphic)
dum6 = new(4,graphic)
dum7 = new(4,graphic)
dum8 = new(4,graphic)
do i = 0 , 3
  dum5(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum6(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum7(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
  dum8(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do



draw(map)
frame(wks)
