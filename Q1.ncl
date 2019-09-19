load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

; This script is used to calculate Q1

system("rm -rf q1.nc")

dlwrf_sfc_file = addfile("./dlwrf.sfc.mon.mean.nc","r")
dswrf_ntat_file = addfile("./dswrf.ntat.mon.mean.nc","r")
dswrf_sfc_file = addfile("./dswrf.sfc.mon.mean.nc","r")
lhtfl_sfc_file = addfile("./lhtfl.sfc.mon.mean.nc","r")
prate_sfc_file = addfile("./prate.sfc.mon.mean.nc","r")
shtfl_sfc_file = addfile("./shtfl.sfc.mon.mean.nc","r")
ulwrf_ntat_file = addfile("./ulwrf.ntat.mon.mean.nc","r")
ulwrf_sfc_file = addfile("./ulwrf.sfc.mon.mean.nc","r")
uswrf_ntat_file = addfile("./uswrf.ntat.mon.mean.nc","r")
uswrf_sfc_file = addfile("./uswrf.sfc.mon.mean.nc","r")
nswrf_file = addfile("./nswrs.sfc.mon.mean.nc","r")
nlwrf_file = addfile("./nlwrs.sfc.mon.mean.nc","r")
air_sfc_file = addfile("./air.2m.mon.mean.nc","r")

lat=dlwrf_sfc_file->lat
lon=dlwrf_sfc_file->lon

dlwrf_sfc  = short2flt(dlwrf_sfc_file->dlwrf)
dswrf_ntat = short2flt(dswrf_ntat_file->dswrf)
dswrf_sfc  = short2flt(dswrf_sfc_file->dswrf)
lhtfl_sfc  = short2flt(lhtfl_sfc_file->lhtfl)
prate_sfc  = short2flt(prate_sfc_file->prate)
shtfl_sfc  = short2flt(shtfl_sfc_file->shtfl)
ulwrf_ntat = short2flt(ulwrf_ntat_file->ulwrf)
ulwrf_sfc  = short2flt(ulwrf_sfc_file->ulwrf)
uswrf_ntat = short2flt(uswrf_ntat_file->uswrf)
uswrf_sfc  = short2flt(uswrf_sfc_file->uswrf)
nswrf = nswrf_file->nswrs
nlwrf = nlwrf_file->nlwrs
air_sfc = short2flt(air_sfc_file->air)



;q1_data = shtfl_sfc + (ulwrf_sfc - ulwrf_ntat + uswrf_sfc - uswrf_ntat + dswrf_ntat - dswrf_sfc - dlwrf_sfc) + prate_sfc*1859*air_sfc(:,0,:,:)
;q1_data = (shtfl_sfc) + (ulwrf_sfc - ulwrf_ntat + uswrf_sfc - uswrf_ntat + dswrf_ntat - dswrf_sfc - dlwrf_sfc) + prate_sfc*1859*air_sfc(:,0,:,:)
q1_data = dswrf_ntat - ulwrf_ntat - uswrf_ntat + nswrf(372:853,:,:) + nlwrf(372:853,:,:) + shtfl_sfc + prate_sfc*2510600.832
copy_VarMeta(uswrf_sfc, q1_data)
printVarSummary(q1_data)

AA = shtfl_sfc 
copy_VarMeta(uswrf_sfc, AA)
BB = dswrf_ntat - ulwrf_ntat - uswrf_ntat + nswrf(372:853,:,:) + nlwrf(372:853,:,:) 
copy_VarMeta(uswrf_sfc, BB)
CC = prate_sfc*2510600.832
copy_VarMeta(uswrf_sfc, CC)

out = addfile("q1.nc","c")
out->q1 = q1_data
out->AA = AA
out->BB = BB
out->CC = CC