import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap
from netCDF4 import Dataset

files01=np.loadtxt("/Users/QQF/Downloads/obs/t/07",dtype=np.str)
files02=np.loadtxt("/Users/QQF/Downloads/obs/t/08",dtype=np.str)

station01=[int(x) for x in files01[:,0] if x]
latitude01=np.array([float(x) for x in files01[:,1] if x])
longitude01=np.array([float(x) for x in files01[:,2] if x])
T01=np.array([float(x) for x in files01[:,16] if x])

station02=[int(x) for x in files02[:,0] if x]
latitude02=np.array([float(x) for x in files02[:,1] if x]) 
longitude02=np.array([float(x) for x in files02[:,2] if x]) 
T02=np.array([float(x) for x in files02[:,16] if x]) 

T=[]
lat=[]
lon=[]
color=[]
size=[]

for ii in range(len(station01)):
    for jj in range(len(station02)):
        if station01[ii]==station02[jj]:
           tmp=T02[jj]-T01[ii]
           if tmp<-100 or tmp>100:
             tmp=0
           T.append(tmp)
           lat.append(latitude01[ii])
           lon.append(longitude01[ii]) 
           size.append(10)
           if tmp<=0.0:
             color.append("blue")
           else:
             color.append("red")

for ii in range(len(T)):
	if T[ii] > 10. or T[ii] < -10.:
		T[ii]=0.0

print max(T)
print min(T)
np.savetxt("lats", lat,fmt="%f")
np.savetxt("lons", lon,fmt="%f")
np.savetxt("T", T,fmt="%f")
