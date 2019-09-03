load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

infile = addfile(root+"olr.mon.mean.nc", "r")

Cfile = addfile(root+"olr.mon.ltm.nc", "r")

myyear = 2018

lat = infile->lat
lon = infile->lon

year=calendar_decode2(infile->time,0)
year_idx=ind(year(:,0).eq.myyear)


data = short2flt(infile->olr)

hgt_201805 = data(year_idx(4),:,:)

hgt_clim05 = short2flt(Cfile->olr(4,:,:))

hgt_anom05 = hgt_201805 - hgt_clim05
copy_VarMeta(hgt_201805, hgt_anom05)

uinfile = addfile(root+"uwnd.mon.mean.nc", "r")
uCfile = addfile(root+"uwnd.mon.1981-2010.ltm.nc", "r")

vinfile = addfile(root+"vwnd.mon.mean.nc", "r")
vCfile = addfile(root+"vwnd.mon.1981-2010.ltm.nc", "r")

mylev = 850
myyear = 2018

lev = uinfile->level

lat = uinfile->lat
lon = uinfile->lon

year2=calendar_decode2(uinfile->time,0)
year2_idx=ind(year2(:,0).eq.myyear)

lev_idx = ind(lev.eq.mylev)

udata = uinfile->uwnd
vdata = vinfile->vwnd

u_201805 = udata(year2_idx(4),lev_idx,:,:)
u_clim05 = uCfile->uwnd(4,lev_idx,:,:)
u_anom05 = u_201805 - u_clim05
copy_VarMeta(u_201805, u_anom05)

v_201805 = vdata(year2_idx(4),lev_idx,:,:)
v_clim05 = vCfile->vwnd(4,lev_idx,:,:)
v_anom05 = v_201805 - v_clim05
copy_VarMeta(v_201805, v_anom05)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res@mpLimitMode = "LatLon"
res@mpMinLatF = 0
res@mpMaxLatF = 40
res@mpMinLonF = 80
res@mpMaxLonF = 150


res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res@mpOutlineOn              = True
res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last

res@mpOutlineSpecifiers = (/"China:Zhejiang"/)
res@mpMaskAreaSpecifiers = (/"China:Zhejiang"/)
res@mpPerimOn   = True

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(-40,40,10) 


res@lbOrientation="Vertical"

res@isShowProvince = False
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@boundaryColor = "black"
res@boundaryThickness = 1
setup_china_map(res)


resvc= True
resvc@gsnDraw=False
resvc@gsnFrame=False
resvc@gsnLeftString=""
resvc@gsnRightString=""
resvc@vcRefMagnitudeF  = 3
resvc@vcRefLengthF     = 0.02

resvc@vcGlyphStyle="LineArrow"
resvc@vcLineArrowThicknessF=2.6

resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "3"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -0.11
resvc@vcRefAnnoParallelPosF     = 0.999
resvc@vcRefAnnoBackgroundColor  = "green"
resvc@vcVectorDrawOrder         = "PostDraw"
resvc@vcFillArrowWidthF=0.05
resvc@vcFillArrowHeadYF=0.07

resvc@vcMonoFillArrowFillColor =True
resvc@vcFillArrowFillColor = "black"
resvc@vcFillArrowEdgeColor = "white"



wks = gsn_open_wks("eps", "May-olr-latlon-wind")
gsn_define_colormap(wks,"MPL_coolwarm")

map = gsn_csm_contour_map(wks, hgt_anom05, res)
map2 = gsn_csm_vector(wks, u_anom05,v_anom05, resvc)
overlay(map, map2)

attach_china_map(wks, map)

draw(map)
frame(wks)
  
