load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"


begin
    system("rm -f /home/wjh/ice1.9x2.5_1.nc")
    f1 = addfile("1degreeice.nc","r")
;   f2 = addfile("/home/wjh/sst_HadOIBl_bc_64x128_clim_c020411.nc","r")
 
;   f2 = addfile("/raid/home/wjh/sst_HadOIBl_bc_0.9x1.25_clim_c040926.nc","r") 
    f3 = addfile("1degreesst.nc","r")
;    f4 = addfile("/home/wjh/ice1.9x2.5_1.nc","c")
    f2 = addfile("/home/wjh/sst_HadOIBl_bc_1.9x2.5_clim_c061031.nc","r")

    lon = f1->lon
    lat = f1->lat
   LON = f2->lon
    LAT = f2->lat
   LAT(0)=-89.5
    LAT(95)=89.5 
 ;   LAT = fspan(-90,90,96)
   
 ;   LON = fspan(0,357.5,144)
   print(LAT(0))
   print(LAT(95))
    SEAICE = f1->data
    SST = f3->data
;rspan=(/10, 5, 2/)    
;opt=False 
;ice1=obj_anal_ic_deprecated(lon,lat,SEAICE,LON,LAT,rspan,opt)
;sst=obj_anal_ic_deprecated(lon,lat,SST,LON,LAT,rspan,opt)



    ice1 = linint2_Wrap (lon,lat,SEAICE,True,LON,LAT, 0)

    ice=ice1
    ice=ice1/100

    sst = linint2_Wrap (lon,lat,SST,True,LON,LAT, 0)
printVarSummary(ice)
printVarSummary(sst)

f4 = addfile("force1.nc","w")
ice_cov = f4->ice_cov
sst_cpl = f4->SST_cpl
copy_VarCoords(ice_cov,ice)
copy_VarCoords(sst_cpl,sst)
f4->ice_cov = ice
f4->SST_cpl = sst

end

