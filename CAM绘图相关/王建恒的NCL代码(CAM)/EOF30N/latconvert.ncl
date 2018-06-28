load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
       
	name	= "lat-case3-1eof"


do	n	= 0,4   ;modes


system("rm -rf "+name+(n+1)+".png")

system("convert -trim -density 300 "+name+(n+1)+".eps "+name+(n+1)+".png")


print("********* "+name+(n+1)+".png"+" *************")

end do
end
