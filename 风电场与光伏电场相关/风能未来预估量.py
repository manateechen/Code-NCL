import numpy as np
import matplotlib.pyplot as plt
import pylab as pylab

Qmax=3.36778  #unit:Tw
k=1.46*10**-7
a=-7.2
b=0.12
t0=1997
Qt=[]

for t in range(1997,2101):
  tmp=Qmax/(1+2.718281828459**(-(a+b*(t-t0))))+k
  Qt.append(tmp)
  
print Qt[-1]
print Qt[(2050-1997)]

time=range(1997,2101)
y2=[44.0,53.0,71.0,121.0,258.0,451.0,939.0,1767.0,3100.0]
for i in range(len(y2)):
  y2[i]=y2[i]*10**-5
t=range(2002,2011)
tm=[2020,2030,2050]
yy=[0.2,0.4,1.0]
plt.plot(time,Qt,linewidth=2)
plt.plot(t,y2,"ro")
plt.plot(tm,yy,"go")
pylab.legend((r'Logistic Function', r'now', r'future'),shadow = True, loc = (0.10, 0.75))
plt.xlabel('time')
plt.ylabel('generating capacity:TW')
plt.axis([1997, 2100,0,3.5])
plt.title('Wind')
#plt.show()
plt.savefig('wind.png', dpi=96)

 
 