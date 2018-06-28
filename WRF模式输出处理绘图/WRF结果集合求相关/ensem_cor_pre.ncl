load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

  ensemblefile01=addfile("all_pre_01.nc","r")

  c01=ensemblefile01->c0101
  c02=ensemblefile01->c0201
  c03=ensemblefile01->c0301
  c04=ensemblefile01->c0401
  c05=ensemblefile01->c0501
  c06=ensemblefile01->c0601
  c07=ensemblefile01->c0701
  c08=ensemblefile01->c0801
  c09=ensemblefile01->c0901
  c10=ensemblefile01->c1001
  c11=ensemblefile01->c1101
  c13=ensemblefile01->c1301
  c14=ensemblefile01->c1401
  
f = addfile("chinamap25.nc","r")
lat=f->lat
lon=f->lon
map=f->map
ny=dimsizes(lat)
nx=dimsizes(lon)

f1=addfile("./case01/wrfout_d01_1998-06-16_00:00:00","r")
xlat = wrf_user_getvar(f1,"XLAT",0)
xlon = wrf_user_getvar(f1,"XLONG",0)

c01@lat2d = xlat
c01@lon2d = xlon
pre_c01=rcm2rgrid_Wrap(xlat,xlon,c01,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c01(i,j)=pre_c01@_FillValue
     end if
   end do
end do

c02@lat2d = xlat
c02@lon2d = xlon
pre_c02=rcm2rgrid_Wrap(xlat,xlon,c02,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c02(i,j)=pre_c02@_FillValue
     end if
   end do
end do

c03@lat2d = xlat
c03@lon2d = xlon
pre_c03=rcm2rgrid_Wrap(xlat,xlon,c03,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c03(i,j)=pre_c03@_FillValue
     end if
   end do
end do

c04@lat2d = xlat
c04@lon2d = xlon
pre_c04=rcm2rgrid_Wrap(xlat,xlon,c04,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c04(i,j)=pre_c04@_FillValue
     end if
   end do
end do

c05@lat2d = xlat
c05@lon2d = xlon
pre_c05=rcm2rgrid_Wrap(xlat,xlon,c05,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c05(i,j)=pre_c05@_FillValue
     end if
   end do
end do

c06@lat2d = xlat
c06@lon2d = xlon
pre_c06=rcm2rgrid_Wrap(xlat,xlon,c06,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c06(i,j)=pre_c06@_FillValue
     end if
   end do
end do

c07@lat2d = xlat
c07@lon2d = xlon
pre_c07=rcm2rgrid_Wrap(xlat,xlon,c07,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c07(i,j)=pre_c07@_FillValue
     end if
   end do
end do

c08@lat2d = xlat
c08@lon2d = xlon
pre_c08=rcm2rgrid_Wrap(xlat,xlon,c08,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c08(i,j)=pre_c08@_FillValue
     end if
   end do
end do

c09@lat2d = xlat
c09@lon2d = xlon
pre_c09=rcm2rgrid_Wrap(xlat,xlon,c09,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c09(i,j)=pre_c09@_FillValue
     end if
   end do
end do

c10@lat2d = xlat
c10@lon2d = xlon
pre_c10=rcm2rgrid_Wrap(xlat,xlon,c10,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c10(i,j)=pre_c10@_FillValue
     end if
   end do
end do

c11@lat2d = xlat
c11@lon2d = xlon
pre_c11=rcm2rgrid_Wrap(xlat,xlon,c11,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c11(i,j)=pre_c11@_FillValue
     end if
   end do
end do

c13@lat2d = xlat
c13@lon2d = xlon
pre_c13=rcm2rgrid_Wrap(xlat,xlon,c13,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c13(i,j)=pre_c13@_FillValue
     end if
   end do
end do

c14@lat2d = xlat
c14@lon2d = xlon
pre_c14=rcm2rgrid_Wrap(xlat,xlon,c14,lat,lon, 1)
do i=0,ny-1
  do j=0,nx-1
     if(ismissing(map(i,j)))then
       pre_c14(i,j)=pre_c14@_FillValue
     end if
   end do
end do

ensemble=(pre_c01+pre_c02+pre_c03+pre_c04+pre_c05+pre_c06+pre_c07+pre_c08+pre_c09+pre_c10+pre_c11+pre_c13+pre_c14)/13.0
best=(pre_c03+pre_c08+pre_c10+pre_c08)/4.0

f2 = addfile("climate_pre.nc","r")
obs=dim_avg_n_Wrap(f2->pre(15:21,:,:),0)

cor_01=pattern_cor(obs,pre_c01,1.0,1)
cor_02=pattern_cor(obs,pre_c02,1.0,1)
cor_03=pattern_cor(obs,pre_c03,1.0,1)
cor_04=pattern_cor(obs,pre_c04,1.0,1)
cor_05=pattern_cor(obs,pre_c05,1.0,1)
cor_06=pattern_cor(obs,pre_c06,1.0,1)
cor_07=pattern_cor(obs,pre_c07,1.0,1)
cor_08=pattern_cor(obs,pre_c08,1.0,1)
cor_09=pattern_cor(obs,pre_c09,1.0,1)
cor_10=pattern_cor(obs,pre_c10,1.0,1)
cor_11=pattern_cor(obs,pre_c11,1.0,1)
cor_13=pattern_cor(obs,pre_c13,1.0,1)
cor_14=pattern_cor(obs,pre_c14,1.0,1)
cor_en=pattern_cor(obs,ensemble,1.0,1)
cor_bt=pattern_cor(obs,best,1.0,1)

print(cor_01)
print(cor_02)
print(cor_03)
print(cor_04)
print(cor_05)
print(cor_06)
print(cor_07)
print(cor_08)
print(cor_09)
print(cor_10)
print(cor_11)
print(cor_13)
print(cor_14)
print(cor_en)
print(cor_bt)
