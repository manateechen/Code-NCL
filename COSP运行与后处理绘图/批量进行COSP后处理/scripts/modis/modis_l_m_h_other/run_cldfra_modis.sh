#!/bin/bash

#for jj in clhmodis cllmodis clmmodis cltmodis climodis clwmodis iwpmodis lwpmodis pctmodis reffclimodis reffclwmodis tauilogmodis tauimodis tautlogmodis tautmodis tauwlogmodis tauwmodis
for jj in reffclwmodis reffclimodis
do
	if [ $jj == "clhmodis" ]
	then
		kk="Cloud_Fraction_Retrieval_High_Mean"
	elif [ $jj == "cllmodis" ]
	then
		kk="Cloud_Fraction_Retrieval_Low_Mean"
	elif [ $jj == "clmmodis" ]
	then
		kk="Cloud_Fraction_Retrieval_Mid_Mean"
	elif [ $jj == "cltmodis" ]
	then
		kk="Cloud_Fraction_Retrieval_Total_Mean"
	elif [ $jj == "climodis" ]
	then
		kk="Cloud_Fraction_Retrieval_Ice_Mean"
	elif [ $jj == "clwmodis" ]
	then
		kk="Cloud_Fraction_Retrieval_Liquid_Mean"
	elif [ $jj == "iwpmodis" ]
	then
		kk="Ice_Path_Mean"
	elif [ $jj == "lwpmodis" ]
	then
		kk="Liquid_Path_Mean"
	elif [ $jj == "pctmodis" ]
	then
		kk="Cloud_Top_Pressure_Total_Mean"
	elif [ $jj == "reffclimodis" ]
	then
		kk="Cloud_Particle_Size_Ice_Mean"
	elif [ $jj == "reffclwmodis" ]
	then
		kk="Cloud_Particle_Size_Liquid_Mean"
	elif [ $jj == "tauilogmodis" ]
	then
		kk="Cloud_Optical_Thickness_Ice_MeanLog10"
	elif [ $jj == "tauimodis" ]
	then
		kk="Cloud_Optical_Thickness_Ice_Mean"
	elif [ $jj == "tautlogmodis" ]
	then
		kk="Cloud_Optical_Thickness_Total_MeanLog10"
	elif [ $jj == "tautmodis" ]
	then
		kk="Cloud_Optical_Thickness_Total_Mean"
	elif [ $jj == "tauwlogmodis" ]
	then
		kk="Cloud_Optical_Thickness_Liquid_MeanLog10"
	else
		kk="Cloud_Optical_Thickness_Liquid_Mean"
	fi
	if [ $jj == "clhmodis" ] || [ $jj == "cllmodis" ] || [ $jj == "clmmodis" ] || [ $jj == "cltmodis" ] || [ $jj == "climodis" ] || [ $jj == "clwmodis" ] 
	then
		sed -i "17s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis.ncl
		sed -i "19s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis_year.ncl
		sed -i "35s/^.*.$/res@cnLevels=ispan\(5,99,5\)/" ./modis.ncl
		sed -i "37s/^.*.$/res@cnLevels=ispan\(5,99,5\)/" ./modis_year.ncl
		sed -i "38s/^.*.$/temp_regrid=temp_regrid*100.0/" ./regrid.ncl
		sed -i "54s/^.*.$/res@cnLevels=ispan\(5,99,5\)/" ./regrid.ncl
		sed -i "40s/^.*.$/temp_regrid=temp_regrid*100.0/" ./regrid_year.ncl
		sed -i "56s/^.*.$/res@cnLevels=ispan\(5,99,5\)/" ./regrid_year.ncl
		sed -i "26s/^.*.$/diff=cldfra-cldobs*100.0/" ./diff.ncl
		sed -i "44s/^.*.$/res@cnLevels=ispan\(-60,60,10\)/" ./diff.ncl
		sed -i "31s/^.*.$/diff=cldfra-cldobs*100.0/" ./diff_year.ncl
		sed -i "49s/^.*.$/res@cnLevels=ispan\(-60,60,10\)/" ./diff_year.ncl
	elif [ $jj == "iwpmodis" ] || [ $jj == "lwpmodis" ]
	then
		sed -i "17s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)*1000/" ./modis.ncl
		sed -i "19s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)*1000/" ./modis_year.ncl
		sed -i "35s/^.*.$/res@cnLevels=ispan\(10,400,30\)/" ./modis.ncl
		sed -i "37s/^.*.$/res@cnLevels=ispan\(10,400,30\)/" ./modis_year.ncl
		sed -i "38s/^.*.$/temp_regrid=temp_regrid/" ./regrid.ncl 
		sed -i "54s/^.*.$/res@cnLevels=ispan\(10,400,30\)/" ./regrid.ncl
                sed -i "40s/^.*.$/temp_regrid=temp_regrid/" ./regrid_year.ncl
                sed -i "56s/^.*.$/res@cnLevels=ispan\(10,400,30\)/" ./regrid_year.ncl 
                sed -i "26s/^.*.$/diff=cldfra*1000.0-cldobs/" ./diff.ncl 
                sed -i "44s/^.*.$/res@cnLevels=ispan\(-200,200,20\)/" ./diff.ncl   
                sed -i "31s/^.*.$/diff=cldfra*1000.0-cldobs/" ./diff_year.ncl                          
                sed -i "49s/^.*.$/res@cnLevels=ispan\(-200,200,20\)/" ./diff_year.ncl
	elif [ $jj == "pctmodis" ]
	then
		sed -i "17s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis.ncl
                sed -i "19s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis_year.ncl
		sed -i "35s/^.*.$/res@cnLevels=ispan\(10000,70000,5000\)/" ./modis.ncl
                sed -i "37s/^.*.$/res@cnLevels=ispan\(10000,70000,5000\)/" ./modis_year.ncl
                sed -i "38s/^.*.$/temp_regrid=temp_regrid/" ./regrid.ncl
                sed -i "54s/^.*.$/res@cnLevels=ispan\(30000,90000,5000\)/" ./regrid.ncl
                sed -i "40s/^.*.$/temp_regrid=temp_regrid/" ./regrid_year.ncl
                sed -i "56s/^.*.$/res@cnLevels=ispan\(30000,90000,5000\)/" ./regrid_year.ncl
                sed -i "26s/^.*.$/diff=cldfra-cldobs/" ./diff.ncl
                sed -i "44s/^.*.$/res@cnLevels=ispan\(-40000,40000,4000\)/" ./diff.ncl
                sed -i "31s/^.*.$/diff=cldfra-cldobs/" ./diff_year.ncl
                sed -i "49s/^.*.$/res@cnLevels=ispan\(-40000,40000,4000\)/" ./diff_year.ncl
	elif [ $jj == "reffclimodis" ] || [ $jj == "reffclwmodis" ]
	then
		sed -i "17s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)*1E6/" ./modis.ncl
                sed -i "19s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)*1E6/" ./modis_year.ncl
                sed -i "35s/^.*.$/res@cnLevels=ispan\(5,65,3\)/" ./modis.ncl
                sed -i "37s/^.*.$/res@cnLevels=ispan\(5,65,3\)/" ./modis_year.ncl
		sed -i "38s/^.*.$/temp_regrid=temp_regrid/" ./regrid.ncl
		sed -i "54s/^.*.$/res@cnLevels=ispan\(5,65,5\)/" ./regrid.ncl
                sed -i "40s/^.*.$/temp_regrid=temp_regrid/" ./regrid_year.ncl
                sed -i "56s/^.*.$/res@cnLevels=ispan\(5,65,5\)/" ./regrid_year.ncl
                sed -i "26s/^.*.$/diff=cldfra*1E6-cldobs/" ./diff.ncl
                sed -i "44s/^.*.$/res@cnLevels=ispan\(-40,40,4\)/" ./diff.ncl
                sed -i "31s/^.*.$/diff=cldfra*1E6-cldobs/" ./diff_year.ncl
                sed -i "49s/^.*.$/res@cnLevels=ispan\(-40,40,4\)/" ./diff_year.ncl
	elif [ $jj == "tauilogmodis" ] || [ $jj == "tautlogmodis" ] || [ $jj == "tauwlogmodis" ]
	then
		sed -i "17s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis.ncl
                sed -i "19s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis_year.ncl
                sed -i "35s/^.*.$/res@cnLevels=fspan\(0.1,1.5,15\)/" ./modis.ncl
                sed -i "37s/^.*.$/res@cnLevels=fspan\(0.1,1.5,15\)/" ./modis_year.ncl
                sed -i "38s/^.*.$/temp_regrid=temp_regrid/" ./regrid.ncl
                sed -i "54s/^.*.$/res@cnLevels=fspan\(0.1,1.5,15\)/" ./regrid.ncl
                sed -i "40s/^.*.$/temp_regrid=temp_regrid/" ./regrid_year.ncl
                sed -i "56s/^.*.$/res@cnLevels=fspan\(0.1,1.5,15\)/" ./regrid_year.ncl
                sed -i "26s/^.*.$/diff=cldfra-cldobs/" ./diff.ncl
                sed -i "44s/^.*.$/res@cnLevels=fspan\(-2.5,2.5,11\)/" ./diff.ncl
                sed -i "31s/^.*.$/diff=cldfra-cldobs/" ./diff_year.ncl
                sed -i "49s/^.*.$/res@cnLevels=fspan\(-2.5,2.5,11\)/" ./diff_year.ncl
	else
		sed -i "17s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis.ncl
                sed -i "19s/^.*.$/cldfra=onedtond\(cldfra_oned,\(\/ny,nx\/\)\)/" ./modis_year.ncl
                sed -i "35s/^.*.$/res@cnLevels=fspan\(0.5,7.5,15\)/" ./modis.ncl
                sed -i "37s/^.*.$/res@cnLevels=fspan\(0.5,7.5,15\)/" ./modis_year.ncl
                sed -i "38s/^.*.$/temp_regrid=temp_regrid/" ./regrid.ncl
                sed -i "54s/^.*.$/res@cnLevels=ispan\(5,50,5\)/" ./regrid.ncl
                sed -i "40s/^.*.$/temp_regrid=temp_regrid/" ./regrid_year.ncl
                sed -i "56s/^.*.$/res@cnLevels=ispan\(5,50,5\)/" ./regrid_year.ncl
                sed -i "26s/^.*.$/diff=cldfra-cldobs/" ./diff.ncl
                sed -i "44s/^.*.$/res@cnLevels=ispan\(-50,50,10\)/" ./diff.ncl
                sed -i "31s/^.*.$/diff=cldfra-cldobs/" ./diff_year.ncl
                sed -i "49s/^.*.$/res@cnLevels=ispan\(-50,50,10\)/" ./diff_year.ncl
	fi
	for ii in 01 02 03 04 05 06 07 08 09 10 11 12
	do
		sed -i "8s/^.*.$/cloudfile=addfile\(\".\/cosp\/$jj\_$ii.nc\", \"r\"\)/" ./modis.ncl
		sed -i "14s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile->$jj,0\)/" ./modis.ncl
		sed -i "36s/^.*.$/res@gsnLeftString = \"$jj\_$ii\_WRF\"/" ./modis.ncl
		sed -i "67s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_model\_$ii\"\)/" ./modis.ncl
		ncl ./modis.ncl
		echo "modis_WRF: $jj-$ii complete"
		sed -i "5s/^.*.$/globalfile=addfile\(\"\/home2\_hn\/qf\/wrf-cosp\/cloud\_obs\/MCD08_M3_NC.2007.${ii}.C051.V02.nc\",\"r\")/" ./regrid.ncl
		sed -i "13s/^.*.$/var=globalfile->$kk/" ./regrid.ncl
		sed -i "33s/^.*.$/out=addfile\(\"$jj\_WRF\_$ii.nc\",\"c\"\)/" ./regrid.ncl
		sed -i "34s/^.*.$/out->$jj=temp_regrid/" ./regrid.ncl
		sed -i "55s/^.*.$/res@gsnLeftString = \"$jj\_$ii\_OBS\"/" ./regrid.ncl
		sed -i "85s/^.*.$/wks = gsn\_open\_wks(\"eps\", \"$jj\_obs\_$ii\") /" ./regrid.ncl
		ncl ./regrid.ncl
		rm -rf dst_SCRIP.nc PET0.RegridWeightGen.Log src_SCRIP.nc wgt.nc
		echo "modis_OBS: $jj-$ii complete"
		sed -i "8s/^.*.$/cloudfile=addfile\(\".\/cosp\/$jj\_$ii.nc\", \"r\"\)/" ./diff.ncl
		sed -i "9s/^.*.$/cloudobs=addfile\(\".\/$jj\_WRF\_$ii.nc\",\"r\"\)/" ./diff.ncl
		sed -i "15s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile->$jj,0\)/" ./diff.ncl
		sed -i "24s/^.*.$/cldobs=cloudobs->$jj/" ./diff.ncl
		sed -i "45s/^.*.$/res@gsnLeftString = \"$jj\_$ii\: model-obs\"/" ./diff.ncl
		sed -i "76s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_$ii\_diff\"\)/" ./diff.ncl
		ncl ./diff.ncl
		echo "modis_diff: $jj-$ii complete"
	done
	sed -i "8s/^.*.$/filelist=systemfunc\(\"ls .\/cosp\/$jj\_*.nc\"\)/" ./modis_year.ncl
	sed -i "16s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile[\:]->$jj,0\)/" ./modis_year.ncl	
	sed -i "38s/^.*.$/res@gsnLeftString = \"$jj-year\"/" ./modis_year.ncl 
	sed -i "69s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_model\_year\"\)/" ./modis_year.ncl
	ncl ./modis_year.ncl
	echo "modis_WRF_year: $jj complete"
	sed -i "5s/^.*.$/filelist=systemfunc\(\"ls \/home2\_hn\/qf\/wrf-cosp\/cloud\_obs\/MCD08_M3_NC.2007.*.C051.V02.nc\"\)/" ./regrid_year.ncl
	sed -i "15s/^.*.$/var=globalfile[\:]->$kk/" ./regrid_year.ncl
	sed -i "35s/^.*.$/out=addfile\(\"$jj\_WRF\_year.nc\",\"c\"\)/" ./regrid_year.ncl
	sed -i "36s/^.*.$/out->$jj=temp_regrid/" ./regrid_year.ncl
	sed -i "57s/^.*.$/res@gsnLeftString = \"$jj\_year\"/" ./regrid_year.ncl
	sed -i "87s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_obs\_year\"\)/" ./regrid_year.ncl
	ncl ./regrid_year.ncl
	rm -rf dst_SCRIP.nc PET0.RegridWeightGen.Log src_SCRIP.nc wgt.nc
	echo "modis_OBS_year: $jj complete" 
	sed -i "8s/^.*.$/wrffilelist=systemfunc\(\"ls .\/cosp\/$jj\_*.nc\"\)/" ./diff_year.ncl
	sed -i "12s/^.*.$/obsfilelist=systemfunc\(\"ls .\/$jj\_WRF\_*.nc\"\)/" ./diff_year.ncl
	sed -i "20s/^.*.$/cldfra_oned=dim_avg_n_Wrap\(cloudfile[\:]->$jj,0\)/" ./diff_year.ncl
	sed -i "29s/^.*.$/cldobs=dim_avg_n_Wrap(cloudobs[:]->$jj,0)/" ./diff_year.ncl
	sed -i "50s/^.*.$/res@gsnLeftString = \"$jj\_year: model-obs\"/" ./diff_year.ncl
	sed -i "81s/^.*.$/wks = gsn_open_wks\(\"eps\", \"$jj\_year\_diff\"\)/" ./diff_year.ncl
	ncl ./diff_year.ncl
	echo "modis_diff_year: $jj complete"
done
