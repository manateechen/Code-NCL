import numpy as np
import Scientific.IO.NetCDF as S
from xlwt import *

fileobj=S.NetCDFFile('wrfout_d01_2013-08-01_00:00:00','r')
XLAT=fileobj.variables['XLAT'].getValue()
XLONG=fileobj.variables['XLONG'].getValue()

book=Workbook()
i=0
sheet1=book.add_sheet('wind_loc_1')

lat=np.linspace(XLAT[0,129,47],XLAT[0,130,47],30)
lon=np.linspace(XLONG[0,129,47],XLONG[0,129,52],150)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

lat=np.linspace(XLAT[0,130,48],XLAT[0,131,48],30)
lon=np.linspace(XLONG[0,130,48],XLONG[0,130,52],120)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,131,47],XLAT[0,132,47],30)
lon=np.linspace(XLONG[0,131,47],XLONG[0,131,50],90)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,132,47],XLAT[0,133,47],30)
lon=np.linspace(XLONG[0,132,47],XLONG[0,132,48],30)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,132,56],XLAT[0,133,56],30)
lon=np.linspace(XLONG[0,132,56],XLONG[0,132,57],30)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,133,55],XLAT[0,134,55],30)
lon=np.linspace(XLONG[0,133,55],XLONG[0,133,57],60)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,134,54],XLAT[0,135,54],30)
lon=np.linspace(XLONG[0,134,54],XLONG[0,134,59],150)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,135,54],XLAT[0,136,54],30)
lon=np.linspace(XLONG[0,135,54],XLONG[0,135,59],150)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,136,54],XLAT[0,137,54],30)
lon=np.linspace(XLONG[0,136,54],XLONG[0,136,57],90)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,137,55],XLAT[0,138,55],30)
lon=np.linspace(XLONG[0,137,55],XLONG[0,137,57],60)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,130,60],XLAT[0,131,60],30)
lon=np.linspace(XLONG[0,130,60],XLONG[0,130,62],60)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,129,62],XLAT[0,130,62],30)
lon=np.linspace(XLONG[0,129,62],XLONG[0,129,64],60)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,128,62],XLAT[0,129,62],30)
lon=np.linspace(XLONG[0,128,62],XLONG[0,128,65],90)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,127,64],XLAT[0,128,64],30)
lon=np.linspace(XLONG[0,127,64],XLONG[0,127,66],60)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,126,63],XLAT[0,127,63],30)
lon=np.linspace(XLONG[0,126,63],XLONG[0,126,65],60)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,125,60],XLAT[0,126,60],30)
lon=np.linspace(XLONG[0,125,60],XLONG[0,125,63],90)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,124,60],XLAT[0,125,60],30)
lon=np.linspace(XLONG[0,124,60],XLONG[0,124,65],150)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,123,60],XLAT[0,124,60],30)
lon=np.linspace(XLONG[0,123,60],XLONG[0,123,66],180)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,122,63],XLAT[0,123,63],30)
lon=np.linspace(XLONG[0,122,63],XLONG[0,122,69],180)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,122,70],XLAT[0,123,70],30)
lon=np.linspace(XLONG[0,122,70],XLONG[0,122,71],30)
for latt in lat:
  for lonn in lon:
    row=sheet1.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

i=0
sheet2=book.add_sheet('wind_loc_2')

