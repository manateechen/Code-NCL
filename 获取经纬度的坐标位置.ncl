nc_file=addfile("met_em.d03.2014-05-22_18:00:00.nc","r")


opt = True
  opt@MAP_PROJ  = nc_file@MAP_PROJ
  opt@TRUELAT1  = nc_file@TRUELAT1
  opt@TRUELAT2  = nc_file@TRUELAT2
  opt@STAND_LON = nc_file@STAND_LON
  opt@DX        = nc_file@DX
  opt@DY        = nc_file@DY

  XLAT  = nc_file->XLAT_M(0,:,:)
  XLONG = nc_file->XLONG_M(0,:,:)

  opt@REF_LAT = XLAT(0,0)
  opt@REF_LON = XLONG(0,0)
opt@KNOWNI  = 1.0
  opt@KNOWNJ  = 1.0

;loc = wrf_ll_to_ij( 112.8810, 24.3944, opt )
;loc = wrf_ll_to_ij( 112.8279, 23.3567, opt )
;loc = wrf_ll_to_ij( 112.9060, 23.4286, opt )
;loc = wrf_ll_to_ij( 113.3150, 23.1389, opt )
;loc = wrf_ll_to_ij( 113.4330, 23.0333, opt )
loc = wrf_ll_to_ij( 114, 23, opt )
print(loc)