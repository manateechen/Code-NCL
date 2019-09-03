load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

infile = addfile(root+"hgt.2018.nc", "r")
Cfile = addfile(root+"hgt.day.1981-2010.ltm.nc", "r")

uinfile = addfile(root+"uwnd.2018.nc", "r")
UCfile = addfile(root+"uwnd.day.1981-2010.ltm.nc", "r")

hgt_day = infile->hgt(:,11,:,:)
hgt_clim = Cfile->hgt(:,11,:,:)

u_day = uinfile->uwnd(:,11,:,:)
u_clim = UCfile->uwnd(:,11,:,:)

lat = uinfile->lat
lon = uinfile->lon

u_day_dy = center_finite_diff_n(u_day, lat*3.1415926/180.0*6371000.0, False, 1, 1)
u_clim_dy = center_finite_diff_n(u_clim, lat*3.1415926/180.0*6371000.0, False, 1, 1)

uu_day = where(u_day.eq.0.and.u_day_dy.gt.0, u_day, u_day@_FillValue)
copy_VarMeta(u_day, uu_day)

day = hgt_day / 10.0
copy_VarMeta(hgt_day, day)

clim = hgt_clim/10.0
copy_VarMeta(hgt_clim, clim)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res@mpLimitMode = "LatLon"
res@mpMinLatF = -20
res@mpMaxLatF = 70
res@mpMinLonF = 10
res@mpMaxLonF = 150

res@mpGridSpacingF = 1
 res@mpGridAndLimbOn        = True

;res@mpCenterLonF=180

res3 = res
res4 = res

res33 = res
res44 = res

res333 = res
res444 = res


res3@cnFillOn = False
res3@cnLinesOn=True
res3@cnInfoLabelOn=False
res3@cnLevelSelectionMode = "ExplicitLevels"
res3@cnLevels=(/1666/)
res3@cnLineDashPattern = 16
res3@cnLineThicknessF = 4

res4@cnFillOn = False
res4@cnLinesOn=True
res4@cnInfoLabelOn=False
res4@cnLevelSelectionMode = "ExplicitLevels"
res4@cnLevels=(/1666/)
res4@cnLineThicknessF = 4

res333@cnFillOn = False
res333@cnLinesOn=True
res333@cnInfoLabelOn=False
res333@cnLevelSelectionMode = "ExplicitLevels"
res333@cnLevels=(/1667/)
res333@cnLineDashPattern = 16
res333@cnLineThicknessF = 4
res333@cnLineColor = "green"

res444@cnFillOn = False
res444@cnLinesOn=True
res444@cnInfoLabelOn=False
res444@cnLevelSelectionMode = "ExplicitLevels"
res444@cnLevels=(/1667/)
res444@cnLineThicknessF = 4
res444@cnLineColor = "green"

res33@cnFillOn = False
res33@cnLinesOn=True
res33@cnInfoLabelOn=False
res33@cnLevelSelectionMode = "ExplicitLevels"
res33@cnLevels=(/1668/)
res33@cnLineDashPattern = 16
res33@cnLineThicknessF = 4
res33@cnLineColor = "blue"

res44@cnFillOn = False
res44@cnLinesOn=True
res44@cnInfoLabelOn=False
res44@cnLevelSelectionMode = "ExplicitLevels"
res44@cnLevels=(/1668/)
res44@cnLineThicknessF = 4
res44@cnLineColor = "red"


do ii = 120,150
wks = gsn_open_wks("png", "May-"+(ii-120+1))
gsn_define_colormap(wks,"BlueDarkRed18")


map3 = gsn_csm_contour_map(wks, clim(ii,:,:), res3)

map4 = gsn_csm_contour(wks, day(ii,:,:), res4)
overlay(map3, map4)

map33 = gsn_csm_contour(wks, clim(ii,:,:), res33)
overlay(map3, map33)

map44 = gsn_csm_contour(wks, day(ii,:,:), res44)
overlay(map3, map44)

map333 = gsn_csm_contour(wks, clim(ii,:,:), res333)
overlay(map3, map333)

map444 = gsn_csm_contour(wks, day(ii,:,:), res444)
overlay(map3, map444)

draw(map3)
frame(wks)
delete(wks)
end do