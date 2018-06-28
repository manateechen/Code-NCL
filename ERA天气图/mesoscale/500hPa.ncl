load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

file1=addfile("pressurelevel.nc","r")
lev_ind=ind(file1->level.eq.500)

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

div_tmp=short2flt(file1->d(:,lev_ind,:,:))
div=div_tmp*10E5
copy_VarMeta(div_tmp,div)
delete(div_tmp)
printVarSummary(div)

uwind=short2flt(file1->u(:,lev_ind,:,:))
vwind=short2flt(file1->v(:,lev_ind,:,:))

time=file1->time
nt=dimsizes(time)
print(nt)
time_string=cd_calendar(time,-3)

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
res@cnLevels=ispan(-50,50,10)
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
res@mpGridMaxLatF =40
res@mpGridSpacingF=5
res@pmTickMarkDisplayMode = "Always"         
res@mpLimitMode = "Corners"
res@mpLeftCornerLatF = 15
res@mpLeftCornerLonF = 100
res@mpRightCornerLatF = 30
res@mpRightCornerLonF = 125


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
res_z@cnLineThicknessF=7.0
res_z@cnLevelSelectionMode = "ExplicitLevels"
res_z@cnLevels=ispan(500,620,2)

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
res_t@cnLineThicknessF=7.0
res_t@cnLineLabelFontHeightF=0.015
res_t@cnLineLabelFontColor="red"
res_t@cnLevelSelectionMode = "ExplicitLevels"
res_t@cnLevels=ispan(-80,4,1)
res_t@cnLineLabelBackgroundColor=0

res_vc=True
res_vc@gsnDraw         = False
res_vc@gsnFrame        = False
res_vc@gsnLeftString = ""
res_vc@gsnRightString = ""
res_vc@vcGlyphStyle   = "WindBarb"
res_vc@vcMonoWindBarbColor     = True 
res_vc@vcMinDistanceF=0.025
res_vc@vcRefAnnoOn    = False
res_vc@vcRefLengthF   = 0.013

do ii=0, nt-1
res_z@tiMainString=time_string(ii)
wks = gsn_open_wks("pdf", "500hPa"+time_string(ii))  ; Open graphics file
gsn_define_colormap(wks,"MPL_bwr")
gsn_reverse_colormap(wks)
plot=gsn_csm_contour_map(wks,div(ii,:,:),res)
plot01 = gsn_csm_contour(wks,smth9_Wrap(z(ii,:,:),0.25,0.25,True),res_z)
plot02=gsn_csm_contour(wks,smth9_Wrap(t(ii,:,:),0.25,0.25,True),res_t)
plot03=gsn_csm_vector(wks,uwind(ii,:,:),vwind(ii,:,:),res_vc)
overlay(plot,plot01)
overlay(plot,plot02)
overlay(plot,plot03)
attach_china_map(wks, plot)
draw(plot)
delete(wks)
end do
