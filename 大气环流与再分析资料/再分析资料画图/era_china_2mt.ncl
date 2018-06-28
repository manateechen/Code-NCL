load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

datafile=addfile("2mt.nc","r")
chinamap=addfile("chinamap25.nc","r")

PRE=short2flt(datafile->t2m)
lon=datafile->longitude
lat=datafile->latitude
map=chinamap->map
maplat=chinamap->lat
maplon=chinamap->lon

pre=new((/92,163,283/),"float")

pre=linint2_Wrap(lon,lat(::-1),PRE(:,::-1,:),True,maplon,maplat,0)
do i=0,162
  do j=0,282
     if(ismissing(map(i,j)))then
       pre(:,i,j)=-999999
     end if
   end do
end do
pre@_FillValue=-999999

setfileoption("nc","Format","LargeFile")
out=addfile("erat2m.nc","c")
out->2mt=pre
out->lat=maplat
out->lon=maplon
print("pre")

