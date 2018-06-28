load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

ep2=287.04/461.6

filelist=systemfunc("ls ./MOR/wrfout/wrfout_d03_*")
wrffiles=addfiles(filelist(96:120), "r")

pres=wrf_user_getvar(wrffiles,"pres",-1)

t3d=wrf_user_getvar(wrffiles,"tk",-1)

a0i=6.11147274
a1i=0.503160820
a2i=0.188439774e-1
a3i=0.420895665e-3
a4i=0.615021634e-5
a5i=0.602588177e-7
a6i=0.385852041e-9
a7i=0.146898966e-11
a8i=0.252751365e-14

a0=6.11239921
a1=0.443987641
a2=0.142986287e-1
a3=0.264847430e-3
a4=0.302950461e-5
a5=0.206739458e-7
a6=0.640689451e-10
a7=-0.952447341e-13
a8=-0.976195544e-15

dt=where(t3d-273.16.gt.-80.0, t3d-273.16, -80.0)
polysvp = a0 + dt*(a1+dt*(a2+dt*(a3+dt*(a4+dt*(a5+dt*(a6+dt*(a7+a8*dt)))))))
polysvp = polysvp*100.

evs=where(0.99*pres.lt.polysvp, 0.99*pres, polysvp)

qvs=ep2*evs/(pres-evs)

outfile=addfile("qvs.nc", "c")
outfile->qvs=qvs
