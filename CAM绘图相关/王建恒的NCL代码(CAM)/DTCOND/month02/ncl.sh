#!/bin/sh
for i in `ls *.ncl`
do
ncl $i
done
