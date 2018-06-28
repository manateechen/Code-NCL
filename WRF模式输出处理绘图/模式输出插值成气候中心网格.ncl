load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

datafile=addfile("dailypre.nc","r")
chinamap=addfile("chinamap25.nc","r")

pre=datafile->pre
lon=datafile->lon
lat=datafile->lat
lattrans=ndtooned(lat)
lontrans=ndtooned(lon)
pretrans=new((/92,404721/),"float")

print("fuck one")
do i=0,91
  pretrans(i,:)=ndtooned(pre(i,:,:))
end do
map=chinamap->map
maplat=chinamap->lat
maplon=chinamap->lon

newpre=new((/92,163,283/),"float")
rscan = (/2, 1/) 

print("fuck two")
do i=0,91
  newpre(i,:,:)=obj_anal_ic_Wrap(lontrans,lattrans,pretrans(i,:),maplon,maplat,rscan,False)
  print(i)
end do
;newpre=linint2_Wrap(lon,lat,pre,False,maplon,maplat,0)
;printVarSummary(newpre)

print("fuck three")
do i=0,162
  do j=0,282
     if(ismissing(map(i,j)))then
       newpre(:,i,j)=-999999
     end if
   end do
end do
newpre@_FillValue=-999999
print("fuck four")
setfileoption("nc","Format","LargeFile")
out=addfile("newdailypre.nc","c")
out->pre=newpre
out->lat=maplat
out->lon=maplon
print("pre")
