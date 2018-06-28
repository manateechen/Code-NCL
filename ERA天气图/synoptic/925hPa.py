# -*- coding: utf-8 -*-
"""
Created on Tue Oct 20 14:33:18 2015

@author: QQF
"""

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap, shiftgrid
from netCDF4 import Dataset
import datetime 


pressure_file=Dataset('/Users/QQF/Downloads/pressurelevel.nc')

level=pressure_file.variables['level'][:]
lev_ind=np.where(level==925)[0]

dstart = datetime.datetime(1900, 1, 1)

hgt=pressure_file.variables['z'][:,lev_ind,:,:]/9.8/10.0
t=pressure_file.variables['t'][:,lev_ind,:,:]
u=pressure_file.variables['u'][:,lev_ind,:,:]
v=pressure_file.variables['v'][:,lev_ind,:,:]

longitude=pressure_file.variables['longitude'][:]
latitude=pressure_file.variables['latitude'][:]
del_t=pressure_file.variables['time'][:]

ntimes=len(del_t)
nx=len(longitude)
ny=len(latitude)

T_adv=np.zeros([ntimes,ny,nx])
rr=6371.0*1000.0/180.0*3.1415926  #unit:m

for ii in range(nx)[1:nx-1]:
    for jj in range(ny)[1:ny-1]:
        T_adv[:,jj,ii]=-(10**5)*(u[:,0,jj,ii]*(t[:,0,jj,ii+1]-t[:,0,jj,ii-1])/\
        (rr*np.cos(latitude[jj]/180.0*3.1415926)*(longitude[ii+1]-longitude[ii-1]))\
        +v[:,0,jj,ii]*(t[:,0,jj+1,ii]-t[:,0,jj-1,ii])/(rr*(latitude[jj+1]-latitude[jj-1])))


root_grp = Dataset('test.nc', 'w', format='NETCDF4') 
root_grp.description = 'Thermal advection at 925hPa'
root_grp.createDimension('time', ntimes) 
root_grp.createDimension('lat', 721) 
root_grp.createDimension('lon', 1440)

# variables 
T_adv_netcdf = root_grp.createVariable('T_adv', 'f8', ('time', 'lat', 'lon',))
T_adv_netcdf[:,:,:]=T_adv[:,:,:]
root_grp.close()








