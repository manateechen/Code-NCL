load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl" 

path = "hgt.mon.mean.nc"
data = addfile(path,"r")
lev  = data->level
lat  = data->lat
lon  = data->lon
ti   = data->time

dim_lev = dimsizes(lev)
dim_lon = dimsizes(lon)
dim_lat = dimsizes(lat)
dim_tim = dimsizes(ti)/12*12

tim = ut_calendar(ti(0:dim_tim-1),4)

ind_500 = ind(lev.eq.500)

hgt = data->hgt(0:dim_tim-1,ind_500,:,:)
HGT = hgt(lat|:,lon|:,time|:)

lat_s = 20
lat_n = 70
lon_w = 40
lon_e = 140

neval       = 3
optEOF      = True
optEOF@jopt =0
optETS      =True
optETS      = 0
hgt_eof_jan = eofunc_Wrap(HGT(:,:,0::12),neval,optEOF)
hgt_ets_jan = eofunc_ts_Wrap(HGT(:,:,0::12),hgt_eof_jan,optETS)

res = True
res @gsnDraw=False
res @gsnFrame=False
res @gsnSpreadColors=True
res @gsnAddCyclic=True
;res @mpMinLatF=lat_s
;res @mpMaxLatF=lat_n
;res @mpMinLonF=lon_w
;res @mpMaxLonF=lon_e
res @mpDataSetName = "Earth..4"
res @mpDataBaseVersion = "MediumRes"
res @cnFillOn=True
res @cnLinesOn=False
res @lbLabelBarOn         = True
;res @lbOrientation       = "Vertical"


rts           = True
rts @gsnScale  = True 
rts @gsnDraw   = False
rts @gsnFrame  = False
rts @gsnYRefLine           = 0.         ;设置参考线   
rts @gsnXYBarChart         = True       ;选择画的图为柱状图  
rts @gsnAboveYRefLineColor = "red"    ;参考线上下部图像与参考线     
rts @gsnBelowYRefLineColor = "blue"    ;围成图形的颜色设置
rts @vpWidthF  = 0.80
rts @vpHeightF = 0.26
rts @tiYAxisString = ""        

resP                     = False
resP @gsnPaperWidth      =10
resP @gsnPanelLeft       =0.3
;resP @gsnPanelLabelBar    = True
;resP @lbOrientation       = "Vertical"
;resP @lbLabelAutoStride   = True

wks = gsn_open_wks("x11","EOF")
plot=new((/2,neval/),graphic)
do i=0,neval-1
  res @gsnLeftString = "EOF"+(i+1)
  res @gsnRightString = sprintf("%5.1f", hgt_eof_jan@pcvar(i)) +"%"
  plot(0,i)= gsn_csm_contour_map(wks,hgt_eof_jan(i,:,:),res)
  plot(1,i)=gsn_csm_xy(wks,tim(0::12),hgt_ets_jan(i,:),rts)
  gsn_panel(wks,plot(:,i),(/2,1/),resP)
end do



