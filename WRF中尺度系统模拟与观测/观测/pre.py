import numpy as np
import matplotlib.pyplot as plt 
from mpl_toolkits.basemap import Basemap
from netCDF4 import Dataset

files01=np.loadtxt("/Users/QQF/Downloads/obs/pre/04",dtype=np.str)
files02=np.loadtxt("/Users/QQF/Downloads/obs/pre/05",dtype=np.str)
files03=np.loadtxt("/Users/QQF/Downloads/obs/pre/06",dtype=np.str)
files04=np.loadtxt("/Users/QQF/Downloads/obs/pre/07",dtype=np.str)

station01=[int(x) for x in files01[:,0] if x]
latitude01=np.array([float(x) for x in files01[:,1] if x]) 
longitude01=np.array([float(x) for x in files01[:,2] if x]) 
pre01=np.array([float(x) for x in files01[:,4] if x]) 

station02=[int(x) for x in files02[:,0] if x]
latitude02=np.array([float(x) for x in files02[:,1] if x]) 
longitude02=np.array([float(x) for x in files02[:,2] if x]) 
pre02=np.array([float(x) for x in files02[:,4] if x]) 

station03=[int(x) for x in files03[:,0] if x]
latitude03=np.array([float(x) for x in files03[:,1] if x]) 
longitude03=np.array([float(x) for x in files03[:,2] if x]) 
pre03=np.array([float(x) for x in files03[:,4] if x]) 

station04=[int(x) for x in files04[:,0] if x]
latitude04=np.array([float(x) for x in files04[:,1] if x]) 
longitude04=np.array([float(x) for x in files04[:,2] if x]) 
pre04=np.array([float(x) for x in files04[:,4] if x]) 

PRE=[]
lat=[]
lon=[]
color=[]
size=[]

for ii in range(len(station01)):
    tmp=pre01[ii]
    for jj in range(len(station02)):
        if station01[ii]==station02[jj]:
           tmp=tmp+pre02[jj]
    for jj in range(len(station03)):
        if station01[ii]==station03[jj]:
           tmp=tmp+pre03[jj]
    for jj in range(len(station04)):
        if station01[ii]==station04[jj]:
           tmp=tmp+pre04[jj]
           PRE.append(tmp)
           lat.append(latitude01[ii])
           lon.append(longitude01[ii])
           size.append(10)

for ii in range(len(PRE)):
    if PRE[ii]<=5.0:
      color.append("blue")
    elif 5.0<PRE[ii]<=20.0:
      color.append("cyan")
    elif 20.0<PRE[ii]<=30.0:
      color.append("green")
    elif 30.0<PRE[ii]<=40.0:
      color.append("yellow")
    elif 40.0<PRE[ii]<=50.0:
      color.append("red")
    else:
      color.append("magenta")
  

m = Basemap(llcrnrlon=111,llcrnrlat=21,urcrnrlon=115,urcrnrlat=25,\
            projection='lcc',lat_1=6.,lat_2=38.,lon_0=113,resolution='h')
x,y=m(lon,lat)


m.drawcoastlines(linewidth=0.5)
m.drawparallels(np.arange(21,25,1),labels=[1,1,0,0])
m.drawmeridians(np.arange(111,115,1),labels=[0,1,0,1])

m.scatter(x,y,size,marker='o',c=color,edgecolors='none')#,s=size)
plt.title("0400UTC-0800UTC Total precipitation")

plt.savefig("/Users/QQF/Downloads/tmp.png",dpi=600)

np.savetxt("lat", lat,fmt="%f")
np.savetxt("lon", lon,fmt="%f")
np.savetxt("PRE", PRE,fmt="%f")
