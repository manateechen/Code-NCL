load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"


;========Shuman-Shapiro Filter( 1 dimension 3 points )============

procedure ssfilter1(origin[*][*]:float,filter[*][*]:float,s:float,rest[*][*]:float)

local i,m

begin

m = dimsizes(origin)

do i=1,m(0)-2
  filter(:,i)=origin(:,i)+s*(origin(:,i+1)+origin(:,i-1)-2.*origin(:,i))/2.
end do

rest = origin-filter

end


;========Shuman-Shapiro Filter( 2 dimension 9 points )============

procedure ssfilter2(origin[*][*]:float,filter[*][*]:float,s:float,rest[*][*]:float)

local i,j,m

begin

m = dimsizes(origin)

do i=1,m(0)-2
  do j=1,m(0)-2
    filter(i,j)=origin(i,j)+s*(s-1)/2.*(origin(i+1,j)+origin(i,j+1)+origin(i-1,j)\
    +origin(i,j-1)-4.*origin(i,j))+s^2/4.*(origin(i+1,j+1)+origin(i-1,j+1)\
    +origin(i-1,j-1)+origin(i+1,j-1)-4.*origin(i,j))
  end do
end do

rest = origin-filter

end


;========parameters of Shuman-Shapiro Filter============

pi=3.14159265
n = 2
s = 0.5
R_1_3 = 1.-2.*s*(sin(pi/n))^2
R_2_9 = (1.-2.*s*(sin(pi/n))^2)^2


wks = gsn_open_wks("png","cm")


;========set the resources of hgt contour image============

hgt_res = True

hgt_res@gsnMaximize = True
hgt_res@gsnAddCyclic = False

hgt_res@mpDataSetName = "Earth..4"
hgt_res@mpDataBaseVersion = "MediumRes"

hgt_res@mpMaxLatF = 51.1
hgt_res@mpMinLatF = 29.5
hgt_res@mpMaxLonF = 127.5
hgt_res@mpMinLonF = 105.3

hgt_res@mpOutlineOn = True
hgt_res@mpOutlineSpecifiers = (/"China:states","Taiwan"/)
hgt_res@mpMaskAreaSpecifiers = (/"China:states","Taiwan"/)
hgt_res@mpPerimOn   = True

hgt_res@cnFillOn = True
hgt_res@cnLinesOn = False
hgt_res@cnFillDrawOrder = "PreDraw"


;========set the resources of streamline image============

str_res = True

str_res@gsnMaximize = True
str_res@gsnAddCyclic = False

str_res@mpDataSetName = "Earth..4"
str_res@mpDataBaseVersion = "MediumRes"

str_res@mpMaxLatF = 51.1
str_res@mpMinLatF = 29.5
str_res@mpMaxLonF = 127.5
str_res@mpMinLonF = 105.3

str_res@mpOutlineOn = True
str_res@mpOutlineSpecifiers = (/"China:states"/)
str_res@mpMaskAreaSpecifiers = (/"China:states"/)
str_res@mpPerimOn   = True

str_res@stMonoLineColor = False

str_res@stLineThicknessF = 2.7


;========set the resources of vector image============

vec_res = True

vec_res@gsnMaximize = True
vec_res@gsnAddCyclic = False

vec_res@mpDataSetName = "Earth..4"
vec_res@mpDataBaseVersion = "MediumRes"

vec_res@mpMaxLatF = 51.1
vec_res@mpMinLatF = 29.5
vec_res@mpMaxLonF = 127.5
vec_res@mpMinLonF = 105.3

vec_res@mpOutlineOn = True
vec_res@mpOutlineSpecifiers = (/"China:states"/)
vec_res@mpMaskAreaSpecifiers = (/"China:states"/)
vec_res@mpPerimOn   = True

vec_res@vcFillArrowsOn = True
vec_res@vcGlyphStyle = "FillArrow"
vec_res@vcMonoFillArrowFillColor = False
vec_res@vcFillArrowWidthF = 0.4
vec_res@vcLineArrowThicknessF = 3
vec_res@vcMinFracLengthF = 1.
vec_res@vcFillArrowHeadMinFracXF = 1.
vec_res@vcFillArrowHeadMinFracYF = 1.


;========use loop to deal the data sets============