lat=np.linspace(XLAT[0,121,63],XLAT[0,122,63],30)
lon=np.linspace(XLONG[0,121,63],XLONG[0,121,73],300)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,120,55],XLAT[0,121,55],30)
lon=np.linspace(XLONG[0,120,55],XLONG[0,120,57],60)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,120,64],XLAT[0,121,64],30)
lon=np.linspace(XLONG[0,120,64],XLONG[0,120,74],300)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,119,56],XLAT[0,120,56],30)
lon=np.linspace(XLONG[0,119,56],XLONG[0,119,57],30)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,119,63],XLAT[0,120,63],30)
lon=np.linspace(XLONG[0,119,63],XLONG[0,119,76],390)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,118,55],XLAT[0,119,55],30)
lon=np.linspace(XLONG[0,118,55],XLONG[0,118,59],120)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,118,65],XLAT[0,119,65],30)
lon=np.linspace(XLONG[0,118,65],XLONG[0,118,69],120)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,118,72],XLAT[0,119,72],30)
lon=np.linspace(XLONG[0,118,72],XLONG[0,118,77],150)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,117,57],XLAT[0,118,57],30)
lon=np.linspace(XLONG[0,117,57],XLONG[0,117,59],60)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,117,64],XLAT[0,118,64],30)
lon=np.linspace(XLONG[0,117,64],XLONG[0,117,68],120)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,117,75],XLAT[0,118,75],30)
lon=np.linspace(XLONG[0,117,75],XLONG[0,117,77],60)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,116,58],XLAT[0,117,58],30)
lon=np.linspace(XLONG[0,116,58],XLONG[0,116,59],30)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,116,64],XLAT[0,117,64],30)
lon=np.linspace(XLONG[0,116,64],XLONG[0,116,69],150)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,116,75],XLAT[0,117,75],30)
lon=np.linspace(XLONG[0,116,75],XLONG[0,116,76],30)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,115,57],XLAT[0,116,57],30)
lon=np.linspace(XLONG[0,115,57],XLONG[0,115,60],90)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,115,66],XLAT[0,116,66],30)
lon=np.linspace(XLONG[0,115,66],XLONG[0,115,67],30)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,114,57],XLAT[0,115,57],30)
lon=np.linspace(XLONG[0,114,57],XLONG[0,114,60],90)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,114,66],XLAT[0,115,66],30)
lon=np.linspace(XLONG[0,114,66],XLONG[0,114,67],30)
for latt in lat:
  for lonn in lon:
    row=sheet2.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

i=0
sheet3=book.add_sheet('wind_loc_3')

lat=np.linspace(XLAT[0,114,75],XLAT[0,115,75],30)
lon=np.linspace(XLONG[0,114,75],XLONG[0,114,78],90)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,113,65],XLAT[0,114,65],30)
lon=np.linspace(XLONG[0,113,65],XLONG[0,113,68],90)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,113,74],XLAT[0,114,74],30)
lon=np.linspace(XLONG[0,113,74],XLONG[0,113,79],150)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,57],XLAT[0,113,57],30)
lon=np.linspace(XLONG[0,112,57],XLONG[0,112,58],30)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,62],XLAT[0,113,62],30)
lon=np.linspace(XLONG[0,112,62],XLONG[0,112,63],30)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,65],XLAT[0,113,65],30)
lon=np.linspace(XLONG[0,112,65],XLONG[0,112,66],30)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,74],XLAT[0,113,74],30)
lon=np.linspace(XLONG[0,112,74],XLONG[0,112,78],120)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,80],XLAT[0,113,80],30)
lon=np.linspace(XLONG[0,112,80],XLONG[0,112,85],150)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,111,55],XLAT[0,112,55],30)
lon=np.linspace(XLONG[0,111,55],XLONG[0,111,59],120)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,111,63],XLAT[0,112,63],30)
lon=np.linspace(XLONG[0,111,63],XLONG[0,111,69],180)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,111,73],XLAT[0,112,73],30)
lon=np.linspace(XLONG[0,111,73],XLONG[0,111,78],150)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,111,81],XLAT[0,112,81],30)
lon=np.linspace(XLONG[0,111,81],XLONG[0,111,86],150)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,110,54],XLAT[0,111,54],30)
lon=np.linspace(XLONG[0,110,54],XLONG[0,110,57],90)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,110,58],XLAT[0,111,58],30)
lon=np.linspace(XLONG[0,110,58],XLONG[0,110,62],120)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,110,64],XLAT[0,111,64],30)
lon=np.linspace(XLONG[0,110,64],XLONG[0,110,69],150)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,110,73],XLAT[0,111,73],30)
lon=np.linspace(XLONG[0,110,73],XLONG[0,110,78],150)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,110,83],XLAT[0,111,83],30)
lon=np.linspace(XLONG[0,110,83],XLONG[0,110,88],150)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,109,58],XLAT[0,110,58],30)
lon=np.linspace(XLONG[0,109,58],XLONG[0,109,62],120)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,109,65],XLAT[0,110,65],30)
lon=np.linspace(XLONG[0,109,65],XLONG[0,109,68],90)
for latt in lat:
  for lonn in lon:
    row=sheet3.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

i=0
sheet4=book.add_sheet('wind_loc_4')

