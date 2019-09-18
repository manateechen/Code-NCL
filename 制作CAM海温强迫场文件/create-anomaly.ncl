



f1 = addfile("anomaly.nc","r")
latitude = f1->latitude(::-1)
longitude = lonFlip(f1->longitude)
anomaly = lonFlip(f1->anomaly(::-1,:))
longitude(180:) = longitude(180:)+360.0

f2 = addfile("sst_HadOIBl_bc_1x1_clim_c101029.nc","r")
lon = f2->lon
lat = f2->lat
sst = f2->SST_cpl

sst_anomaly = linint2_Wrap(longitude,latitude,anomaly,True,lon,lat,1)
copy_VarMeta(sst(0,:,:),sst_anomaly)
do ii = 0, dimsizes(sst_anomaly(:,0))-1
do jj = 0, dimsizes(sst_anomaly(0,:))-1
if(ismissing(sst_anomaly(ii,jj))) then
sst_anomaly(ii,jj) = 0
end if
end do
end do


anom1 = sst_anomaly

idxLat1 = ind(latitude.le.20.0.or.latitude.ge.70.0)
idxLon1 = ind(longitude.le.275.0.or.longitude.ge.350.0)


anom1(idxLat1,:)=0
anom1(:,idxLon1)=0

sst2 = sst

do ii = 0,11
sst2(ii,:,:) = sst(ii,:,:) + anom1 
end do
copy_VarMeta(sst,sst2)


out = addfile("P1.nc","w")
out->SST_cpl = sst2

