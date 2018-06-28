#!/bin/sh

for ii in 01 02 03 04 05 06 07 08 09 10 11 12
do
	sed -i "7s/^.*.$/cldfilenamelist=systemfunc\(\"ls cosp\/cfadLidarsr532\_$ii.nc\"\)/" ./cladLidar.ncl
	sed -i "36s/^.*.$/res@gsnLeftString        = \"$ii\"/" ./cladLidar.ncl
	sed -i "58s/^.*.$/wks = gsn_open_wks\(\"eps\", \"cfadLidarsr532\_$ii\"\)/" ./cladLidar.ncl
	ncl ./cladLidar.ncl
done
