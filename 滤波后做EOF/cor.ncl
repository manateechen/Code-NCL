load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

mam01 = asciiread("mam-01.txt", 48, "float")
mam02 = asciiread("mam-02.txt", 48, "float")
jja01 = asciiread("jja-01.txt", 48, "float")
jja02 = asciiread("jja-02.txt", 48, "float")

cor1 = escorc(mam01, mam02)
cor2 = escorc(jja01, jja02)
cor3 = escorc(mam01, jja01)
cor4 = escorc(mam01, jja02)
cor5 = escorc(mam02, jja01)
cor6 = escorc(mam02, jja02)

t1 = cor3*sqrt( (48-2)/(1-cor3*cor3) )
t2 = cor4*sqrt( (48-2)/(1-cor4*cor4) )
t3 = cor5*sqrt( (48-2)/(1-cor5*cor5) )
t4 = cor6*sqrt( (48-2)/(1-cor6*cor6) )

print(cor1)
print(cor2)
print(cor3)
print(cor4)
print(cor5)
print(cor6)

print(t1)
print(t2)
print(t3)
print(t4)
