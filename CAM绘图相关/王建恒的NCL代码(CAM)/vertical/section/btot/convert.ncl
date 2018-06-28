load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
       
	name	= (/"90eurasiatop","95eurasiatop","90northamericatop","95northamericatop"/)


do	n	= 0,3   ;modes


system("rm -rf "+name(n)+".png")

system("convert -trim -density 300 "+name(n)+".eps "+name(n)+".png")


print("********* "+name(n)+".png"+" *************")

end do
end
