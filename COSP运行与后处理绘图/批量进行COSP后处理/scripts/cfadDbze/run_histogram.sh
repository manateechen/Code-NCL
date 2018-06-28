#!/bin/sh

for ii in 01 02 03 04 05 06 07 08 09 10 11 12
do
	sed -i "7s/^.*.$/cldfilenamelist=systemfunc\(\"ls cosp\/cfadDbze94\_$ii.nc\"\)/" ./histogram.ncl
	sed -i "35s/^.*.$/res@gsnLeftString        = \"$ii\"/" ./histogram.ncl
	sed -i "57s/^.*.$/wks = gsn_open_wks\(\"eps\", \"cfadDbze94\_$ii\"\)/" ./histogram.ncl
	ncl ./histogram.ncl
done