do i=2,13

  path = "D:\c"+i+".nc"
  data = addfile(path,"r")
  VWND = data->V_GRD_3_ISBL_10
  UWND = data->U_GRD_3_ISBL_10
  HGT  = data->HGT_3_ISBL_10
  LAT  = data->lat_3
  LON  = data->lon_3
  TIME = data->initial_time0
  
  lat_ind = ind(LAT.le.53.and.LAT.ge.28)
  lon_ind = ind(LON.le.129.and.LON.ge.104)
  
  vwnd_700 = VWND(0,0,lat_ind,lon_ind)
  vwnd_850 = VWND(0,1,lat_ind,lon_ind)
  uwnd_700 = UWND(0,0,lat_ind,lon_ind)
  uwnd_850 = UWND(0,1,lat_ind,lon_ind)
  hgt_700  = HGT(0,0,lat_ind,lon_ind)
  hgt_850  = HGT(0,1,lat_ind,lon_ind)
  
  sshgt_700 = hgt_700
  sshgt_850 = hgt_850
  ssvwnd_700 = vwnd_700
  ssvwnd_850 = vwnd_850
  ssuwnd_700 = uwnd_700
  ssuwnd_850 = uwnd_850
  
  resthgt_700 = hgt_700
  resthgt_850 = hgt_850
  restvwnd_700 = vwnd_700
  restvwnd_850 = vwnd_850
  restuwnd_700 = uwnd_700
  restuwnd_850 = uwnd_850
  
 ;========plot the origin image============
 
  hgt_res@tiMainString = "hgt_850_origin "+TIME
  plot = gsn_csm_contour_map(wks,hgt_850,hgt_res)
  
  hgt_res@tiMainString = "hgt_700_origin "+TIME
  plot = gsn_csm_contour_map(wks,hgt_700,hgt_res)

  str_res@tiMainString = "str_850_origin "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,uwnd_850,vwnd_850,str_res)
  
  str_res@tiMainString = "str_700_origin "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,uwnd_700,vwnd_700,str_res)
  
  vec_res@tiMainString = "vec_850_origin "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,uwnd_850,vwnd_850,vec_res)
  
  vec_res@tiMainString = "vec_700_origin "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,uwnd_700,vwnd_700,vec_res)
  
  
 ;========plot the filter hgt image============
  
  ssfilter1(hgt_850,sshgt_850,s,resthgt_850)
  hgt_res@tiMainString = "hgt_850_filter(1D, 3 points) "+TIME
  plot = gsn_csm_contour_map(wks,sshgt_850,hgt_res)
  
  ssfilter2(hgt_850,sshgt_850,s,resthgt_850)
  hgt_res@tiMainString = "hgt_850_filter(2D, 9 points) "+TIME
  plot = gsn_csm_contour_map(wks,sshgt_850,hgt_res)
  
  ssfilter1(hgt_700,sshgt_700,s,resthgt_700)
  hgt_res@tiMainString = "hgt_700_filter(1D, 3 points) "+TIME
  plot = gsn_csm_contour_map(wks,sshgt_700,hgt_res)
  
  ssfilter2(hgt_700,sshgt_700,s,resthgt_700)
  hgt_res@tiMainString = "hgt_700_filter(2D, 9 points) "+TIME
  plot = gsn_csm_contour_map(wks,sshgt_700,hgt_res)


 ;========plot the filter&rest vector and streamline  image============
  
  ssfilter1(uwnd_850,ssuwnd_850,s,restuwnd_850)
  ssfilter1(vwnd_850,ssvwnd_850,s,restvwnd_850)
  
  str_res@tiMainString = "str_850_filter(1D, 3 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,ssuwnd_850,ssvwnd_850,str_res)
  
  str_res@tiMainString = "str_850_rest(1D, 3 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,restuwnd_850,restvwnd_850,str_res)
  
  vec_res@tiMainString = "vec_850_filter(1D, 3 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,uwnd_850,vwnd_850,vec_res)
  
  vec_res@tiMainString = "vec_850_rest(1D, 3 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,restuwnd_850,restvwnd_850,vec_res)
  
  ssfilter2(uwnd_850,ssuwnd_850,s,restuwnd_850)
  ssfilter2(vwnd_850,ssvwnd_850,s,restvwnd_850)
  
  str_res@tiMainString = "str_850_filter(2D, 9 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,ssuwnd_850,ssvwnd_850,str_res)
  
  str_res@tiMainString = "str_850_rest(2D, 9 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,restuwnd_850,restvwnd_850,str_res)
  
  vec_res@tiMainString = "vec_850_filter(2D, 9 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,uwnd_850,vwnd_850,vec_res)
  
  vec_res@tiMainString = "vec_850_rest(2D, 9 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,restuwnd_850,restvwnd_850,vec_res)
  
  ssfilter1(uwnd_700,ssuwnd_700,s,restuwnd_700)
  ssfilter1(vwnd_700,ssvwnd_700,s,restvwnd_700)
  
  str_res@tiMainString = "str_700_filter(1D, 3 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,ssuwnd_700,ssvwnd_700,str_res)
  
  str_res@tiMainString = "str_700_rest(1D, 3 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,restuwnd_700,restvwnd_700,str_res)
  
  vec_res@tiMainString = "vec_700_filter(1D, 3 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,uwnd_700,vwnd_700,vec_res)
  
  vec_res@tiMainString = "vec_700_rest(1D, 3 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,restuwnd_700,restvwnd_700,vec_res)
  
  ssfilter2(uwnd_700,ssuwnd_700,s,restuwnd_700)
  ssfilter2(vwnd_700,ssvwnd_700,s,restvwnd_700)
  
  str_res@tiMainString = "str_700_filter(2D, 9 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,ssuwnd_700,ssvwnd_700,str_res)
  
  str_res@tiMainString = "str_700_rest(2D, 9 points) "+TIME
  str_res@gsnLeftString = "Streamline"
  plot = gsn_csm_streamline_map(wks,restuwnd_700,restvwnd_700,str_res)
  
  vec_res@tiMainString = "vec_700_filter(2D, 9 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,uwnd_700,vwnd_700,vec_res)
  
  vec_res@tiMainString = "vec_700_rest(2D, 9 points) "+TIME
  vec_res@gsnLeftString = "Wind Vector"
  plot = gsn_csm_vector_map(wks,restuwnd_700,restvwnd_700,vec_res)

end do