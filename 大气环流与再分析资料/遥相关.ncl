load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl" 

path = "hgt.mon.mean.nc"
data = addfile(path,"r")
lev  = data->level
lat  = data->lat
lon  = data->lon
ti   = data->time

dim_lev = dimsizes(lev)
dim_lon = dimsizes(lon)
dim_lat = dimsizes(lat)
dim_tim = dimsizes(ti)/12*12

tim = ut_calendar(ti(0:dim_tim-1),4)

ind_500 = ind(lev.eq.500)

hgt = data->hgt(0:dim_tim-1,ind_500,:,:)

HGT = hgt(0::12,:,:)
ind_55n=ind(lat.eq.55)
ind_55w=ind(lon.eq.55)
ind_30n=ind(lat.eq.30)

wa=0.25*(HGT(:,ind_55n,ind_55w)-HGT(:,ind_30n,ind_55w))

cor=new((/dim_lat,dim_lon/),float)
do i=0,dim_lat-1
  do j=0,dim_lon-1
    cor(i,j)=escorc(HGT(:,i,j),wa)
  end do
end do
copy_VarCoords(HGT(0,:,:),cor)

res = True
res @gsnSpreadColors=True
res @gsnAddCyclic=True
res @gsnMaximize=True
res @cnFillOn=True
res @cnLinesOn=False
res @lbLabelBarOn         = True
res @lbOrientation       = "Vertical"

resxy = True
resxy @xyLineThicknessF = 2.0

wks=gsn_open_wks("x11","WA")

plot=gsn_csm_contour_map(wks,cor,res)
plot=gsn_csm_xy(wks,tim(0::12),wa,resxy)















