load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/dailymean/"

tfile = addfile(root+"air.2017.nc", "r")
tCfile = addfile(root+"air.day.1981-2010.ltm.nc", "r")

myyear = 2017

lev = tfile->level

lat = tfile->lat
lon = tfile->lon

lat_idx = ind(lat.ge.27.and.lat.le.32)
;lon_idx = ind(lon.ge.0.and.lon.le.0)

year=calendar_decode2(tfile->time,0)
year_idx=ind(year(:,0).eq.myyear)

tdata = tfile->air(212:240,:,:,:)
tCdata = tCfile->air(212:240,:,:,:)

t_anom = tdata - tCdata

t_anom_lonlev = dim_avg_n_Wrap(t_anom(:,:,lat_idx,:), 2)
copy_VarMeta(tdata(:,:,0,:), t_anom_lonlev)



res = True
res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=True
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""

res@cnFillOn=True
res@cnLinesOn=False
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=fspan(-4,4,17) 

res@trYReverse= True

wks = gsn_open_wks("eps", "May-tem-lonlev-8-2-30")

map = gsn_csm_contour(wks, dim_avg_n_Wrap(t_anom_lonlev(:,0:11,:),0), res)

low = lev(0)                                                                             
high = lev(11)                                                                                  
left = 118.                                                                                  
right = 123.                                                                  
ypts = (/ low,  low, high ,  high, low/)                                        
xpts = (/left, right, right, left, left/)                                       
resc=True                                                                                           
resc@gsLineColor      = "black"     
resc@gsLineThicknessF = 3.0       
dumm = new(4,graphic)                            
do i = 0 , 3   
    dumm(i)=gsn_add_polyline(wks,map,xpts(i:i+1),ypts(i:i+1),resc)
end do  



draw(map)
frame(wks)
  