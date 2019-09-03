load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

infile = addfile(root+"hgt.2018.nc", "r")

Cfile = addfile(root+"hgt.day.1981-2010.ltm.nc", "r")

mylev = 500
myyear = 2018

lev = infile->level
lat = infile->lat
lon = infile->lon

lev_idx = ind(lev.eq.mylev)
lat_idx = ind(lat.ge.27.and.lat.le.32)
lon_idx = ind(lon.ge.60.and.lon.le.210)

hgt_201805s = infile->hgt(120:150,lev_idx,:,:)
hgt_201805 = hgt_201805s / 10.0
copy_VarMeta(hgt_201805s, hgt_201805)

hgt_clim05 = Cfile->hgt(120:150,lev_idx,:,:)
hgt_clim05 = hgt_clim05 / 10.0
copy_VarMeta(hgt_201805s, hgt_clim05)

hgt_anom = hgt_201805 - hgt_clim05
copy_VarMeta(hgt_201805s, hgt_anom)

hgt_anom_timelon = dim_avg_n_Wrap(hgt_anom(:,lat_idx,lon_idx), 1)

tt = infile->time(120:150)

wks  = gsn_open_wks ("eps", "May-"+mylev+"-timelon" )           ; send graphics to PNG file
gsn_define_colormap(wks,"BlueDarkRed18")

res                      = True               ; plot mods desired
res@tiMainString         = "" 
res@gsnLeftString=""
res@gsnRightString=""
res@gsnDraw=False
res@gsnFrame=False

res@cnLinesOn = False
res@cnFillOn             = True               ; turn on color fill
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=(/-5,-4,-3,-2,-1,0,1,2,3,4,5/)*2.0
res@cnFillColors=(/4,5,6,7,8,0,0,13,14,15,16,17/)

res@tmYLMode      = "Explicit"          
res@tmYLValues    = tt(0)+(/  0. ,  4.,  9.,   14., 19., 24., 29 /)*24.0
res@tmYLLabels    = (/"1","5","10","15" ,"20","25", "30" /)

plot = gsn_csm_hov(wks, hgt_anom_timelon, res) 

low = tt(0)                                                                             
high = tt(dimsizes(tt)-1)                                                                                   
left = 118.                                                                                  
right = 123.                                                                  
ypts = (/ low,  low, high ,  high, low/)                                        
xpts = (/left, right, right, left, left/)                                       
resc=True                                                                                           
resc@gsLineColor      = "blue"     
resc@gsLineThicknessF = 3.0       
dumm = new(4,graphic)                            
do i = 0 , 3   
    dumm(i)=gsn_add_polyline(wks,plot,xpts(i:i+1),ypts(i:i+1),resc)
end do  

xpts2 = asciiread("wplon.txt", 31, "float")
ypts2 = tt
resc2=True                                                                                           
resc2@gsLineColor      = "black"     
resc2@gsLineThicknessF = 3.0   
resc2@gsLineDashPattern = 0
xy = gsn_add_polyline(wks,plot,xpts2,ypts2,resc2)

xpts3 = asciiread("wplon-clim.txt", 31, "float")
ypts3 = tt
resc3=True                                                                                           
resc3@gsLineColor      = "black"     
resc3@gsLineThicknessF = 3.0   
resc3@gsLineDashPattern = 16
xy2 = gsn_add_polyline(wks,plot,xpts3,ypts3,resc3)

draw(plot)
frame(wks)