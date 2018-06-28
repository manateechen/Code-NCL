;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                ;
;                     EOF and Fourier Analysis                   ;
;                                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

filepath="ave.txt"
n=160                              ;the total number of weather stations
nyears=58                          ;the whole time span

year=ispan(1951,2008,1)            ;the calender

dat=asciiread(filepath,(/n*nyears,3/),"float")

lat=dat(0:n-1,0)                   ;the latitude of each station
lon=dat(0:n-1,1)                   ;the longitude of each station
pre=new((/n,nyears/),float)

do i=0,nyears-1
  pre(:,i)=dat(i*160:(i+1)*160-1,2)
end do

fourier_year=ezfftf(pre)           ;apply the Fourier Analysis
fourier_year(:,:,0:6)=0.           ;seperate the annual and decade signal
                                   ;8 year is the criterion
fourier_decade=ezfftf(pre)
fourier_decade(:,:,7:nyears/2-1)=0.

neof=2                             ;about the EOF function
optEOF = True       
optEOF@jopt = 0 
optEOF@pcrit = 85 
optETS = True
optETS@jopt = 0 
optAve=1

;compound new data series with annual and decade signals

recov_year=ezfftb(fourier_year,fourier_year@xbar)
eof_year=eofunc(recov_year,neof,optEOF)
eof_ts_year=eofunc_ts_Wrap(recov_year,eof_year,optETS)
asciiwrite("annual.txt",eof_ts_year)

recov_decade=ezfftb(fourier_decade,fourier_decade@xbar)
eof_decade=eofunc(recov_decade,neof,optEOF)
eof_ts_decade=eofunc_ts_Wrap(recov_decade,eof_decade,optETS)
asciiwrite("decade.txt",eof_ts_decade)

eof_ts_year!1="time"               ;several attributes of the EOF time series
eof_ts_year@long_name="time"
eof_ts_year@units = "year"
eof_ts_year@time=year

eof_ts_decade!1="time"
eof_ts_decade@long_name="time"
eof_ts_decade@units = "year"
eof_ts_decade@time=year

ave_year=runave_n_Wrap(eof_ts_year,11,optAve,1)     ;do the 11-year slide
ave_decade=runave_n_Wrap(eof_ts_decade,11,optAve,1) ;average


;below is the process of interpolation

ilat=new(26,"float")
ilon=new(36,"float")
inannu_new=new((/neof,26,36/),"float")
indeca_new=new((/neof,26,36/),"float")

do i=0,35
  ilon(i)=100+i
end do

ilon!0 = "lon"
ilon@long_name = "lon"
ilon@units = "degrees-east"
ilon&lon = ilon
 
do i=0,25
  ilat(i)=15+i
end do

ilat!0 = "lat"
ilat@long_name = "lat"
ilat@units = "degrees_north"
ilat&lat = ilat

inannu_new@_FillValue = 1.e-30
indeca_new@_FillValue = 1.e-30

rscan = (/50,25,10,8,5/)

do i=0,neof-1
  inannu_new(i,:,:)=obj_anal_ic_deprecated(lon,lat,eof_year(i,:),ilon,ilat,rscan,False)
  indeca_new(i,:,:)=obj_anal_ic_deprecated(lon,lat,eof_decade(i,:),ilon,ilat,rscan,False)
end do

wks=gsn_open_wks("png","EOF")
gsn_define_colormap(wks,"BlWhRe")

;below are some attributes of the EOF image

res=True

res@gsnDraw=False
res@gsnFrame=False
res@gsnSpreadColors=True
res@gsnAddCyclic=False

res@mpMinLatF=15.
res@mpMaxLatF=40.
res@mpMinLonF=100.
res@mpMaxLonF=135.

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

;here are the attributes of image for EOF time series

rts           = True

rts@gsnScale  = True 
rts@gsnDraw   = False
rts@gsnFrame  = False

rts@gsnYRefLine           = 0.         ;reference line
rts@gsnXYBarChart         = True       ;draw a bar chart
rts@gsnAboveYRefLineColor = "black"    ;the color of the bar above and 
rts@gsnBelowYRefLineColor = "black"    ;below the reference line
rts@gsnXYBarChartBarWidth = 0.3
rts@vpWidthF  = 0.70
rts@vpHeightF = 0.26
rts@tiYAxisString = "" 

r_ave=True
r_ave@gsnScale  = True 
r_ave@gsnDraw   = False
r_ave@gsnFrame  = False
r_ave@xyLineThicknessF = 1.5              ;the thickness of the line 
r_ave@xyMarkLineMode  = "MarkLines"       ;the stytle of the line
r_ave@xyMarker  = 1                       ;the format of marker
r_ave@xyMarkerSizeF  = 0.03               ;the size of the marker

;the attributes about the panel

resP                     = True

resP@gsnPanelLabelBar    = True
resP@lbOrientation       = "Vertical"
resP@gsnPanelPerimOn = True
resP@lbLabelAutoStride   = True

;plotting

plot=new((/neof,neof/),graphic)

;first plot the annual part

do i=0,neof-1
  res@gsnLeftString  = "EOF"+(i+1)+" of Precipitation in China (annual)"
  res@gsnRightString = sprintf("%5.1f", eof_year@pcvar(i)) +"%"
  plot(0,i)=gsn_csm_contour_map(wks,inannu_new(i,:,:),res)
  plot(1,i)=gsn_csm_xy(wks,year,eof_ts_year(i,:),rts)
  pl=gsn_csm_xy(wks,ave_year@time,ave_year(i,:),r_ave)
  overlay(plot(1,i),pl)
  gsn_panel(wks,plot(:,i),(/2,1/),resP)
end do

;then plot the decade part

do i=0,neof-1
  res@gsnLeftString  = "EOF"+(i+1)+" of Precipitation in China (decade)"
  res@gsnRightString = sprintf("%5.1f", eof_decade@pcvar(i)) +"%"
  plot(0,i)=gsn_csm_contour_map(wks,indeca_new(i,:,:),res)
  plot(1,i)=gsn_csm_xy(wks,year,eof_ts_decade(i,:),rts)
  pl=gsn_csm_xy(wks,ave_decade@time,ave_decade(i,:),r_ave)
  overlay(plot(1,i),pl)
  gsn_panel(wks,plot(:,i),(/2,1/),resP)
end do

end