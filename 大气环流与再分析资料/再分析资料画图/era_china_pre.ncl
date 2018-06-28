load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

datafile=addfile("pre.nc","r")
chinamap=addfile("chinamap25.nc","r")

tmp=short2flt(datafile->tp)
PRE=tmp*1000
copy_VarMeta(tmp,PRE)
lon=datafile->longitude
lat=datafile->latitude
map=chinamap->map
maplat=chinamap->lat
maplon=chinamap->lon

pretmp=new((/92,241,480/),"float")
pre=new((/92,163,283/),"float")

do i=0,91
  pretmp(i,:,:)=PRE(i*2+61,:,:)+PRE(i*2+61+1,:,:)
end do

pre=linint2_Wrap(lon,lat(::-1),pretmp(:,::-1,:),True,maplon,maplat,0)
do i=0,162
  do j=0,282
     if(ismissing(map(i,j)))then
       pre(:,i,j)=-999999
     end if
   end do
end do
pre@_FillValue=-999999

setfileoption("nc","Format","LargeFile")
out=addfile("eradailypre.nc","c")
out->pre=pre
out->lat=maplat
out->lon=maplon
print("pre")