lat=np.linspace(XLAT[0,109,82],XLAT[0,110,82],30)
lon=np.linspace(XLONG[0,109,82],XLONG[0,109,87],150)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,109,92],XLAT[0,110,92],30)
lon=np.linspace(XLONG[0,109,92],XLONG[0,109,94],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,109,95],XLAT[0,110,95],30)
lon=np.linspace(XLONG[0,109,95],XLONG[0,109,96],30)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,108,59],XLAT[0,109,59],30)
lon=np.linspace(XLONG[0,108,59],XLONG[0,108,62],90)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,108,65],XLAT[0,109,65],30)
lon=np.linspace(XLONG[0,108,65],XLONG[0,108,69],120)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,108,72],XLAT[0,109,72],30)
lon=np.linspace(XLONG[0,108,72],XLONG[0,108,77],150)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,108,94],XLAT[0,109,94],30)
lon=np.linspace(XLONG[0,108,94],XLONG[0,108,99],150)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,107,63],XLAT[0,108,63],30)
lon=np.linspace(XLONG[0,107,63],XLONG[0,107,66],90)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

lat=np.linspace(XLAT[0,107,68],XLAT[0,108,68],30)
lon=np.linspace(XLONG[0,107,68],XLONG[0,107,76],240)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,107,93],XLAT[0,108,93],30)
lon=np.linspace(XLONG[0,107,93],XLONG[0,107,96],90)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,107,97],XLAT[0,108,97],30)
lon=np.linspace(XLONG[0,107,97],XLONG[0,107,99],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,106,69],XLAT[0,107,69],30)
lon=np.linspace(XLONG[0,106,69],XLONG[0,106,71],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,106,75],XLAT[0,107,75],30)
lon=np.linspace(XLONG[0,106,75],XLONG[0,106,77],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,106,96],XLAT[0,107,96],30)
lon=np.linspace(XLONG[0,106,96],XLONG[0,106,99],90)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,105,98],XLAT[0,106,98],30)
lon=np.linspace(XLONG[0,105,98],XLONG[0,105,99],30)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,102,87],XLAT[0,103,87],30)
lon=np.linspace(XLONG[0,102,87],XLONG[0,102,88],30)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,101,87],XLAT[0,102,87],30)
lon=np.linspace(XLONG[0,101,87],XLONG[0,101,88],30)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,100,87],XLAT[0,101,87],30)
lon=np.linspace(XLONG[0,100,87],XLONG[0,100,92],150)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,99,89],XLAT[0,100,89],30)
lon=np.linspace(XLONG[0,99,89],XLONG[0,99,91],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,99,102],XLAT[0,100,102],30)
lon=np.linspace(XLONG[0,99,102],XLONG[0,99,103],30)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,100,100],XLAT[0,101,100],30)
lon=np.linspace(XLONG[0,100,100],XLONG[0,100,103],90)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,101,100],XLAT[0,102,100],30)
lon=np.linspace(XLONG[0,101,100],XLONG[0,101,102],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,102,103],XLAT[0,103,103],30)
lon=np.linspace(XLONG[0,102,103],XLONG[0,102,105],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,103,103],XLAT[0,104,103],30)
lon=np.linspace(XLONG[0,103,103],XLONG[0,103,105],60)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,104,100],XLAT[0,105,100],30)
lon=np.linspace(XLONG[0,104,100],XLONG[0,104,103],90)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,104,104],XLAT[0,105,104],30)
lon=np.linspace(XLONG[0,104,104],XLONG[0,104,105],30)
for latt in lat:
  for lonn in lon:
    row=sheet4.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

i=0
sheet5=book.add_sheet('wind_loc_5')

