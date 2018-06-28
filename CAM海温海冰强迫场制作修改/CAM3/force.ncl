load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

f1 = addfile("raw.nc","r")
f2 = addfile("test.nc","w")

lat1=f1->lat
lon1=f1->lon
lat2=f2->lat
lon2=f2->lon

sst=f1->sst
ice=f1->ice

ice_regrid = linint2_Wrap(lon1,lat1,ice,True,lon2,lat2,0)
sst_regrid = linint2_Wrap(lon1,lat1,sst,True,lon2,lat2,0)
printVarSummary(ice_regrid)
printVarSummary(sst_regrid)
ice_regrid=ice_regrid/100.0

ice_cov = f2->ice_cov
sst_cpl = f2->SST_cpl
copy_VarCoords(ice_cov,ice_regrid)
copy_VarCoords(sst_cpl,sst_regrid)
f2->ice_cov = ice_regrid
f2->SST_cpl = sst_regrid

