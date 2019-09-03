load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

infile = addfile(root+"nswrs.sfc.gauss.2018.nc", "r")

Cfile = addfile(root+"nswrs.sfc.day.1981-2010.ltm.nc", "r")

myyear = 2018

lat = infile->lat
lon = infile->lon

data = infile->nswrs

hgt_201805 = data(120:150,:,:)

hgt_clim05 = Cfile->nswrs(120:150,:,:)

hgt_anom05 = hgt_201805 - hgt_clim05
copy_VarMeta(hgt_201805, hgt_anom05)

lat_idx = ind(lat.ge.27.and.lat.le.32)
lon_idx = ind(lon.ge.118.and.lon.le.123)

hgt = dim_avg_n_Wrap(dim_avg_n_Wrap(hgt_anom05(:,lat_idx,lon_idx), 2),1)

rts           = True

rts@gsnScale  = True
rts@gsnDraw   = False
rts@gsnFrame  = False

rts@vpWidthF  = 0.75
rts@vpHeightF = 0.26
rts@tiYAxisString = ""
rts@gsnMaximize=True
;rts@trYMinF   = -2.0        ; min value on y-axis
;rts@trYMaxF   =  2.0        ; max value on y-axis
rts@tmXTOn=False
rts@tmYROn=False
rts@tmXBLabelFontHeightF=0.01
rts@tmYLLabelFontHeightF=0.01
rts@gsnXYBarChart         = False
;rts@gsnYRefLine           = 0.
;rts@gsnXYBarChartBarWidth = 0.7
rts@xyLineColor = "black"
rts@xyLineThicknesses = 7.

rts@tmXBMode      = "Explicit" 
rts@tmXBValues    = (/  0. ,  4.,  9.,   14., 19., 24., 29 /)
rts@tmXBLabels    = (/"05-01","05-05","05-10","05-15" ,"05-20","05-25", "05-30" /)
rts@tmXBLabelFontHeightF = 0.017

wks=gsn_open_wks("png","nswrs-daily")
p5=gsn_csm_xy(wks, ispan(0, 30, 1), hgt, rts)

draw(wks)
frame(wks)
