resp = True
resp@gsLineColor      = "gray" ; polylines color
resp@gsLineThicknessF = 2    ; polylines thickness

f=asciiread("tibet_ASCII.wmp",(/2066,2/),"float")

poli=gsn_add_polyline(wks,map,f(:,0),f(:,1),resp)

draw(map)
frame(wks)