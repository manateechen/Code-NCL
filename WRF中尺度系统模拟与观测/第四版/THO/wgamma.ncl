function wgamma(XX:numeric)
local wgamma,STP,SER,TMP,X,Y,J,GAMMLN
begin
STP = 2.5066282746310005
COF = (/76.18009172947146, -86.50532032941677, 24.01409824083091, -1.231739572450155, .1208650973866179e-2, -.5395239384953e-5/)
X=XX
Y=X
TMP=X+5.5
TMP=(X+0.5)*log(TMP)-TMP
SER=1.000000000190015
do J=0,5
  Y=Y+1.
  SER=SER+COF(J)/Y
end do
GAMMLN=TMP+log(STP*SER/X)
wgamma=exp(GAMMLN)
return(wgamma)
end

