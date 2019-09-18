load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

data = asciiread("./energy.txt", 12, "float")

x = fspan(0.5,5.5,6)
before = data(0:5)
after = data(6:)

labels = (/"SHF","LHF","USWRF","ULWRF", "SAT","ST10"/)

wks = gsn_open_wks("eps","energy-before")                  ; send graphics to PNG file
resbar                       = True         
;resbar@vpHeightF          = 0.35
;resbar@vpWidthF           = 0.20
;resbar@vpXF              = 0.7
;resbar@vpYF              = 0.45
resbar@vpHeightF = 0.4        ; Changes the aspect ratio
 resbar@vpWidthF  = 0.75
resbar@gsnFrame              = False    
resbar@gsnDraw = False    
resbar@gsnXYBarChart         = True         
resbar@gsnXYBarChartBarWidth = 0.7     
resbar@gsnXYBarChartColors2=(/"SkyBlue","blue","SlateBlue", \
  "green","orange","red"/) 
resbar@tmXBOn                = True    
resbar@tmXTOn                = False 
resbar@tmYROn                = False      
resbar@trYMinF               = -20
resbar@trYMaxF               = 20          
resbar@trXMinF               = 0            
resbar@trXMaxF               = 6
resbar@tiYAxisString=""
resbar@tiXAxisString=""
resbar@tiMainFontHeightF  = 0.018
resbar@tiYAxisFontHeightF = 0.018
resbar@tiXAxisFontHeightF = 0.018
resbar@tiMainString          = ""
resbar@tmXBLabelsOn=True
resbar@tmXBMode          = "Explicit"
resbar@tmXBValues =x
resbar@tmXBLabels=labels
resbar@gsnYRefLine           = 0. 
  plot = gsn_csm_xy (wks,x,before,resbar)                  ; create plot


draw(wks)
  frame(wks)

  delete(wks)

wks = gsn_open_wks("eps","energy-after") 
plot = gsn_csm_xy (wks,x,after,resbar)  
draw(wks)
  frame(wks)


