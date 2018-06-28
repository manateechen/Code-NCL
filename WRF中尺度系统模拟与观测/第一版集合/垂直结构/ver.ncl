load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

opts=True
opts@extrapolate=False
opts@field_type="ght"

wrffile=addfile("./wrfout/wrfout_d03_2014-05-22_06:00:00","r")

ss=fspan(0.1,18.0,20)
tt=fspan(0.1,18.0,22)
z=tt
;z(0:19)=ss
;z(20:)=(/4.0,6.0/)
z@units="km"
xxx=fspan(112.7,113.4,100)
dxxx=0.7
yyy=fspan(23.8,23.3,100)
dyyy=-0.5

print("aaaa")

lattmp = wrf_user_getvar(wrffile,"XLAT",0)
lontmp = wrf_user_getvar(wrffile,"XLONG",0)

tmp00= wrf_user_getvar(wrffile,"dbz",-1)
tmp=wrf_user_vert_interp(wrffile,tmp00,"ght_agl",z,opts)
dbz=rcm2points_Wrap(lattmp,lontmp,tmp,yyy,xxx,2)
dbz!1="level"
dbz!2="points"

tmp00= wrf_user_getvar(wrffile,"theta",-1)
tmp=wrf_user_vert_interp(wrffile,tmp00,"ght_agl",z,opts)
TT=rcm2points_Wrap(lattmp,lontmp,tmp,yyy,xxx,2)
TT!1="level"
TT!2="points"

utmp00= wrf_user_getvar(wrffile,"ua",-1)
utmp=wrf_user_vert_interp(wrffile,utmp00,"ght_agl",z,opts)
u=rcm2points_Wrap(lattmp,lontmp,utmp,yyy,xxx,2)
u!1="level"
u!2="points"

vtmp00= wrf_user_getvar(wrffile,"va",-1)
vtmp=wrf_user_vert_interp(wrffile,vtmp00,"ght_agl",z,opts)
v=rcm2points_Wrap(lattmp,lontmp,vtmp,yyy,xxx,2)
v!1="level"
v!2="points"

print("bbb")

;theta=(u*-sqrt(2.0)+v*sqrt(2.0))/2.0/(sqrt(u*u+v*v))
;theta=(u*dxxx+v*dyyy)*sqrt(349)/10.0/(sqrt(u*u+v*v))
;uu=sqrt(u*u+v*v)*theta
uu=(u*dxxx+v*dyyy)/sqrt(dxxx*dxxx+dyyy*dyyy)
uu!1="level"
uu!2="points"

wtmp00= wrf_user_getvar(wrffile,"wa",-1)
wtmp=wrf_user_vert_interp(wrffile,wtmp00,"ght_agl",z,opts)
w=rcm2points_Wrap(lattmp,lontmp,wtmp,yyy,xxx,2)
w!1="level"
w!2="points"

dbz&level=z
uu&level=z
w&level=z 
delete(dbz&points)
delete(w&points)
dbz&points=fspan(0.0,95.0,100)
uu&points=fspan(0.0,95.0,100)
w&points=fspan(0.0,95.0,100)
printVarSummary(w)

res                 = True
res@cnFillOn        = True ;False ;True
res@cnLinesOn       = False  ;False
res@cnLineLabelsOn  = False  ;False
res@cnInfoLabelOn   = False  ;False
res@gsnSpreadColors = True
res@vpWidthF=0.60
res@vpHeightF=0.35
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(5,55,5)   ;ispan(-6,6,2)
res@gsnDraw         = False
res@gsnFrame        = False
res@gsnMaximize=True
res@gsnLeftString=""
res@gsnRightString=""
res@lbLabelBarOn=False
res@tiXAxisString=""
res@tmXBLabelsOn =True


resTT=True
resTT@cnLineLabelsOn  = True
resTT@cnLineLabelsOn  = True
resTT@cnInfoLabelOn   = False
resTT@cnLineThicknessF =5.0
resTT@cnLineColor="blue"
resTT@gsnDraw         = False
resTT@gsnFrame        = False
resTT@gsnLeftString=""
resTT@gsnRightString=""


vcres=True
vcres@gsnDraw         = False
vcres@gsnFrame        = False
vcres@tfDoNDCOverlay=True
vcres@vcFillArrowsOn=False
vcres@vcRefLengthF=0.02
vcres@vcGlyphStyle="CurlyVector"
vcres@vcMinDistanceF=0.02
vcres@vcLineArrowThicknessF=1
vcres@vcRefAnnoOrthogonalPosF=0.001
vcres@vcRefAnnoOn=False
vcres@gsnMaximize=True
vcres@vcMapDirection = False
vcres@vcRefAnnoOn               = True
vcres@vcRefMagnitudeF           = 20
vcres@vcRefAnnoString1          = "20 m/s"
vcres@vcRefAnnoSide             = "Top"
vcres@vcRefAnnoString2On        = False
vcres@vcRefAnnoPerimOn          = False
vcres@vcRefAnnoOrthogonalPosF   = -0.15
vcres@vcRefAnnoParallelPosF     = 0.999
vcres@vcRefAnnoBackgroundColor  = "White"
printVarSummary(dbz)

wks = gsn_open_wks("eps", "vertical")
;gsn_define_colormap(wks,"BlueWhiteOrangeRed")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_csm_contour(wks,dbz(0,:,:) , res)
plottt=gsn_csm_contour(wks,TT(0,:,:) , resTT)
overlay(plot,plottt)
plot1=gsn_csm_vector(wks,uu(0,:,:),w(0,:,:),vcres)
overlay(plot,plot1)
draw(plot)

