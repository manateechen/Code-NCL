load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

uinfile = addfile(root+"vwnd.2017.nc", "r")
winfile = addfile("w.2017.nc", "r")

uCinfile = addfile(root+"vwnd.day.1981-2010.ltm.nc", "r")
wCinfile = addfile("w.day.1981-2010.ltm.nc", "r")

myyear = 2018

lev = uinfile->level

lat = uinfile->lat
lon = uinfile->lon

lat_idx = ind(lat.ge.-10.and.lat.le.40)
lon_idx = ind(lon.ge.118.and.lon.le.123)


year=calendar_decode2(uinfile->time,0)
year_idx=ind(year(:,0).eq.myyear)

udata = uinfile->vwnd
wdata = winfile->w

uCdata = uCinfile->vwnd
wCdata = wCinfile->w

u_201805 = dim_avg_n_Wrap(udata(189:208,0:11,:,:),0)
w_201805 = dim_avg_n_Wrap(wdata(189:208,:,:,:),0)

u_clim = dim_avg_n_Wrap(uCdata(189:208,0:11,:,:),0)
w_clim = dim_avg_n_Wrap(wCdata(189:208,:,:,:),0)

u_anom = u_201805 - u_clim
w_anom = w_201805 - w_clim

uu = dim_avg_n(u_anom(:,:,lon_idx), 2)
ww = dim_avg_n(w_anom(:,:,lon_idx), 2)*1000.0

copy_VarMeta(u_201805(:,:,0), uu)
copy_VarMeta(u_201805(:,:,0), ww)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res@vcRefMagnitudeF  = 8
res@vcRefLengthF     = 0.02

res@vcGlyphStyle="LineArrow"
res@vcLineArrowThicknessF=2.6


res@trYReverse = True

res@vcRefAnnoOn               = True
res@vcRefAnnoString1          = "8"
res@vcRefAnnoSide             = "Top"
res@vcRefAnnoString2On        = False
res@vcRefAnnoPerimOn          = False
res@vcRefAnnoOrthogonalPosF   = -0.09
res@vcRefAnnoParallelPosF     = 0.999
res@vcRefAnnoBackgroundColor  = "green"
res@vcFillArrowWidthF=0.05
res@vcFillArrowHeadYF=0.07

res@vcMonoFillArrowFillColor =True
res@vcFillArrowFillColor = "black"
res@vcFillArrowEdgeColor = "white"

res@cnLinesOn = False
res@cnFillOn = False
res@cnInfoLabelOn = False
res@cnLineLabelsOn = False

res@tmXBLabelFontHeightF = 0.03
res@tmYLLabelFontHeightF = 0.03
res@tmYRLabelFontHeightF = 0.03   




ddu = uu(:,lat_idx)


wks = gsn_open_wks("eps", "May-wind-latlev-7-10-29")

map = gsn_csm_pres_hgt_vector(wks, ddu, uu(:,lat_idx),ww(:,lat_idx), res)

draw(map)
frame(wks)
  
