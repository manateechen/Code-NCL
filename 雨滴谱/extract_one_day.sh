#!/bin/sh

# Bada
for ii in {12..23}
do
cat /Users/QQF/Downloads/distrometer/bada/20140523/TOA5_4272.min_spectral.dat|awk '$1~/2014-05-21/'|grep "2014-05-21 $ii:" >> bada_data
done

for ii in 00 01 02 03 04 05 06 07 08 09 10 11 
do
cat /Users/QQF/Downloads/distrometer/bada/20140523/TOA5_4272.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 $ii:" >> bada_data
done

cat /Users/QQF/Downloads/distrometer/bada/20140523/TOA5_4272.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 12:00:00" >> bada_data

# Chengcun
for ii in {12..23}
do
cat /Users/QQF/Downloads/distrometer/chengcun/20140523/TOA5_4268.min_spectral.dat|awk '$1~/2014-05-21/'|grep "2014-05-21 $ii:" >> chengcun_data
done

for ii in 00 01 02 03 04 05 06 07 08 09 10 11  
do
cat /Users/QQF/Downloads/distrometer/chengcun/20140523/TOA5_4268.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 $ii:" >> chengcun_data
done

cat /Users/QQF/Downloads/distrometer/chengcun/20140523/TOA5_4268.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 12:00:00" >> chengcun_data

# Hecheng
for ii in {12..23}
do
cat /Users/QQF/Downloads/distrometer/hecheng/20140617/TOA5_4273.min_spectral.dat|awk '$1~/2014-05-21/'|grep "2014-05-21 $ii:" >> heshan_data
done

for ii in 00 01 02 03 04 05 06 07 08 09 10 11  
do
cat /Users/QQF/Downloads/distrometer/hecheng/20140617/TOA5_4273.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 $ii:" >> heshan_data
done

cat /Users/QQF/Downloads/distrometer/hecheng/20140617/TOA5_4273.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 12:00:00" >> heshan_data

# Shuangjie
for ii in {12..23}
do
cat /Users/QQF/Downloads/distrometer/shuangjie/20140523/TOA5_1621.min_spectral.dat|awk '$1~/2014-05-21/'|grep "2014-05-21 $ii:" >> shuangjie_data
done

for ii in 00 01 02 03 04 05 06 07 08 09 10 11  
do
cat /Users/QQF/Downloads/distrometer/shuangjie/20140523/TOA5_1621.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 $ii:" >> shuangjie_data
done

cat /Users/QQF/Downloads/distrometer/shuangjie/20140523/TOA5_1621.min_spectral.dat|awk '$1~/2014-05-22/'|grep "2014-05-22 12:00:00" >> shuangjie_data
