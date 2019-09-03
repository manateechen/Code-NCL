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

qinfile = addfile(root+"shum.mon.mean.nc", "r")
qCfile = addfile(root+"shum.mon.1981-2010.ltm.nc", "r")

mylev = 850
myyear = 2017

lev = uinfile->level

lat = uinfile->lat
lon = uinfile->lon

year=calendar_decode2(uinfile->time,0)
year_idx=ind(year(:,0).eq.myyear)

lev_idx = ind(lev.eq.mylev)

udata = uinfile->uwnd
vdata = vinfile->vwnd
qdata = qinfile->shum

u_201805 = udata(year_idx(6:7),lev_idx,:,:)
u_clim05 = uCfile->uwnd(6:7,lev_idx,:,:)
u_anom05 = u_201805 - u_clim05
copy_VarMeta(u_201805, u_anom05)

v_201805 = vdata(year_idx(6:7),lev_idx,:,:)
v_clim05 = vCfile->vwnd(6:7,lev_idx,:,:)
v_anom05 = v_201805 - v_clim05
copy_VarMeta(v_201805, v_anom05)

q_201805 = qdata(year_idx(6:7),lev_idx,:,:)
q_clim05 = qCfile->shum(6:7,lev_idx,:,:)
q_anom05 = q_201805 - q_clim05
copy_VarMeta(q_201805, q_anom05)

qu_201805 = q_201805 * u_201805 / 1000.0
qv_201805 = q_201805 * v_201805 / 1000.0
qdiv_201805 = uv2dv_cfd(qu_201805, qv_201805, lat, lon, 3)

qu_clim05 = q_clim05 * u_clim05 / 1000.0
qv_clim05 = q_clim05 * v_clim05 / 1000.0
qdiv_clim05 = uv2dv_cfd(qu_clim05, qv_clim05, lat, lon, 3)

copy_VarMeta(q_201805, qu_201805)
copy_VarMeta(q_201805, qv_201805)
copy_VarMeta(q_201805, qdiv_201805)

copy_VarMeta(q_clim05, qu_clim05)
copy_VarMeta(q_clim05, qv_clim05)
copy_VarMeta(q_clim05, qdiv_clim05)

qu_anom = qu_201805 - qu_clim05
qv_anom = qv_201805 - qv_clim05
qdiv_anom = dim_avg_n_Wrap(qdiv_201805,0) - dim_avg_n_Wrap(qdiv_clim05,0)
copy_VarMeta(q_201805, qu_anom)
copy_VarMeta(q_201805, qv_anom)
copy_VarMeta(q_201805(0,:,:), qdiv_anom)


res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

resvc = res

res@mpLimitMode = "LatLon"
res@mpMinLatF = 20
res@mpMaxLatF = 40
res@mpMinLonF = 105
res@mpMaxLonF = 125

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
res@cnLevels=fspan(-6,6,25)*1e-8

res@lbOrientation="Vertical"



res@isShowProvince = False
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@boundaryColor = "black"
res@boundaryThickness = 1
setup_china_map(res)

resvc@vcRefMagnitudeF  = 0.05
resvc@vcRefLengthF     = 0.02
resvc@vcGlyphStyle="LineArrow"
resvc@vcLineArrowThicknessF=2.6
resvc@vcRefAnnoOn               = True
resvc@vcRefAnnoString1          = "0.05"
resvc@vcRefAnnoSide             = "Top"
resvc@vcRefAnnoString2On        = False
resvc@vcRefAnnoPerimOn          = False
resvc@vcRefAnnoOrthogonalPosF   = -0.06
resvc@vcRefAnnoParallelPosF     = 0.999
resvc@vcRefAnnoBackgroundColor  = "green"
resvc@vcVectorDrawOrder         = "PostDraw"
resvc@vcFillArrowWidthF=0.05
resvc@vcFillArrowHeadYF=0.07
resvc@vcMonoFillArrowFillColor =True
resvc@vcFillArrowFillColor = "black"
resvc@vcFillArrowEdgeColor = "white"

wks = gsn_open_wks("eps", "May-"+mylev+"-water-div")
gsn_define_colormap(wks,"BlueRed")

;map = gsn_csm_contour_map(wks, dim_avg_n_Wrap(qdiv_anom,0), res)
map = gsn_csm_contour_map(wks, qdiv_anom, res)

map2 = gsn_csm_vector(wks, dim_avg_n_Wrap(qu_anom,0),dim_avg_n_Wrap(qv_anom,0), resvc)

overlay(map, map2)

attach_china_map(wks, map)

draw(map)
frame(wks)
  