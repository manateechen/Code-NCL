load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

uinfile = addfile(root+"uwnd.mon.mean.nc", "r")
winfile = addfile("w.mon.mean.nc", "r")

uCinfile = addfile(root+"uwnd.mon.1981-2010.ltm.nc", "r")
wCinfile = addfile("w.mon.1981-2010.ltm.nc", "r")

myyear = 2017

lev = uinfile->level

lat = uinfile->lat
lon = uinfile->lon


lat_idx = ind(lat.ge.27.and.lat.le.32)
lon_idx = ind(lon.ge.110.and.lon.le.180)


year=calendar_decode2(uinfile->time,0)
year_idx=ind(year(:,0).eq.myyear)

udata = uinfile->uwnd
wdata = winfile->w

uCdata = uCinfile->uwnd
wCdata = wCinfile->w

u_201805 = udata(year_idx(6:7),0:11,:,:)
w_201805 = wdata(year_idx(6:7),:,:,:)

u_clim = uCdata(6:7,0:11,:,:)
w_clim = wCdata(6:7,:,:,:)

u_anom = dim_avg_n_Wrap(u_201805 - u_clim,0)
w_anom = dim_avg_n_Wrap(w_201805 - w_clim,0)

uu = dim_avg_n(u_anom(:,lat_idx,:), 1)
ww = -dim_avg_n(w_anom(:,lat_idx,:), 1)*1000.0

copy_VarMeta(u_201805(0,:,0,:), uu)
copy_VarMeta(u_201805(0,:,0,:), ww)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res@vcRefMagnitudeF  = 4
res@vcRefLengthF     = 0.02

res@vcGlyphStyle="LineArrow"
res@vcLineArrowThicknessF=2.6


res@trYReverse = True

res@vcRefAnnoOn               = True
res@vcRefAnnoString1          = "4"
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

;res@tmXBLabelFontHeightF = 0.027
res@tmYLLabelFontHeightF = 0.027
res@tmYRLabelFontHeightF = 0.027

res@tmXBMode = "Explicit"
res@tmXBValues = (/ 0. , 10., 20., 30., 40., 50.,60.,70. /)+110
res@tmXBLabels = (/"110E","120E","130E","140E","150E","160E","170E","180E" /)
print(lon_idx)

ddu = uu(:,lon_idx)


wks = gsn_open_wks("eps", "May-wind-lonlev")

map = gsn_csm_pres_hgt_vector(wks, ddu, uu(:,lon_idx),ww(:,lon_idx), res)

draw(map)
frame(wks)
  
