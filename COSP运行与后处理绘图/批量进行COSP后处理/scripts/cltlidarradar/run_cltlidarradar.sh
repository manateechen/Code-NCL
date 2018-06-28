#!/bin/sh

for ii in 01 02 03 04 05 06 07 08 09 10 11 12
do
	sed -i "8s/^.*.$/cloudfile=addfile\(\".\/cosp\/cltlidarradar\_$ii.nc\", \"r\"\)/" ./cltlidarradar.ncl
	sed -i "36s/^.*.$/res@gsnLeftString        = \"cltlidarradar\_$ii\_WRF\"/" ./cltlidarradar.ncl
	sed -i "67s/^.*.$/wks = gsn_open_wks\(\"eps\", \"cltlidarradar\_model\_$ii\"\)/" ./cltlidarradar.ncl
	ncl ./cltlidarradar.ncl
done
