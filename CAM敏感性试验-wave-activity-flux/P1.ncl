load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  

system("rm -rf Z200-P1.nc") 

filename = systemfunc("ls /home/qqf/Data/MyCAM/P1-ext/*.nc")

fall = addfiles (filename, "r")

Z3 = fall[:]->Z3
PS = fall[:]->PS

ff = addfile("/home/qqf/Data/mymodel/hyabim.nc", "r")

hbcofa1=ff->hyai
hbcofb1=ff->hybi

plevo=(/200.0/)

intyp=3
p0=1000.0
kxtrp=False
ii=1

HGT = vinth2p(Z3,hbcofa1,hbcofb1,plevo,PS,intyp,p0,ii,kxtrp)
printVarSummary(HGT)
printVarSummary(Z3(:,0,:,:))
copy_VarMeta(Z3(:,0,:,:), HGT(:,0,:,:))

out = addfile("Z200-P1.nc", "c")
out->Z200 = HGT(:,0,:,:)
