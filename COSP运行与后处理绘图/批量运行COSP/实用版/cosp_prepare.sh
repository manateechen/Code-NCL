#!/bin/bash

year=2006
for month in 01 02 03 04 05 06 07 08 09 10 11 12
do
	filename=(`ls /home/QQF2/wrf_file/$year/$month/wrfout*`)
	num=${#filename[@]}
	for ((i=0;i<=num-1;i++))
	do
		filepath=$(echo ${filename[$i]} |sed -e 's/\//\\\//g')  
		sed -i "9s/^.*.$/	f       = addfile(\"${filepath}\",\"r\")/" input_prepare.ncl
		fileout=$(echo ${filename[$i]##*/}|sed -e 's/\:00\:00//'|sed -e 's/wrfout_d01_//')
		sed -i "110s/^.*.$/	fout    = addfile(\"${fileout}.nc\",\"c\")/" input_prepare.ncl
		ncl input_prepare.ncl
		mv ${fileout}.nc /home/QQF2/forcosp/$year/$month/
		echo "========${fileout} complete========"
	done
done
echo "========prepare complete========"
