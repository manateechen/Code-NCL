import matplotlib.pyplot as plt
import pylab as pylab

Qmax=840.0  #unit:Tw
k=11*10**-6
a=-10.4
b=0.075
t0=2001
Qt=[]

for t in range(2001,2101):
  tmp=Qmax/(1+2.718281828459**(-(a+b*(t-t0))))+k
  Qt.append(tmp)
  
print Qt[-1]
print Qt[2050-2001]

time=range(2001,2101)
t=range(2001,2011)
y2=[11,26,36,45,49,61,81,126,254,774]
for i in range(len(y2)):
  y2[i]=y2[i]*10**-9

tm=[2050]
ym=[1.0]

plt.plot(tm,ym,"go")
plt.plot(t,y2,"ro")
plt.plot(time,Qt,linewidth=2)
plt.xlabel('time')
plt.ylabel('generating capacity:TW')
plt.axis([2001, 2100,0,50])
plt.title('Solar')
pylab.legend((r'future', r'now', r'Logistic Function'),shadow = True, loc = (0.10, 0.75))
plt.show()
#plt.savefig('solar.png', dpi=96)



 
