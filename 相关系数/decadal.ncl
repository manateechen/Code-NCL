undef("decadal")
procedure decadal(x,fx,nm)
local wkp,wk,pi,total,i,k,s1,s2,ss
begin
wkp = new(nm,"float")
wk = new((/2,nm+1/),"float")
pi = 3.1415926
total = tofloat(nm)
wkp = x

k_start = 0
k_end = nm/10

do k = k_start,k_end
	s1 = 0.0
	s2 = 0.0
	do i = 0,nm-1
		s1=s1+wkp(i)*cos(tofloat(k)*tofloat(i)*pi*2.0/tofloat(nm))
		s2=s2+wkp(i)*sin(tofloat(k)*tofloat(i)*pi*2.0/tofloat(nm))
	end do
	
	if(k.eq.0) then
		wk(0,k)=1.0*s1/total
	else
		wk(0,k)=2.*s1/total
	end if

	wk(1,k)=2.*s2/total
end do

do i = 0, nm-1
	ss = 0.0
	do k = k_start, k_end
		ss=ss+wk(0,k)*cos(tofloat(k)*tofloat(i)*pi*2.0/total)+wk(1,k)*sin(tofloat(k)*tofloat(i)*pi*2.0/total)
	end do
	fx(i) = ss
end do

end
