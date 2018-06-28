#!/bin/bash
#并非真的并行，而是将文件放在不同目录下同时运行cosp。需要将cosp_cmor_nl.txt  cosp_input_nl.txt  cosp_output_nl.txt  COSP_table_1D四个文件放在顶层目录，并新建tmp文件夹

year=2006
for month in 01 #02 03 04 05 06 07 08 09 10 11 12
do
        filename=(`ls /home/QQF2/forcosp/$year/$month/*`)
        num=${#filename[@]}
        for ((i=0;i<=0;i++)) #num-1;i++))
        do
                echo "========${filename[$i]}========"
                ln -sf ${filename[$i]} .
                sed -i "39s/^.*.$/  FINPUT=\'${filename[$i]##*/}\' ! List input NetCDF files/" ./cosp_input_nl.txt
                sed -i "27s/^.*.$/  OUTPATH = \'.\/tmp\/\',/" ./cosp_cmor_nl.txt
                /home/QQF2/COSP/cosp_test
                echo "========cosp complete========"
                for ff in `ls tmp/`
                do
                        mv tmp/$ff tmp/${ff/209901020000-209901020000.nc/${filename[$i]##*/}}
                done
                mkdir $month/$(echo ${filename[$i]##*/}|sed -e 's/.nc//')
                mv tmp/* $month/$(echo ${filename[$i]##*/}|sed -e 's/.nc//')
                rm -rf ${filename[$i]##*/}
                echo "========rename & mv complete========"
        done
done
echo "========COSP complete========"

