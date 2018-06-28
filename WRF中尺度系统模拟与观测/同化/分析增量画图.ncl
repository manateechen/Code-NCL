load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

filepath="/home2_hn/QQF/MCS/2014DA/psot/"

ind_level=14

psot_u_file=addfile(filepath+"psot_u","r")
psot_v_file=addfile(filepath+"psot_v","r")
psot_p_file=addfile(filepath+"psot_p","r")
psot_t_file=addfile(filepath+"psot_t","r")

psot_u_U=psot_u_file->U(0,:,:,:)
psot_u_V=psot_u_file->V(0,:,:,:)
psot_u_T=psot_u_file->T(0,:,:,:)
psot_u_P=psot_u_file->PSFC(0,:,:)
psot_u_H=psot_u_file->PH(0,:,:,:)

psot_v_U=psot_v_file->U(0,:,:,:)
psot_v_V=psot_v_file->V(0,:,:,:)
psot_v_T=psot_v_file->T(0,:,:,:)
psot_v_P=psot_v_file->PSFC(0,:,:)
psot_v_H=psot_v_file->PH(0,:,:,:)

psot_t_U=psot_t_file->U(0,:,:,:)
psot_t_V=psot_t_file->V(0,:,:,:)
psot_t_T=psot_t_file->T(0,:,:,:)
psot_t_P=psot_t_file->PSFC(0,:,:)
psot_t_H=psot_t_file->PH(0,:,:,:)

psot_p_U=psot_p_file->U(0,:,:,:)
psot_p_V=psot_p_file->V(0,:,:,:)
psot_p_T=psot_p_file->T(0,:,:,:)
psot_p_P=psot_p_file->PSFC(0,:,:)
psot_p_H=psot_p_file->PH(0,:,:,:)

lat = wrf_user_getvar(psot_p_file,"XLAT",0)
lon = wrf_user_getvar(psot_p_file,"XLONG",0)

x1=95
y1=73
x2=115
z1=15
xx=fspan(0,189,1000)
yy=fspan(0,146,1000)

cross1=yy
cross1=x1
cross2=yy
cross2=x2
cross3=xx
cross3=y1

wks = gsn_open_wks("eps", "test")

res                 = True
res@gsnFrame        = False
res@cnMonoLineColor = False
res@gsnSpreadColors = True
res@cnInfoLabelOn   = False
res@cnLineLabelDensityF=6
res@cnLineThicknessF=2
res@vpHeightF          = 0.21
res@vpWidthF           = 0.21

gsres               = True
gsres@gsMarkerIndex = 1
gsres@gsMarkerSizeF      = 0.02

resp                  = True                    
resp@gsLineColor      = "red"                   
resp@gsLineThicknessF = 2.0           

res@vpXF              = 0.03
res@vpYF              = 0.98
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_u_U(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

res@vpXF              = 0.28
res@vpYF              = 0.98
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_u_V(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross2,yy,resp)

res@vpXF              = 0.53
res@vpYF              = 0.98
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_u_T(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

res@vpXF              = 0.78
res@vpYF              = 0.98
res@gsnLeftString     = "PSFC"
plot=gsn_csm_contour(wks,psot_u_P,res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@vpXF              = 0.03
res@vpYF              = 0.73
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_v_U(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross2,yy,resp)

res@vpXF              = 0.28
res@vpYF              = 0.73
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_v_V(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

res@vpXF              = 0.53
res@vpYF              = 0.73
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_v_T(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,xx,cross3,resp)

res@vpXF              = 0.78
res@vpYF              = 0.73
res@gsnLeftString     = "PSFC"
plot=gsn_csm_contour(wks,psot_v_P,res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,xx,cross3,resp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@vpXF              = 0.03
res@vpYF              = 0.48
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_t_U(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

res@vpXF              = 0.28
res@vpYF              = 0.48
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_t_V(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,xx,cross3,resp)

res@vpXF              = 0.53
res@vpYF              = 0.48
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_t_T(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

res@vpXF              = 0.78
res@vpYF              = 0.48
res@gsnLeftString     = "PSFC"
plot=gsn_csm_contour(wks,psot_t_P,res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@vpXF              = 0.03
res@vpYF              = 0.23
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_p_U(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

res@vpXF              = 0.28
res@vpYF              = 0.23
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_p_V(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,xx,cross3,resp)

res@vpXF              = 0.53
res@vpYF              = 0.23
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_p_T(ind_level,:,:),res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

res@vpXF              = 0.78
res@vpYF              = 0.23
res@gsnLeftString     = "PSFC"
plot=gsn_csm_contour(wks,psot_p_P,res)
gsn_polymarker(wks,plot,x1,y1,gsres)
gsn_polyline(wks,plot,cross1,yy,resp)

draw(plot) 
frame(wks)
delete(wks)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

wks = gsn_open_wks("eps", "test1")

res@vpXF              = 0.03
res@vpYF              = 0.98
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_u_U(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.28
res@vpYF              = 0.98
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_u_V(:,:,x2),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.53
res@vpYF              = 0.98
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_u_T(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.78
res@vpYF              = 0.98
res@gsnLeftString     = "GH"
plot=gsn_csm_contour(wks,psot_u_H(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@vpXF              = 0.03
res@vpYF              = 0.73
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_v_U(:,:,x2),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.28
res@vpYF              = 0.73
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_v_V(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.53
res@vpYF              = 0.73
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_v_T(:,y1,:),res)
gsn_polymarker(wks,plot,x1,z1,gsres)

res@vpXF              = 0.78
res@vpYF              = 0.73
res@gsnLeftString     = "GH"
plot=gsn_csm_contour(wks,psot_v_H(:,y1,:),res)
gsn_polymarker(wks,plot,x1,z1,gsres)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@vpXF              = 0.03
res@vpYF              = 0.48
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_t_U(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.28
res@vpYF              = 0.48
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_t_V(:,y1,:),res)
gsn_polymarker(wks,plot,x1,z1,gsres)

res@vpXF              = 0.53
res@vpYF              = 0.48
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_t_T(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.78
res@vpYF              = 0.48
res@gsnLeftString     = "GH"
plot=gsn_csm_contour(wks,psot_t_H(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

res@vpXF              = 0.03
res@vpYF              = 0.23
res@gsnLeftString     = "U"
plot=gsn_csm_contour(wks,psot_p_U(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.28
res@vpYF              = 0.23
res@gsnLeftString     = "V"
plot=gsn_csm_contour(wks,psot_p_V(:,y1,:),res)
gsn_polymarker(wks,plot,x1,z1,gsres)

res@vpXF              = 0.53
res@vpYF              = 0.23
res@gsnLeftString     = "THETA"
plot=gsn_csm_contour(wks,psot_p_T(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)

res@vpXF              = 0.78
res@vpYF              = 0.23
res@gsnLeftString     = "GH"
plot=gsn_csm_contour(wks,psot_p_H(:,:,x1),res)
gsn_polymarker(wks,plot,y1,z1,gsres)



