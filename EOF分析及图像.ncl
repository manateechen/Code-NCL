;========================================================
;ÓÃÓÚ¼ÆËã²¢»­³öGeopotential HeightµÄEOF·ÖÎö¼°Í¼Ïñ
;========================================================


load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

filepath="G:/hgt.mon.mean.nc"
data=addfile(filepath,"r")

;===============ÉèÖÃ×ö·Ö½âµÄµØÇøÓëÊ±¼ä¶Î=================
lonL=72.                              
lonR=136.
latS=17.
latN=55.
yrStrt=1990                           
yrLast=2003

TIME=data->time

iy=ut_calendar(TIME,-1)/100           ;½«×ÊÁÏÊ±¼ä×ªÎªÊÀ½çÊ±

t=ind(iy.ge.yrStrt .and. iy.le.yrLast);Ñ¡È¡ËùÐèÊ±¶ÎµÄÐòºÅ

neof   = 3                            ; number of EOFs


;====================¹ØÓÚEOFº¯ÊýµÄÒ»Ð©ÊôÐÔÉèÖÃ===========
optEOF = True       
optEOF@jopt = 0  
optETS = False
optAve=0

;=============¶ÁÈ¡×ÊÁÏ²¢½«¸ñÊ½×ª»»³ÉÓëEOFº¯ÊýÏàÊÊÓ¦======
hgt=data->hgt(t,0,:,:)
hgt=lonFlip(hgt)
HGT=hgt({lat|latS:latN},{lon|lonL:lonR},time|:)


;=============½øÐÐEOF¼°Ïà¹ØÊ±¼äÏµÊýµÄ´¦Àí================
eof=eofunc_Wrap(HGT,neof,optEOF)
eof_ts=eofunc_ts_Wrap (HGT,eof,optETS)
year = ut_calendar(eof_ts&time,4)
ave=runave_n_Wrap(eof_ts,7,optAve,1)     ;¶ÔÊ±¼äÏµÊý×÷»¬¶¯Æ½¾ù(7 mons)  
year_ave=ut_calendar(ave&time,4)


wks=gsn_open_wks("x11","EOF")
gsn_define_colormap(wks,"BlWhRe")


;=============EOFÍ¼ÏñµÄÊôÐÔÉèÖÃ==========================

res=True

res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False

res@mpMinLatF=latS
res@mpMaxLatF=latN
res@mpMinLonF=lonL
res@mpMaxLonF=lonR

res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion = "MediumRes"

res@mpOutlineOn = True
res@mpOutlineSpecifiers = (/"China:states","Taiwan"/)
res@mpMaskAreaSpecifiers = (/"China:states","Taiwan"/)
res@mpPerimOn   = True
res@mpGridMaskMode  = "MaskLand"
res@mpOceanFillColor = 0
res@mpInlandWaterFillColor = 0

res@cnFillOn=True
res@cnLinesOn=False
res@cnFillDrawOrder="PreDraw"

res@lbLabelBarOn         = False


;==========EOFÊ±¼äÏµÊýÍ¼ÏñµÄÊôÐÔÉèÖÃ=====================

rts           = True

rts@gsnScale  = True 
rts@gsnDraw   = False
rts@gsnFrame  = False
             
rts@gsnYRefLine           = 0.         ;ÉèÖÃ²Î¿¼Ïß   
rts@gsnXYBarChart         = True       ;Ñ¡Ôñ»­µÄÍ¼ÎªÖù×´Í¼  
rts@gsnAboveYRefLineColor = "white"    ;²Î¿¼ÏßÉÏÏÂ²¿Í¼ÏñÓë²Î¿¼Ïß     
rts@gsnBelowYRefLineColor = "white"    ;Î§³ÉÍ¼ÐÎµÄÑÕÉ«ÉèÖÃ

rts@vpWidthF  = 0.70
rts@vpHeightF = 0.26
rts@tiYAxisString = ""        


;=========»¬¶¯Æ½¾ùºóµÄÊ±¼äÏµÊýÍ¼ÏñµÄÊôÐÔÉèÖÃ=============

r_ave=True
r_ave@gsnScale  = True 
r_ave@gsnDraw   = False
r_ave@gsnFrame  = False
r_ave@xyLineThicknessF = 1.5              ;ÉèÖÃ»¬¶¯ÇúÏßµÄ´ÖÏ¸ 
r_ave@xyMarkLineMode  = "MarkLines"       ;ÉèÖÃ»¬¶¯ÇúÏßµÄÐÎÊ½
r_ave@xyMarker  = 1                       ;ÉèÖÃÃè»æµÄÊý¾ÝµãµÄ¸ñÊ½
r_ave@xyMarkerSizeF  = 0.03               ;ÉèÖÃÊý¾ÝµãµÄ´óÐ¡


;===============¿ØÖÆ°åµÄÊôÐÔÉèÖÃ=========================

resP                     = True
resP@gsnPanelLabelBar    = True
resP@lbOrientation       = "Vertical"
resP@gsnPanelPerimOn = True
resP@lbLabelAutoStride   = True

  

plot=new((/2,neof/),graphic)

do i=0,neof-1
  res@gsnLeftString  = "EOF"+(i+1)+" of Geopotential Height in China"
  res@gsnRightString = sprintf("%5.1f", eof@pcvar(i)) +"%"
  plot(0,i)=gsn_csm_contour_map(wks,eof(i,:,:),res)
  plot(1,i)=gsn_csm_xy(wks,year,eof_ts(i,:),rts)
  pl=gsn_csm_xy(wks,year_ave,ave(i,:),r_ave)
  overlay(plot(1,i),pl)
  gsn_panel(wks,plot(:,i),(/2,1/),resP)
end do

end