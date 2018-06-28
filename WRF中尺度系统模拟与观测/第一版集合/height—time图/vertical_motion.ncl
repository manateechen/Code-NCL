load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

filenames=systemfunc("ls /home2_hn/QQF/MCS/2014/SBU_YSU/ver/*")
print(filenames)

zz=(/1, 2, 3, 5, 7, 10, 20, 30, 50, 70, 100, 125, 150, 175, 200, 225, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 775, 800, 825, 850, 875, 900, 925, 950, 975, 1000/) ;unit:hpa
zz@units="hPa"

f=addfiles(filenames,"r")
ListSetType (f, "join")  
wa=f[:]->wa
wa!0="time"
wa!1="lev"
wa&lev=zz
printVarSummary(wa)



wks   = gsn_open_wks ("eps", "h_time") 
gsn_define_colormap(wks,"BlWhRe")

res                      = True                  ; plot mods desired
  
  res@cnFillOn             = True                  ; turn on color
  res@cnLinesOn            = False                 ; no contour lines

;---This resource not needed in V6.1.0
  res@gsnSpreadColors      = True                  ; use full range of colors

;---This resource defaults to True in NCL V6.1.0
  res@lbLabelAutoStride    = True                  ; optimal labels
res@gsnMaximize=True  

res@cnLevelSelectionMode = "ManualLevels"       ; set manual contour levels
  res@cnMinLevelValF       = -1.2                  ; set min contour level
  res@cnMaxLevelValF       =  1.2                  ; set max contour level
  res@cnLevelSpacingF      = 0.2                  ; set contour spacing
  
plot = gsn_csm_pres_hgt (wks,wa(lev|14:,time|0:200),res) 
