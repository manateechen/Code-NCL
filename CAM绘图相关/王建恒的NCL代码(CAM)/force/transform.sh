#!/bin/sh
for i in `ls *.eps`
do
convert -trim -density 500 $i $i.png
done
