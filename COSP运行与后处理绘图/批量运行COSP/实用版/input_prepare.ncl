load "/home/yyao/ncl//lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/home/yyao/ncl//lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/home/yyao/ncl//lib/ncarg/nclscripts/csm/contributed.ncl"
load "/home/yyao/ncl//lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "/home/yyao/ncl//lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

begin

	f       = addfile("/home/QQF2/wrf_file/2006/01/wrfout_d01_2006-01-04_18:00:00","r")
	time	= 0
	p	= wrf_user_getvar(f,"p",time)
	dim	= dimsizes(p)
	nlevel	= dim(0)
	npoint	= dim(1)*dim(2)
	lon	= reshape(wrf_user_getvar(f,"lon",time),(/npoint/))
	lon!0	= "point"
	lon	= where(lon.lt.0,lon+360,lon)

	lat	= reshape(wrf_user_getvar(f,"lat",time),(/npoint/))
	lat!0	= "point"

	landmask	= reshape(wrf_user_getvar(f,"XLAND",time),(/npoint/))
	landmask!0	= "point"
	landmask	= where(landmask.gt.1,0,1)

	orography	= reshape(wrf_user_getvar(f,"ter",time),(/npoint/))
	orography!0	= "point"

	psfc	= reshape(wrf_user_getvar(f,"PSFC",time),(/npoint/))
	psfc!0	= "point"

	height	= reshape((f->PH(time,1:,:,:)+f->PHB(time,1:,:,:))/9.81,(/nlevel,npoint/))
	height!0	= "level"
	height!1	= "point"

	height_half	= reshape(wrf_user_getvar(f,"z",time),(/nlevel,npoint/))
	height_half!0	= "level"
	height_half!1	= "point"

	T_abs	= reshape(wrf_user_getvar(f,"tk",time),(/nlevel,npoint/))
	T_abs!0	= "level"
	T_abs!1	= "point"

	qv	= reshape(wrf_user_getvar(f,"QVAPOR",time),(/nlevel,npoint/))
	qv	= qv/(1.0+qv)
	qv!0	= "level"
	qv!1	= "point"

	rh	= reshape(wrf_user_getvar(f,"rh",time),(/nlevel,npoint/))
	rh!0	= "level"
	rh!1	= "point"

	phalf	= reshape(wrf_user_getvar(f,"p",time),(/nlevel,npoint/))
	phalf!0	= "level"
	phalf!1	= "point"

	pfull	= phalf
	pfull(:nlevel-2,:)	= 0.5*(phalf(:nlevel-2,:)+phalf(1:nlevel-1,:))
	pfull(nlevel-1,:)	= f->P_TOP(time)

	mr_lsliq	= reshape(wrf_user_getvar(f,"QCLOUD",time),(/nlevel,npoint/))
	mr_lsliq!0	= "level"
	mr_lsliq!1	= "point"

	mr_lsice	= reshape(wrf_user_getvar(f,"QICE",time),(/nlevel,npoint/))
	mr_lsice!0	= "level"
	mr_lsice!1	= "point"


	mr_ccliq	= reshape(wrf_user_getvar(f,"QC_CU",time),(/nlevel,npoint/))
	mr_ccliq!0	= "level"
	mr_ccliq!1	= "point"

	mr_ccice	= reshape(wrf_user_getvar(f,"QI_CU",time),(/nlevel,npoint/))
	mr_ccice!0	= "level"
	mr_ccice!1	= "point"

	tca	= reshape(wrf_user_getvar(f,"CLDFRA",time),(/nlevel,npoint/))
	tca!0	= "level"
	tca!1	= "point"

	cca	= reshape(wrf_user_getvar(f,"CLDFRA_DP",time),(/nlevel,npoint/))
	cca	= cca+reshape(wrf_user_getvar(f,"CLDFRA_SH",time),(/nlevel,npoint/))
	cca!0	= "level"
	cca!1	= "point"

	c_minus_s	= cca-(tca-cca)
	taucld	= reshape(wrf_user_getvar(f,"TAUCLDI",time),(/nlevel,npoint/))+reshape(wrf_user_getvar(f,"TAUCLDC",time),(/nlevel,npoint/))

	dtau_s	= cca
	dtau_s	= 0
	dtau_s	= where(c_minus_s.le.0,taucld,0)

	dtau_c	= cca
	dtau_c	= 0
	dtau_c	= where(c_minus_s.gt.0,taucld,0)

	skt	= reshape(wrf_user_getvar(f,"TSK",time),(/npoint/))
	skt!0	= "point"

	coszen	= reshape(wrf_user_getvar(f,"COSZEN",time),(/npoint/))
	sunlit	= skt
	sunlit	= 0
	sunlit	= where(coszen.gt.0,1,0)

	emsfc_lw	= reshape(wrf_user_getvar(f,"EMISS",time),(/npoint/))
	emsfc_lw!0	= "point"

	system("rm -f test.nc")
	fout    = addfile("2006-01-04_18.nc","c")
	fout->lon	= lon
	fout->lat	= lat
	fout->landmask	= landmask
	fout->orography	= orography
	fout->psfc	= psfc
	fout->height	= height
	fout->height_half	= height_half
	fout->T_abs	= T_abs
	fout->qv	= qv
	fout->rh	= rh
	fout->pfull	= pfull
	fout->phalf	= phalf
	fout->mr_lsliq	= mr_lsliq
	fout->mr_lsice	= mr_lsice
	fout->mr_ccliq	= mr_ccliq
	fout->mr_ccice	= mr_ccice
	fout->tca	= tca
	fout->cca	= cca
	fout->dtau_s	= dtau_s
	fout->dtau_c	= dtau_c
	fout->skt	= skt
	fout->sunlit	= sunlit
	fout->emsfc_lw	= emsfc_lw

end