lat=np.linspace(XLAT[0,105,101],XLAT[0,106,101],30)
lon=np.linspace(XLONG[0,105,101],XLONG[0,105,103],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,105,105],XLAT[0,106,105],30)
lon=np.linspace(XLONG[0,105,105],XLONG[0,105,107],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,105,117],XLAT[0,106,117],30)
lon=np.linspace(XLONG[0,105,117],XLONG[0,105,118],30)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,106,106],XLAT[0,107,106],30)
lon=np.linspace(XLONG[0,106,106],XLONG[0,106,111],150)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,106,115],XLAT[0,107,115],30)
lon=np.linspace(XLONG[0,106,115],XLONG[0,106,116],30)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,106,119],XLAT[0,107,119],30)
lon=np.linspace(XLONG[0,106,119],XLONG[0,106,120],30)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,107,103],XLAT[0,108,103],30)
lon=np.linspace(XLONG[0,107,103],XLONG[0,107,107],120)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,107,108],XLAT[0,108,108],30)
lon=np.linspace(XLONG[0,107,108],XLONG[0,107,117],270)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,107,118],XLAT[0,108,118],30)
lon=np.linspace(XLONG[0,107,118],XLONG[0,107,120],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,107,122],XLAT[0,108,122],30)
lon=np.linspace(XLONG[0,107,122],XLONG[0,107,123],30)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,108,105],XLAT[0,109,105],30)
lon=np.linspace(XLONG[0,108,105],XLONG[0,108,117],360)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,108,121],XLAT[0,109,121],30)
lon=np.linspace(XLONG[0,108,121],XLONG[0,108,123],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,109,107],XLAT[0,110,107],30)
lon=np.linspace(XLONG[0,109,107],XLONG[0,109,118],330)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,109,121],XLAT[0,110,121],30)
lon=np.linspace(XLONG[0,109,121],XLONG[0,109,123],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,110,116],XLAT[0,111,116],30)
lon=np.linspace(XLONG[0,110,116],XLONG[0,110,118],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,110,120],XLAT[0,111,120],30)
lon=np.linspace(XLONG[0,110,120],XLONG[0,110,123],90)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,111,121],XLAT[0,112,121],30)
lon=np.linspace(XLONG[0,111,121],XLONG[0,111,123],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,118],XLAT[0,113,118],30)
lon=np.linspace(XLONG[0,112,118],XLONG[0,112,120],60)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,123],XLAT[0,113,123],30)
lon=np.linspace(XLONG[0,112,123],XLONG[0,112,124],30)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,113,119],XLAT[0,114,119],30)
lon=np.linspace(XLONG[0,113,119],XLONG[0,113,120],30)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

lat=np.linspace(XLAT[0,113,123],XLAT[0,114,123],30)
lon=np.linspace(XLONG[0,113,123],XLONG[0,113,124],30)
for latt in lat:
  for lonn in lon:
    row=sheet5.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

i=0
sheet6=book.add_sheet('wind_loc_6')

lat=np.linspace(XLAT[0,111,130],XLAT[0,112,130],30)
lon=np.linspace(XLONG[0,111,130],XLONG[0,111,136],180)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

lat=np.linspace(XLAT[0,111,146],XLAT[0,112,146],30)
lon=np.linspace(XLONG[0,111,146],XLONG[0,111,148],60)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,130],XLAT[0,113,130],30)
lon=np.linspace(XLONG[0,112,130],XLONG[0,112,136],180)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,112,146],XLAT[0,113,146],30)
lon=np.linspace(XLONG[0,112,146],XLONG[0,112,150],120)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,113,132],XLAT[0,114,132],30)
lon=np.linspace(XLONG[0,113,132],XLONG[0,113,134],60)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,113,135],XLAT[0,114,135],30)
lon=np.linspace(XLONG[0,113,135],XLONG[0,113,136],30)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,113,140],XLAT[0,114,140],30)
lon=np.linspace(XLONG[0,113,140],XLONG[0,113,144],120)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,113,145],XLAT[0,114,145],30)
lon=np.linspace(XLONG[0,113,145],XLONG[0,113,153],240)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,114,129],XLAT[0,115,129],30)
lon=np.linspace(XLONG[0,114,129],XLONG[0,114,130],30)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,114,131],XLAT[0,115,131],30)
lon=np.linspace(XLONG[0,114,131],XLONG[0,114,134],90)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,114,135],XLAT[0,115,135],30)
lon=np.linspace(XLONG[0,114,135],XLONG[0,114,136],30)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,114,143],XLAT[0,115,143],30)
lon=np.linspace(XLONG[0,114,143],XLONG[0,114,145],60)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,114,146],XLAT[0,115,146],30)
lon=np.linspace(XLONG[0,114,146],XLONG[0,114,153],210)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,115,130],XLAT[0,116,130],30)
lon=np.linspace(XLONG[0,115,130],XLONG[0,115,131],30)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

lat=np.linspace(XLAT[0,115,134],XLAT[0,116,134],30)
lon=np.linspace(XLONG[0,115,134],XLONG[0,115,136],60)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,115,144],XLAT[0,116,144],30)
lon=np.linspace(XLONG[0,115,144],XLONG[0,115,146],60)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,116,130],XLAT[0,117,130],30)
lon=np.linspace(XLONG[0,116,130],XLONG[0,116,131],30)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,116,134],XLAT[0,117,134],30)
lon=np.linspace(XLONG[0,116,134],XLONG[0,116,135],30)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,116,145],XLAT[0,117,145],30)
lon=np.linspace(XLONG[0,116,145],XLONG[0,116,149],120)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,117,129],XLAT[0,118,129],30)
lon=np.linspace(XLONG[0,117,129],XLONG[0,117,131],60)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,117,134],XLAT[0,118,134],30)
lon=np.linspace(XLONG[0,117,134],XLONG[0,117,138],120)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,117,146],XLAT[0,118,146],30)
lon=np.linspace(XLONG[0,117,146],XLONG[0,117,153],210)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,118,128],XLAT[0,119,128],30)
lon=np.linspace(XLONG[0,118,128],XLONG[0,118,129],30)
for latt in lat:
  for lonn in lon:
    row=sheet6.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

