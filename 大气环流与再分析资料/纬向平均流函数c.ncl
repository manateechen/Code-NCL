load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl" 

f1=addfile("ECMWF_monthly_681905210.nc","r")

lev=f1->lev
lat=f1->lat
v=f1->V
ps=f1->PS
nlat=dimsizes(lat)
nlev=dimsizes(lev)
psi=new((/12,nlev,nlat/),"float")

do i=0,11
psi(i,:,:) = zonal_mpsi_Wrap(v(i,::-1,:,:),lat,lev(::-1)*100.0,ps(i,:,:)*100.0)
end do

wks=gsn_open_wks("png","streamfuc")

res=True
res@gsnMaximize=True          
res@gsnLeftString=""  

mon=(/"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"/)

do i=0,11
  res@tiMainString="Zonal stream function in "+mon(i)
  plot=gsn_csm_pres_hgt(wks,psi(i,:,:),res)
end do

v_ave=dim_avg_n_Wrap(v,0)
ps_ave=dim_avg_n_Wrap(ps,0)
psi_ave = zonal_mpsi_Wrap(v_ave(::-1,:,:),lat,lev(::-1)*100.0,ps_ave(:,:)*100.0)
psi_diff=psi
do i=0,11
  psi_diff(i,:,:)=psi(i,:,:)-psi_ave
end do
do i=0,11
  res@tiMainString="Zonal stream function change in "+mon(i)
  plot=gsn_csm_pres_hgt(wks,psi_diff(i,:,:),res)
end do
