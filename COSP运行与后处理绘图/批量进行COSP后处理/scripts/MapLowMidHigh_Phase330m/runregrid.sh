#!/bin/bash

for ii in cllcalipso_liq clmcalipso_liq clhcalipso_liq cltcalipso_liq cllcalipso_ice clmcalipso_ice clhcalipso_ice cltcalipso_ice cllcalipso_un clmcalipso_un clhcalipso_un cltcalipso_un cllcalipso_RPIC clmcalipso_RPIC clhcalipso_RPIC cltcalipso_RPIC
do
	sed -i "13s/^.*.$/var=globalfile->$ii/" ./regrid.ncl
	sed -i "33s/^.*.$/out=addfile\(\"$ii\_WRF.nc\",\"c\"\)/" ./regrid.ncl
	sed -i "34s/^.*.$/out->$ii=temp_regrid/" ./regrid.ncl
	sed -i "86s/^.*.$/res@gsnLeftString = \"$ii\_\"+month\(i\)/" ./regrid.ncl
	sed -i "87s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$ii\_obs\_\"+month\(i\)\)/" ./regrid.ncl
	ncl ./regrid.ncl
	rm -rf dst_SCRIP.nc PET0.RegridWeightGen.Log src_SCRIP.nc wgt.nc
done
