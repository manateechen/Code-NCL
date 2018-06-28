load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
 
	sig	= 95      
	name	= (/"PSLcase3-1","PSLcase3-2","PSLcase2-1"/)


do	n	= 0,2   ;modes


system("rm -rf "+sig+name(n)+".png")

system("convert -trim -density 300 "+sig+name(n)+".eps "+sig+name(n)+".png")


print("********* "+sig+name(n)+".png"+" *************")

end do
end
