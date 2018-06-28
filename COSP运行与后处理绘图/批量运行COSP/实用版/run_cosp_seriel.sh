#!/bin/bash

year=2006
for month in 01 02 03 04 05 06 07 08 09 10 11 12
do
        filename=(`ls /home/QQF2/forcosp/$year/$month/*`)
        num=${#filename[@]}
        for ((i=0;i<=num-1;i++))
        do
                echo "========${filename[$i]}========"
                ln -sf ${filename[$i]} /home/QQF2/COSP/
                sed -i "39s/^.*.$/  FINPUT=\'${filename[$i]##*/}\' ! List input NetCDF files/" /home/QQF2/COSP/cosp_input_nl.txt
                cd /home/QQF2/COSP/
                ./cosp_test
                echo "========cosp complete========"
                cd outputs
                for ff in `ls`
                do
                        mv $ff ${ff/209901020000-209901020000.nc/${filename[$i]##*/}}
                done
                mkdir /home/QQF2/cosp_output/$year/$month/$(echo ${filename[$i]##*/}|sed -e 's/.nc//')
                mv * /home/QQF2/cosp_output/$year/$month/$(echo ${filename[$i]##*/}|sed -e 's/.nc//')
                cd ..
                echo "========rename & mv complete========"
        done
done
echo "========COSP complete========"

