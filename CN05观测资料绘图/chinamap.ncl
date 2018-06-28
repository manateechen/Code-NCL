load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

datafile=addfile("tm_mon.nc","r")

tm=datafile->tm
lat=datafile->lat
lon=datafile->lon

map=tm(0,:,:)
map @_FillValue=0

do i=0,162
  do j=0,282

    if(.not.ismissing(map(i,j))) then
      map(i,j)=1
    end if
  end do
end do
copy_VarMeta(tm(0,:,:),map)
map @_FillValue=0

setfileoption("nc","Format","LargeFile")
out=addfile("chinamap25.nc","c")
out->map=map
out->lat=lat
out->lon=lon
