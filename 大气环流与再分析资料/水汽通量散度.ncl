load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

  wks=gsn_open_wks("png","div")
  
  res=True
  
  res@gsnMaximize=True
  res@gsnAddCyclic=False
  
  res@mpDataSetName = "Earth..4"
  res@mpDataBaseVersion = "MediumRes"
  res@mpOutlineOn = True
  res@mpOutlineSpecifiers = (/"China:states"/)
  res@mpMaxLatF=60
  res@mpMinLatF=10
  res@mpMaxLonF=160
  res@mpMinLonF=100
  
  res@cnFillOn=True
  res@cnLinesOn=False
  
  res@gsnRightString = "unit:s/m"
  
pathhead="d:\data\fnl_201207"

do i=19,21
  do j=0,18,6
  
  if(j.lt.10) then
  hupath=pathhead+i+"_0"+j+"_00_c.qi24303.nc"
  uvpath=pathhead+i+"_0"+j+"_00_c.qifeng21189.nc"
  else
  hupath=pathhead+i+"_"+j+"_00_c.qi24303.nc"
  uvpath=pathhead+i+"_"+j+"_00_c.qifeng21189.nc"
  end if
  
  data_uv=addfile(uvpath,"r")
  data_hu=addfile(hupath,"r")
  
  lat_uv=data_uv->lat_3
  lon_uv=data_uv->lon_3
  lev_uv=data_uv->lv_ISBL1
  time=data_uv->initial_time0
  
  lat_hu=data_hu->lat_3
  lon_hu=data_hu->lon_3
  lev_hu=data_hu->lv_ISBL0
  
  ind_lat_uv=ind(lat_uv.ge.10.and.lat_uv.le.60)
  ind_lon_uv=ind(lon_uv.ge.100.and.lon_uv.le.160)
  
  ind_lat_hu=ind(lat_hu.ge.10.and.lat_hu.le.60)
  ind_lon_hu=ind(lon_hu.ge.100.and.lon_hu.le.160)
  
  u=data_uv->U_GRD_3_ISBL_10(0,:,ind_lat_uv,ind_lon_uv)
  v=data_uv->V_GRD_3_ISBL_10(0,:,ind_lat_uv,ind_lon_uv)
  t=data_hu->TMP_3_ISBL(:,ind_lat_hu,ind_lon_hu)
  r=data_hu->R_H_3_ISBL(:,ind_lat_hu,ind_lon_hu)
  
  es=new((/2,51,61/),float)
  do m=0,1
    do k=0,50
      do l=0,60
        if(t(m,k,l).gt.273.16) then
          es(m,k,l)=6.1078*exp(17.26*(t(m,k,l)-273.16)/(t(m,k,l)-35.86))
        else 
          es(m,k,l)=6.1078*exp(21.87*(t(m,k,l)-273.16)/(t(m,k,l)-7.66))
        end if
      end do
    end do
  end do
  
  copy_VarCoords(t,es)

  e=r*es/100
  copy_VarCoords(t,e)
  
  q=new((/2,51,61/),float)
  q(0,:,:)=622*e(0,:,:)/(700-0.378*e(0,:,:))
  q(1,:,:)=622*e(1,:,:)/(850-0.378*e(1,:,:))
  copy_VarCoords(t,q)
  
  uq=1./9.8*u*q
  vq=1./9.8*v*q
  lat=ispan(10,60,1)
  lon=ispan(100,160,1)
  div=-1*uv2dv_cfd(uq,vq,lat,lon,2)
  copy_VarCoords(u,div)
  
  res@tiMainString="Humidity Divergence at 850hPa "+time
  plot=gsn_csm_contour_map(wks,div(1,:,:),res)
  
  end do
end do
  
  