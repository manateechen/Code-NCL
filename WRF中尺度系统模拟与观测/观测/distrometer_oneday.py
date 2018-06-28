import numpy as np
import os,sys,string
import matplotlib.pyplot as plt

os.system("cat bada/20140523/TOA5_4272.min_spectral.dat |awk '{print $37}'|awk -F \":\" 'NR>4 {print $2}' > bada_all_data_tmp")
nlines=int(os.popen("wc -l bada_all_data_tmp").read().split()[0])
data=np.zeros([nlines,32],np.float)
with open("./bada_all_data_tmp",'r') as distrometerfile:
	nl=0
	for line in distrometerfile:
		nc=0
		for each in line.split(';'):
			if nc<31:
				if each=="-9.999" or each=="" or each==" ":
					each="0.0"
				data[nl,nc]=np.float(each) 
				nc=nc+1
		nl=nl+1
print data
#mean_data=np.sum(data,axis=0)
#mean_data=np.where(mean_data==0.0,999999,mean_data)
#np.savetxt("bada_all_data_tmp", mean_data,fmt="%f")

