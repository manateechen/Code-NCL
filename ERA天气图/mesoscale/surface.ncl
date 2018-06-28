load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

file1=addfile("surface.nc","r")

pressure_tmp=short2flt(file1->sp)
pressure=pressure_tmp/100.0
copy_VarMeta(pressure_tmp,pressure)
delete(pressure_tmp)
temperature_tmp=short2flt(file1->t2m)
temperature=temperature_tmp-273.16
copy_VarMeta(temperature_tmp,temperature)
delete(temperature_tmp)
uwind=short2flt(file1->u10)
vwind=short2flt(file1->v10)
time=file1->time
nt=dimsizes(time)
print(nt)
time_string=cd_calendar(time,-3)

res_p                 = True
res_p@gsnDraw         = False
res_p@gsnFrame        = False
res_p@gsnLeftString = ""
res_p@gsnRightString = ""
res_p@gsnMaximize=True
res_p@tiMainOffsetYF=-0.04
res_p@tiMainFontHeightF=0.02
res_p@cnLinesOn       = True
res_p@cnLineLabelsOn  = True
res_p@cnInfoLabelOn   = False
res_p@cnLineLabelFontHeightF=0.015
res_p@cnLineColor="blue"
res_p@cnLineThicknessF=7.0
res_p@cnLevelSelectionMode = "ExplicitLevels"
res_p@cnLevels=ispan(800,1200,40)

res_p@isShowProvince = True
res_p@isShowSouthChinaSea = False
res_p@isAddMask = False
res_p@isShowRivers = False
res_p@riverColor = "gray"
res_p@riverThickness = 0.5
res_p@boundaryColor = "black"
res_p@boundaryThickness = 0.2
setup_china_map(res_p)

res_p@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
res_p@mpOutlineOn              = True
res_p@mpOutlineDrawOrder    = "PostDraw"           ; Draw map outlines last
res_p@mpGridAndLimbOn       = True                ; Turn off lat/lon lines
res_p@mpGridLineDashPattern       = 2
res_p@mpGridMaxLatF =40
res_p@mpGridSpacingF=5
res_p@pmTickMarkDisplayMode = "Always"         
res_p@mpLimitMode = "Corners"
res_p@mpLeftCornerLatF = 15
res_p@mpLeftCornerLonF = 100
res_p@mpRightCornerLatF = 30
res_p@mpRightCornerLonF = 125

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
res_t@cnLevels=ispan(0,32,4)
res_t@cnLineLabelBackgroundColor=0

res_vc=True
res_vc@gsnDraw         = False
res_vc@gsnFrame        = False
res_vc@gsnLeftString = ""
res_vc@gsnRightString = ""
res_vc@vcGlyphStyle   = "WindBarb"
res_vc@vcMonoWindBarbColor     = True 
res_vc@vcRefMagnitudeF           = 5
res_vc@vcRefAnnoString1          = "5 m/s"
res_vc@vcRefAnnoSide             = "Top"
res_vc@vcRefAnnoString2On        = False
res_vc@vcRefAnnoPerimOn          = False
res_vc@vcRefAnnoOrthogonalPosF   = -0.1
res_vc@vcRefAnnoParallelPosF     = 0.999
res_vc@vcRefAnnoBackgroundColor  = "Green"
res_vc@vcMinDistanceF=0.03
res_vc@vcRefAnnoOn    = False
res_vc@vcRefLengthF   = 0.03
res_vc@vcWindBarbLineThicknessF = 3.0 

do ii=0,nt-1
res_p@tiMainString=time_string(ii)
wks = gsn_open_wks("pdf", "surface"+time_string(ii))  ; Open graphics file
gsn_define_colormap(wks,"OceanLakeLandSnow")
plot = gsn_csm_contour_map(wks,smth9_Wrap(pressure(ii,:,:),0.25,0.25,True),res_p)
plot01=gsn_csm_contour(wks,smth9_Wrap(temperature(ii,:,:),0.25,0.25,True),res_t)
plot02=gsn_csm_vector(wks,uwind(ii,:,:),vwind(ii,:,:),res_vc)
overlay(plot,plot01)
overlay(plot,plot02)
attach_china_map(wks, plot)
draw(plot)
delete(wks)
end do









