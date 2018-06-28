load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
 
	sig	= "PSL"      
	name	= (/"case1","case2","case3"/)


do	n	= 0,2   ;modes


system("rm -rf "+sig+name(n)+".png")

system("convert -trim -density 300 "+sig+name(n)+".eps "+sig+name(n)+".png")


print("********* "+sig+name(n)+".png"+" *************")

end do
end
