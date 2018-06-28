#!/bin/sh

for filename in RHI_DBZ_VR_RTB20140522145922.dat  #`ls RHI_DBZ*.dat`
do
	num_lev=`cat $filename | awk 'NR==2'`
	num_lev=`echo ${num_lev// /}|tr -d '\r' `
	cat $filename | awk 'NR==6' > DBZ_${filename:14:14}
	cat $filename | awk 'NR==4' > lev
	echo "This file is $filename"
	echo "Create the file only contain dBZ and elevation"
    sed -i "" "4s/^.*.$/nelevation=$num_lev/" RHI.ncl
	sed -i "" "7s/^.*.$/datafile=asciiread(\"DBZ_${filename:14:14}\",(\/nelevation,nbin\/),\"float\")\/100.0/" RHI.ncl
	sed -i "" "36s/^.*.$/res\@tiMainString=\"${filename:14:14}\"/" RHI.ncl
	sed -i "" "43s/^.*.$/wks=gsn_open_wks(\"pdf\",\"${filename:14:14}\")/" RHI.ncl
	ncl RHI.ncl
	echo "Draw RHI picture complete"
#	rm -rf DBZ_${filename:14:14} lev
	echo "Delete the temperary file"
	echo "==============================="
done
