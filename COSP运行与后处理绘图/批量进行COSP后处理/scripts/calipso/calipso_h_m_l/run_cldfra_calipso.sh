#!/bin/bash

for jj in "cltcalipso" "cllcalipso" "clmcalipso" "clhcalipso"
do
	for ii in 01 02 03 04 05 06 07 08 09 10 11 12
	do
		sed -i "8s/^.*.$/cloudfile=addfile\(\".\/cosp\/$jj\_$ii.nc\", \"r\"\)/" ./calipso.ncl
		sed -i "14s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile->$jj,0\)/" ./calipso.ncl
		sed -i "36s/^.*.$/res@gsnLeftString = \"$jj\_$ii\_WRF\"/" ./calipso.ncl
		sed -i "67s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_model\_$ii\"\)/" ./calipso.ncl
		ncl ./calipso.ncl
		echo "calipso_WRF: $jj-$ii complete"
		sed -i "5s/^.*.$/globalfile=addfile\(\"\/home2\_hn\/qf\/wrf-cosp\/cloud\_obs\/$jj\_obs4cmip5\_CALIOP\_L3\_CALIPSO-GOCCP-v2.1\_2007${ii}15\_2007${ii}15.nc\",\"r\")/" ./regrid.ncl
		sed -i "13s/^.*.$/var=dim\_avg\_n\_Wrap\(globalfile->$jj,0\)/" ./regrid.ncl
		sed -i "33s/^.*.$/out=addfile\(\"$jj\_WRF\_$ii.nc\",\"c\"\)/" ./regrid.ncl
		sed -i "34s/^.*.$/out->$jj=temp_regrid/" ./regrid.ncl
		sed -i "55s/^.*.$/res@gsnLeftString = \"$jj\_$ii\_OBS\"/" ./regrid.ncl
		sed -i "85s/^.*.$/wks = gsn\_open\_wks(\"eps\", \"$jj\_obs\_$ii\") /" ./regrid.ncl
		ncl ./regrid.ncl
		rm -rf dst_SCRIP.nc PET0.RegridWeightGen.Log src_SCRIP.nc wgt.nc
		echo "calipso_OBS: $jj-$ii complete"
		sed -i "8s/^.*.$/cloudfile=addfile\(\".\/cosp\/$jj\_$ii.nc\", \"r\"\)/" ./diff.ncl
		sed -i "9s/^.*.$/cloudobs=addfile\(\".\/$jj\_WRF\_$ii.nc\",\"r\"\)/" ./diff.ncl
		sed -i "15s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile->$jj,0\)/" ./diff.ncl
		sed -i "24s/^.*.$/cldobs=\(cloudobs->$jj\)*100.0/" ./diff.ncl
		sed -i "45s/^.*.$/res@gsnLeftString = \"$jj\_$ii\: model-obs\"/" ./diff.ncl
		sed -i "76s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_$ii\_diff\"\)/" ./diff.ncl
		ncl ./diff.ncl
		echo "calipso_diff: $jj-$ii complete"
	done
	sed -i "8s/^.*.$/filelist=systemfunc\(\"ls .\/cosp\/$jj\_*.nc\"\)/" ./calipso_year.ncl
	sed -i "16s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile[\:]->$jj,0\)/" ./calipso_year.ncl	
	sed -i "38s/^.*.$/res@gsnLeftString = \"$jj-year\"/" ./calipso_year.ncl 
	sed -i "69s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_model\_year\"\)/" ./calipso_year.ncl
	ncl ./calipso_year.ncl
	echo "calipso_WRF_year: $jj complete"
	sed -i "5s/^.*.$/filelist=systemfunc\(\"ls \/home2\_hn\/qf\/wrf-cosp\/cloud\_obs\/$jj*2007*.nc\"\)/" ./regrid_year.ncl
	sed -i "15s/^.*.$/var=dim_avg_n_Wrap\(globalfile[\:]->$jj,0\)/" ./regrid_year.ncl
	sed -i "35s/^.*.$/out=addfile\(\"$jj\_WRF\_year.nc\",\"c\"\)/" ./regrid_year.ncl
	sed -i "36s/^.*.$/out->$jj=temp_regrid/" ./regrid_year.ncl
	sed -i "57s/^.*.$/res@gsnLeftString = \"$jj\_year\"/" ./regrid_year.ncl
	sed -i "87s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_obs\_year\"\)/" ./regrid_year.ncl
	ncl ./regrid_year.ncl
	rm -rf dst_SCRIP.nc PET0.RegridWeightGen.Log src_SCRIP.nc wgt.nc
	echo "calipso_OBS_year: $jj complete" 
	sed -i "8s/^.*.$/wrffilelist=systemfunc\(\"ls .\/cosp\/$jj\_*.nc\"\)/" ./diff_year.ncl
	sed -i "12s/^.*.$/obsfilelist=systemfunc\(\"ls .\/$jj\_WRF\_*.nc\"\)/" ./diff_year.ncl
	sed -i "20s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile[\:]->$jj,0\)/" ./diff_year.ncl
	sed -i "29s/^.*.$/cldobs=dim_avg_n_Wrap(cloudobs[:]->$jj,0)*100.0/" ./diff_year.ncl
	sed -i "50s/^.*.$/res@gsnLeftString = \"$jj\_year: model-obs\"/" ./diff_year.ncl
	sed -i "81s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_year\_diff\"\)/" ./diff_year.ncl
	ncl ./diff_year.ncl
	echo "calipso_diff_year: $jj complete"
done
