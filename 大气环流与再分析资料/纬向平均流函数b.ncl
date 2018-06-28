load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl" 

f1=addfile("ECMWF_monthly_681905210.nc","r")

lev=f1->lev
ind_850=ind(lev.eq.850.0)
ind_200=ind(lev.eq.200.0)

u_850=f1->U(:,ind_850,:,:)
u_200=f1->U(:,ind_200,:,:)
v_850=f1->V(:,ind_850,:,:)
v_200=f1->V(:,ind_200,:,:)
speed_850=sqrt(u_850^2+v_850^2)
speed_200=sqrt(u_200^2+v_200^2)
t_850=f1->T(:,ind_850,:,:)
t_200=f1->T(:,ind_200,:,:)

res=True
res@tfDoNDCOverlay=True
res@pmTickMarkDisplayMode="Always"
res@gsnMaximize=True          
res@gsnSpreadColors=True  
res@gsnDraw=False
res@gsnFrame=False
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False

stres=True
stres@tfDoNDCOverlay=True
stres@stRefLengthF=0.05
stres@stMinDistanceF=0.020
stres@gsnMaximize=True 
stres@gsnRightString          = ""
stres@gsnLeftString           = ""
stres@gsnDraw                 = False
stres@gsnFrame                = False   
stres@tiXAxisString=""
stres@tiYAxisString=""
stres@gsnRightString="unit:m/s"
stres@stLineThicknessF=2.0

mon=(/"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"/)

do i=0,11
  wks1=gsn_open_wks("png","850_v"+i+1)
  gsn_define_colormap(wks1,"WhiteBlue")
  res@tiMainString="850_V_"+mon(i)
  plt1=gsn_csm_contour_map(wks1,speed_850(i,:,:),res)
  plt2=gsn_csm_streamline(wks1,u_850(i,:,:),v_850(i,:,:),stres)
  overlay(plt1,plt2)
  draw(plt1)
  frame(wks1)
  delete(wks1)
  
  wks1=gsn_open_wks("png","200_v"+i+1)
  gsn_define_colormap(wks1,"WhiteBlue")
  res@tiMainString="200_V_"+mon(i)
  plt1=gsn_csm_contour_map(wks1,speed_200(i,:,:),res)
  plt2=gsn_csm_streamline(wks1,u_200(i,:,:),v_200(i,:,:),stres)
  overlay(plt1,plt2)
  draw(plt1)
  frame(wks1)
  delete(wks1)    
end do
  
delete(res)
delete(stres)

res=True
res@tfDoNDCOverlay=True
res@pmTickMarkDisplayMode="Always"
res@gsnMaximize=True          
res@gsnSpreadColors=True  
res@gsnDraw=False
res@gsnFrame=False
res@cnFillOn=True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@gsnRightString          = "unit:K"
res@gsnLeftString          = ""

do i=0,11
  wks1=gsn_open_wks("png","850_t"+i+1)
  gsn_define_colormap(wks1,"cmp_b2r")
  res@tiMainString="850_T_"+mon(i)
  plt1=gsn_csm_contour_map(wks1,t_850(i,:,:),res)
  draw(plt1)
  frame(wks1)
  delete(wks1)
  
  wks1=gsn_open_wks("png","200_t"+i+1)
  gsn_define_colormap(wks1,"cmp_b2r")
  res@tiMainString="200_T_"+mon(i)
  plt1=gsn_csm_contour_map(wks1,t_200(i,:,:),res)
  draw(plt1)
  frame(wks1)
  delete(wks1)    
end do  
  
  
  
  
  
  