#!/bin/bash

for jj in clhcalipsoice clhcalipsoliq clhcalipsoun cllcalipsoice cllcalipsoliq cllcalipsoun clmcalipsoice clmcalipsoliq clmcalipsoun cltcalipsoice cltcalipsoliq cltcalipsoun 
do
	for ii in 01 02 03 04 05 06 07 08 09 10 11 12
	do
		sed -i "8s/^.*.$/cloudfile=addfile\(\".\/cosp\/$jj\_$ii.nc\", \"r\"\)/" ./calipso.ncl
		sed -i "14s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile->$jj,0\)/" ./calipso.ncl
		sed -i "36s/^.*.$/res@gsnLeftString = \"$jj\_$ii\_WRF\"/" ./calipso.ncl
		sed -i "67s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_model\_$ii\"\)/" ./calipso.ncl
		ncl ./calipso.ncl
		echo "calipso_WRF: $jj-$ii complete"
	done
	sed -i "8s/^.*.$/filelist=systemfunc\(\"ls .\/cosp\/$jj\_*.nc\"\)/" ./calipso_year.ncl
	sed -i "16s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile[\:]->$jj,0\)/" ./calipso_year.ncl	
	sed -i "38s/^.*.$/res@gsnLeftString = \"$jj-year\"/" ./calipso_year.ncl 
	sed -i "69s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_model\_year\"\)/" ./calipso_year.ncl
	ncl ./calipso_year.ncl
	echo "calipso_WRF_year: $jj complete"
done
