#!/bin/sh
for i in `ls *.eps`
do
convert -trim -density 300 $i $i.png
done