i=0
sheet7=book.add_sheet('wind_loc_7')

lat=np.linspace(XLAT[0,118,135],XLAT[0,119,135],30)
lon=np.linspace(XLONG[0,118,135],XLONG[0,118,136],30)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,118,137],XLAT[0,119,137],30)
lon=np.linspace(XLONG[0,118,137],XLONG[0,118,138],30)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,118,149],XLAT[0,119,149],30)
lon=np.linspace(XLONG[0,118,149],XLONG[0,118,157],240)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,119,127],XLAT[0,120,127],30)
lon=np.linspace(XLONG[0,119,127],XLONG[0,119,131],120)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,119,134],XLAT[0,120,134],30)
lon=np.linspace(XLONG[0,119,134],XLONG[0,119,136],60)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,119,137],XLAT[0,120,137],30)
lon=np.linspace(XLONG[0,119,137],XLONG[0,119,139],60)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,119,149],XLAT[0,120,149],30)
lon=np.linspace(XLONG[0,119,149],XLONG[0,119,157],240)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,120,128],XLAT[0,121,128],30)
lon=np.linspace(XLONG[0,120,128],XLONG[0,120,131],90)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,120,134],XLAT[0,121,134],30)
lon=np.linspace(XLONG[0,120,134],XLONG[0,120,135],30)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

lat=np.linspace(XLAT[0,120,136],XLAT[0,121,136],30)
lon=np.linspace(XLONG[0,120,136],XLONG[0,120,137],30)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,120,139],XLAT[0,121,139],30)
lon=np.linspace(XLONG[0,120,139],XLONG[0,120,141],60)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,120,149],XLAT[0,121,149],30)
lon=np.linspace(XLONG[0,120,149],XLONG[0,120,157],240)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,121,140],XLAT[0,122,140],30)
lon=np.linspace(XLONG[0,121,140],XLONG[0,121,141],30)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,121,149],XLAT[0,122,149],30)
lon=np.linspace(XLONG[0,121,149],XLONG[0,121,153],120)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,122,134],XLAT[0,123,134],30)
lon=np.linspace(XLONG[0,122,134],XLONG[0,122,137],90)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,122,149],XLAT[0,123,149],30)
lon=np.linspace(XLONG[0,122,149],XLONG[0,122,153],120)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,123,134],XLAT[0,124,134],30)
lon=np.linspace(XLONG[0,123,134],XLONG[0,123,138],120)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,123,139],XLAT[0,124,139],30)
lon=np.linspace(XLONG[0,123,139],XLONG[0,123,140],30)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,123,149],XLAT[0,124,149],30)
lon=np.linspace(XLONG[0,123,149],XLONG[0,123,152],120)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,124,134],XLAT[0,125,134],30)
lon=np.linspace(XLONG[0,124,134],XLONG[0,124,136],60)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,124,137],XLAT[0,125,137],30)
lon=np.linspace(XLONG[0,124,137],XLONG[0,124,138],30)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,124,139],XLAT[0,125,139],30)
lon=np.linspace(XLONG[0,124,139],XLONG[0,124,141],60)
for latt in lat:
  for lonn in lon:
    row=sheet7.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1

i=0
sheet8=book.add_sheet('wind_loc_8')

lat=np.linspace(XLAT[0,124,149],XLAT[0,125,149],30)
lon=np.linspace(XLONG[0,124,149],XLONG[0,124,157],240)
for latt in lat:
  for lonn in lon:
    row=sheet8.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
    
lat=np.linspace(XLAT[0,125,149],XLAT[0,126,149],30)
lon=np.linspace(XLONG[0,125,149],XLONG[0,125,157],240)
for latt in lat:
  for lonn in lon:
    row=sheet8.row(i)
    row.write(0,1)
    row.write(1,latt)
    row.write(2,lonn)
    row.write(3,100)
    row.write(4,100)
    row.write(5,0.158)
    row.write(6,6)
    row.write(7,4)
    row.write(8,25)
    i=i+1
book.save('wind_loc.xlsx')