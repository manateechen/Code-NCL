load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

infile = addfile(root+"omega.2018.nc", "r")

Cfile = addfile(root+"omega.day.1981-2010.ltm.nc", "r")

myyear = 2018

lat = infile->lat
lon = infile->lon

lat_idx = ind(lat.ge.27.and.lat.le.32)
lon_idx = ind(lon.ge.118.and.lon.le.123)

hgt_201805 = infile->omega(120:150,:,:,:)

hgt_clim05 = Cfile->omega(120:150,:,:,:)

hgt_anom = hgt_201805 - hgt_clim05
copy_VarMeta(hgt_201805, hgt_anom)

hgt_anom_timelon = dim_avg_n_Wrap(dim_avg_n_Wrap(hgt_anom(:,:,lat_idx,lon_idx), 3),2)

tt = infile->time(120:150)

wks  = gsn_open_wks ("eps", "May-omega-timelev" )           ; send graphics to PNG file
gsn_define_colormap(wks,"GMT_polar")

res                      = True               ; plot mods desired
res@tiMainString         = "" 
res@gsnLeftString=""
res@gsnRightString=""
res@gsnDraw=False
res@gsnFrame=False

res@cnLinesOn = False
res@cnFillOn             = True               ; turn on color fill
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(-0.2,0.2,21)
;res@cnFillColors=(/4,5,6,7,8,0,0,13,14,15,16,17/)

res@tmXBMode      = "Explicit"          
res@tmXBValues    = tt(0)+(/  0. ,  4.,  9.,   14., 19., 24., 29 /)*24.0
res@tmXBLabels    = (/"1","5","10","15" ,"20","25", "30" /)

res@trYReverse = True

printVarSummary(hgt_anom_timelon)

plot = gsn_csm_contour(wks, hgt_anom_timelon(level|0:11,time|:), res) 

draw(plot)
frame(wks)   