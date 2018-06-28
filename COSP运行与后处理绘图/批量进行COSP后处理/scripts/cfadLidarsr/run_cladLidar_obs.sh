#!/bin/sh

for ii in 01 02 03 04 05 06 07 08 09 10 11 12
do
	sed -i "5s/^.*.$/globalfile=addfile\(\"\/home2_hn\/qf\/wrf-cosp\/cloud_obs\/cfadLidarsr532_obs4cmip5_CALIOP_L3_CALIPSO-GOCCP-v2.1_2007${ii}15_2007${ii}15.nc\",\"r\"\)/" ./cladLidar_obs.ncl
	sed -i "80s/^.*.$/res@gsnLeftString        = \"$ii\"/" ./cladLidar_obs.ncl
	sed -i "81s/^.*.$/wks = gsn_open_wks\(\"eps\", \"cfadLidarsr532\_obs\_$ii\"\)/" ./cladLidar_obs.ncl
	ncl ./cladLidar_obs.ncl
	rm -rf dst_SCRIP.nc PET0.RegridWeightGen.Log src_SCRIP.nc wgt.nc
done
