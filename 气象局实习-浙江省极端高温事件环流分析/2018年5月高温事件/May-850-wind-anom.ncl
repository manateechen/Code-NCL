load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

uinfile = addfile(root+"uwnd.mon.mean.nc", "r")
uCfile = addfile(root+"uwnd.mon.1981-2010.ltm.nc", "r")

vinfile = addfile(root+"vwnd.mon.mean.nc", "r")
vCfile = addfile(root+"vwnd.mon.1981-2010.ltm.nc", "r")

mylev = 850
myyear = 2018

lev = uinfile->level

lat = uinfile->lat
lon = uinfile->lon

year=calendar_decode2(uinfile->time,0)
year_idx=ind(year(:,0).eq.myyear)

lev_idx = ind(lev.eq.mylev)

udata = uinfile->uwnd
vdata = vinfile->vwnd

u_201805 = udata(year_idx(4),lev_idx,:,:)
u_clim05 = uCfile->uwnd(4,lev_idx,:,:)
u_anom05 = u_201805 - u_clim05
copy_VarMeta(u_201805, u_anom05)

v_201805 = vdata(year_idx(4),lev_idx,:,:)
v_clim05 = vCfile->vwnd(4,lev_idx,:,:)
v_anom05 = v_201805 - v_clim05
copy_VarMeta(v_201805, v_anom05)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
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

res@vcRefMagnitudeF  = 3
res@vcRefLengthF     = 0.02

res@vcGlyphStyle="LineArrow"
res@vcLineArrowThicknessF=2.6

res@vcRefAnnoOn               = True
res@vcRefAnnoString1          = "3"
res@vcRefAnnoSide             = "Top"
res@vcRefAnnoString2On        = False
res@vcRefAnnoPerimOn          = False
res@vcRefAnnoOrthogonalPosF   = -0.123
res@vcRefAnnoParallelPosF     = 0.999
res@vcRefAnnoBackgroundColor  = "green"
res@vcVectorDrawOrder         = "PostDraw"
res@vcFillArrowWidthF=0.05
res@vcFillArrowHeadYF=0.07

res@vcMonoFillArrowFillColor =True
res@vcFillArrowFillColor = "black"
res@vcFillArrowEdgeColor = "white"


res@isShowProvince = False
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@boundaryColor = "black"
res@boundaryThickness = 1
setup_china_map(res)

wks = gsn_open_wks("eps", "May-"+mylev+"-windanom")
gsn_define_colormap(wks,"BlueDarkRed18")

map = gsn_csm_vector_map(wks, u_anom05,v_anom05, res)


attach_china_map(wks, map)

draw(map)
frame(wks)
  
