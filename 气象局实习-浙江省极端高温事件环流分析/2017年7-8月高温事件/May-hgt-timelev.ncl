load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

infile = addfile(root+"hgt.2017.nc", "r")

Cfile = addfile(root+"hgt.day.1981-2010.ltm.nc", "r")

myyear = 2017

lat = infile->lat
lon = infile->lon

lat_idx = ind(lat.ge.27.and.lat.le.32)
lon_idx = ind(lon.ge.118.and.lon.le.123)

hgt_201805s = infile->hgt(181:242,:,:,:)
hgt_201805 = hgt_201805s / 10.0
copy_VarMeta(hgt_201805s, hgt_201805)

hgt_clim05 = Cfile->hgt(181:242,:,:,:)
hgt_clim05 = hgt_clim05 / 10.0
copy_VarMeta(hgt_201805s, hgt_clim05)

hgt_anom = hgt_201805 - hgt_clim05
copy_VarMeta(hgt_201805s, hgt_anom)

hgt_anom_timelon = dim_avg_n_Wrap(dim_avg_n_Wrap(hgt_anom(:,:,lat_idx,lon_idx), 3),2)

tt = infile->time(181:242)

wks  = gsn_open_wks ("eps", "May-hgt-timelev" )           ; send graphics to PNG file
gsn_define_colormap(wks,"BlueDarkRed18")

res                      = True               ; plot mods desired
res@tiMainString         = "" 
res@gsnLeftString=""
res@gsnRightString=""
res@gsnDraw=False
res@gsnFrame=False

res@cnLinesOn = False
res@cnFillOn             = True               ; turn on color fill
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/-10,-8,-6,-4,-2,0,2,4,6,8,10/)
res@cnFillColors=(/4,5,6,7,8,0,0,13,14,15,16,17/)

res@tmXBLabelFontHeightF = 0.02

res@tmYLLabelFontHeightF = 0.02 

res@lbLabelFontHeightF = 0.017

res@tmXBMode      = "Explicit"          
res@tmXBValues    = tt(0)+ispan(0,60,10)*24.0
res@tmXBLabels    = (/"07-01","07-11","07-21" ,"07-31","08-09", "08-19", "08-29" /)

res@trYReverse = True

plot = gsn_csm_contour(wks, hgt_anom_timelon(level|0:11,time|:), res) 

draw(plot)
frame(wks)   
