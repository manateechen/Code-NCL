load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
       
	name	= (/"T2mcase3-1","T2mcase3-2","T2mcase2-1"/)


do	n	= 0,2   ;modes


system("rm -rf "+name(n)+".png")

system("convert -trim -density 300 "+name(n)+".eps "+name(n)+".png")


print("********* "+name(n)+".png"+" *************")

end do
end
