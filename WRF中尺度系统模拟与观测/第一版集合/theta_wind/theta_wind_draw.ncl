load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

scheme="SBU_EVAP5"
schemefile=addfile(scheme+".nc","r")

theta=schemefile->theta_point(:,:,0)
uwind=schemefile->uwind_point(:,:,0)
vwind=schemefile->vwind_point(:,:,0)
wspd=sqrt(uwind*uwind+vwind*vwind)
copy_VarMeta(uwind,wspd)

type              = "pdf"
wks = gsn_open_wks(type,scheme)
gsn_define_colormap(wks,"WhBlGrYeRe")

res                = True                    
res@gsnDraw        = False          ; do not draw
res@gsnFrame       = False          ; do not advance the frame
res@gsnLeftString = ""
res@gsnRightString = ""
res@vpWidthF=0.60
res@vpHeightF=0.35
res@tiMainString=scheme
res@cnFillOn=True
res@tmXBMode = "Explicit"
res@tmXBValues = ispan(0,8,1)
res@tmXBLabels = (/"12","15","18","21","00","03","06","09","12"/)
res@tmYLMode = "Explicit"
res@tmYLValues = fspan(0.0,3.0,7)
res@tmYLLabels=ispan(3000,0,500)
res@tiYAxisString = "Height (m; MSL)"
res@tiYAxisFontHeightF=0.015
res@lbOrientation           = "vertical" 
res@lbLabelConstantSpacingF=1
res@lbLabelFontHeightF=0.01
res@cnLevelSelectionMode="ExplicitLevels"
res@cnLevels=(/296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311/)
res@gsnSpreadColors      = True                  ; use full colormap
res@gsnSpreadColorStart  = 25                   ; start at color 10
res@gsnSpreadColorEnd    = 96                    ; end at color 96
res@gsnMaximize=True
res@cnLinesOn=False
res@trYReverse     = True

vcres                = True                    
vcres@gsnDraw        = False          ; do not draw
vcres@gsnFrame       = False          ; do not advance the frame
vcres@gsnLeftString = ""
vcres@gsnRightString = ""
vcres@vcGlyphStyle   = "WindBarb"     ; select wind barbs 
vcres@vcRefLengthF   = 0.045          ; define length of vec ref
vcres@vcRefAnnoOn    = False          ; turn off ref wind barb
vcres@vcMonoWindBarbColor     = True            ; color barbs by scalar
vcres@vcWindBarbLineThicknessF= 1.5              ; set the wind barb thickness
vcres@lbLabelBarOn=False
vcres@vcMinDistanceF=0.02
vcres@vcMapDirection = False

plot = gsn_csm_contour(wks,theta(interp_levels|:,Time|::3),res) 
plotvc = gsn_csm_vector_scalar(wks,uwind(interp_levels|:,Time|::3),vwind(interp_levels|:,Time|::3),wspd(interp_levels|:,Time|::3),vcres)
overlay(plot,plotvc)
draw(plot)                      ; draw the plot
frame(wks)                        ; advance the frame
