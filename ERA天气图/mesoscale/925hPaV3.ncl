load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

file1=addfile("pressurelevel.nc","r")
file2=addfile("test.nc","r")
lev_ind=ind(file1->level.eq.925)

z_tmp=short2flt(file1->z(:,lev_ind,:,:))
z=z_tmp/9.8/10.0
copy_VarMeta(z_tmp,z)
delete(z_tmp)
printVarSummary(z)

t_tmp=short2flt(file1->t(:,lev_ind,:,:))
t=t_tmp-273.16
copy_VarMeta(t_tmp,t)
delete(t_tmp)
printVarSummary(t)

uwind=short2flt(file1->u(:,lev_ind,:,:))
vwind=short2flt(file1->v(:,lev_ind,:,:))

time=file1->time
nt=dimsizes(time)
print(nt)
time_string=cd_calendar(time,-3)

nlat=dimsizes(file1->latitude)
nlon=dimsizes(file1->longitude)

lat=file1->latitude
lon=file1->longitude

T_adv=file2->T_adv
copy_VarMeta(t,T_adv)

res=True
res@gsnDraw         = False
res@gsnFrame        = False
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnMaximize=True
res@tiMainOffsetYF=-0.04
res@tiMainFontHeightF=0.02
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@cnFillOn=True
res@gsnSpreadColors=True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(-20,20,5)
res@lbOrientation       = "Vertical"

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isAddMask = False
res@isShowRivers = False
res@riverColor = "gray"
res@riverThickness = 0.5
res@boundaryColor = "black"
res@boundaryThickness = 0.2
setup_china_map(res)

res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res@mpOutlineOn              = True
res@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last
res@mpGridAndLimbOn       = True                ; Turn off lat/lon lines
res@mpGridLineDashPattern       = 2
res@mpGridMaxLatF =60
res@mpGridSpacingF=10
res@pmTickMarkDisplayMode = "Always"         
res@mpLambertParallel1F = 30
res@mpLambertParallel2F = 60
res@mpLambertMeridianF = 110
res@mpCenterLonF =        110
res@mpCenterLatF =        22.5                                                                                           
res@mpLimitMode = "LatLon"
res@mpMaxLonF=125
res@mpMaxLatF=35
res@mpMinLonF=95
res@mpMinLatF=10



res_z                 = True
res_z@gsnDraw         = False
res_z@gsnFrame        = False
res_z@gsnLeftString = ""
res_z@gsnRightString = ""
res_z@cnLinesOn       = True
res_z@cnLineLabelsOn  = True
res_z@cnInfoLabelOn   = False
res_z@cnLineLabelFontHeightF=0.015
res_z@cnLineColor="blue"
res_z@cnLineThicknessF=3.0
res_z@cnLevelSelectionMode = "ExplicitLevels"
res_z@cnLevels=ispan(20,200,4)

res_t                 = True
res_t@gsnDraw         = False
res_t@gsnFrame        = False
res_t@gsnLeftString = ""
res_t@gsnRightString = ""
res_t@cnLinesOn       = True
res_t@cnLineLabelsOn  = True
res_t@cnInfoLabelOn   = False
res_t@cnLineColor="red"
res_t@cnLineDashPattern=1
res_t@cnLineThicknessF=3.0
res_t@cnLineLabelFontHeightF=0.015
res_t@cnLineLabelFontColor="red"
res_t@cnLevelSelectionMode = "ExplicitLevels"
res_t@cnLevels=ispan(-40,40,4)
res_t@cnLineLabelBackgroundColor=0

res_vc=True
res_vc@gsnDraw         = False
res_vc@gsnFrame        = False
res_vc@gsnLeftString = ""
res_vc@gsnRightString = ""
res_vc@vcGlyphStyle   = "WindBarb"
res_vc@vcMonoWindBarbColor     = True 
res_vc@vcMinDistanceF=0.03
res_vc@vcRefAnnoOn    = False
res_vc@vcRefLengthF   = 0.03
res_vc@vcWindBarbLineThicknessF = 3.0

do ii=0, nt-1
res_z@tiMainString=time_string(ii)
wks = gsn_open_wks("pdf", "925hPa"+time_string(ii))  ; Open graphics file
gsn_define_colormap(wks,"MPL_bwr")
plot=gsn_csm_contour_map(wks,T_adv(ii,:,:),res)
plot01 = gsn_csm_contour(wks,z(ii,:,:),res_z)
plot02=gsn_csm_contour(wks,t(ii,:,:),res_t)
plot03=gsn_csm_vector(wks,uwind(ii,:,:),vwind(ii,:,:),res_vc)
overlay(plot,plot01)
overlay(plot,plot02)
overlay(plot,plot03)
attach_china_map(wks, plot)
draw(plot)
delete(wks)
end do
