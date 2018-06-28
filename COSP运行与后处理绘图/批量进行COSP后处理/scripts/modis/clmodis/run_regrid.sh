#!/bin/sh

for ii in 01 02 03 04 05 06 07 08 09 10 11 12
do
	sed -i "5s/^.*.$/globalfile=addfile\(\"\/home2_hn\/qf\/wrf-cosp\/cloud_obs\/MCD08_M3_NC.2007.$ii.C051.V02.nc\",\"r\"\)/" ./regrid.ncl
	sed -i "80s/^.*.$/res@gsnLeftString        = \"$ii\"/" ./regrid.ncl
	sed -i "81s/^.*.$/wks = gsn_open_wks\(\"eps\", \"clmodis_obs_$ii\"\)/" ./regrid.ncl
	ncl ./regrid.ncl
	rm -rf dst_SCRIP.nc PET0.RegridWeightGen.Log src_SCRIP.nc wgt.nc
done
