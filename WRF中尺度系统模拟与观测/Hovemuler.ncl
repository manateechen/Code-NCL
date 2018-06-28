load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
begin
;-----------------------------------------------------------------
a = addfile("./wrfout_d01_0001-01-01_00:00:00.nc","r")
b = addfile("./wrfout_sm.nc","r")
;b = addfile("../data/wrfout_sm_qf","r")
c = addfile("./wrfout_dm.nc","r")
d = addfile("./wrfout_dm_noifevp.nc","r")
d = addfile("./wrfout_dmnew_sed_mp.nc","r")
type = "x11"
 

times = wrf_user_getvar(a,"times",-1)
ntimes = dimsizes(times)

re_rain_a=wrf_user_getvar(a,"RAINNC",-1)
re_rain_b=wrf_user_getvar(b,"RAINNC",-1)
re_rain_c=wrf_user_getvar(c,"RAINNC",-1)
re_rain_d=wrf_user_getvar(d,"RAINNC",-1)

do it = 1,ntimes-1,1
    re_rain_a(it,:,:) = wrf_user_getvar(a,"RAINNC",it)+ wrf_user_getvar(a,"RAINC",it)-\
                         wrf_user_getvar(a,"RAINC",it-1)-wrf_user_getvar(a,"RAINNC",it-1)
    re_rain_b(it,:,:) = wrf_user_getvar(b,"RAINNC",it)+ wrf_user_getvar(b,"RAINC",it)-\
                         wrf_user_getvar(b,"RAINC",it-1)-wrf_user_getvar(b,"RAINNC",it-1)
    re_rain_c(it,:,:) = wrf_user_getvar(c,"RAINNC",it)+ wrf_user_getvar(c,"RAINC",it)-\
                         wrf_user_getvar(c,"RAINC",it-1)-wrf_user_getvar(c,"RAINNC",it-1)
    re_rain_d(it,:,:) = wrf_user_getvar(d,"RAINNC",it)+ wrf_user_getvar(d,"RAINC",it)-\
                         wrf_user_getvar(d,"RAINC",it-1)-wrf_user_getvar(d,"RAINNC",it-1)
end do


tot_a = dim_avg_n(dim_avg_n(re_rain_a(:,0,:),1),0)
tot_b = dim_avg_n(dim_avg_n(re_rain_b(:,0,:),1),0)
tot_c = dim_avg_n(dim_avg_n(re_rain_c(:,0,:),1),0)
tot_d = dim_avg_n(dim_avg_n(re_rain_d(:,0,:),1),0)
;===================================================================

res=True
res@gsnRightString   = "mm/10minutes"
res@gsnCenterString  = ""
;res@gsnDraw               = False       ; Draw plot
;res@gsnFrame              = False       ; advance page


res@gsnSpreadColors      = True                 ; use full range of map
res@cnLevelSelectionMode  = "ExplicitLevels"
res@cnFillOn             = True                 ; turn on color fill
res@cnLevels             = (/1,2,3,4,5,6,7,8,9,10,11,12,13/)
res@cnFillColors         = (/2,32,48,64,80,96,112,128,144,160,176,192,208,224/)

res@cnLineLabelsOn       = False                 ; turn on line labels
res@lbLabelAutoStride    = False                 ; optimal labels

;===================================plot ==============================
    wks = gsn_open_wks(type,"./test_rain")
    gsn_define_colormap(wks,"WhiteBlueGreenYellowRed") ; select color map

    res@gsnLeftString    = "test_2.5km"
    res@gsnRightString   = tot_a+"mm/10minutes"
    plot_a  = gsn_csm_contour(wks,re_rain_a(:,0,:), res)

    res@gsnRightString   = tot_b+"mm/10minutes"
    plot_b  = gsn_csm_contour(wks,re_rain_b(:,0,:), res)

    res@gsnRightString   = tot_c+"mm/10minutes"
    plot_c  = gsn_csm_contour(wks,re_rain_c(:,0,:), res)
 
    res@gsnRightString   = tot_d+"mm/10minutes"
    plot_d  = gsn_csm_contour(wks,re_rain_d(:,0,:), res)

    gsn_panel(wks,(/plot_a,plot_b,plot_c,plot_d/),(/2,2/),False)
end
