#!/bin/sh

for ii in 01 02 03 04 05 06 07 08 09 10 11 12
do
	sed -i "8s/^.*.$/cloudfile=addfile\(\".\/cosp\/cltisccp\_$ii.nc\", \"r\"\)/" ./cltisccp.ncl
	sed -i "36s/^.*.$/res@gsnLeftString        = \"cltisccp\_$ii\_WRF\"/" ./cltisccp.ncl
	sed -i "67s/^.*.$/wks = gsn_open_wks\(\"eps\", \"cltisccp\_model\_$ii\"\)/" ./cltisccp.ncl
	ncl ./cltisccp.ncl
done
