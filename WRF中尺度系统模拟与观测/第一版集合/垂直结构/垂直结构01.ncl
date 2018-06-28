load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

opts=True
opts@extrapolate=False
opts@field_type="ght"

wrffile=addfile("wrfout_d03_2014-05-21_22:40:00","r")

z=fspan(0,15,60)
z@units="km"
xxx=fspan(112.1,110.3,2000)
yyy=fspan(24.0,24.5,2000)

lattmp = wrf_user_getvar(wrffile,"XLAT",0)
lontmp = wrf_user_getvar(wrffile,"XLONG",0)

tmp00= wrf_user_getvar(wrffile,"dbz",-1)
tmp=wrf_user_vert_interp(wrffile,tmp00,"ght_agl",z,opts)
dbz=rcm2points_Wrap(lattmp,lontmp,tmp,yyy,xxx,2)
dbz!1="level"
dbz!2="points"

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

;theta=(u*-sqrt(2.0)+v*sqrt(2.0))/2.0/(sqrt(u*u+v*v))
theta=(u*-1.8+v*0.5)*sqrt(349)/10.0/(sqrt(u*u+v*v))
uu=sqrt(u*u+v*v)*theta
uu!1="level"
uu!2="points"

wtmp00= wrf_user_getvar(wrffile,"wa",-1)
wtmp=wrf_user_vert_interp(wrffile,wtmp00,"ght_agl",z,opts)
w=rcm2points_Wrap(lattmp,lontmp,wtmp,yyy,xxx,2)
w!1="level"
w!2="points"

dbz&level=z ;(::-1)
uu&level=z ;(::-1)
w&level=z ;(::-1)

printVarSummary(w)

res                 = True
res@cnFillOn        = True
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@gsnSpreadColors = True
res@vpWidthF=0.60
res@vpHeightF=0.35
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(5,55,5)
res@gsnDraw         = False
res@gsnFrame        = False
res@gsnMaximize=True

vcres=True
vcres@gsnDraw         = False
vcres@gsnFrame        = False
vcres@tfDoNDCOverlay=True
vcres@vcFillArrowsOn=False
vcres@vcRefLengthF=0.07
vcres@vcGlyphStyle="CurlyVector"
vcres@vcMinDistanceF=0.01
vcres@vcLineArrowThicknessF=1
vcres@vcRefAnnoOrthogonalPosF=0.001
vcres@vcRefAnnoOn=False
vcres@gsnMaximize=True

printVarSummary(dbz)

wks = gsn_open_wks("eps", "vertical")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot = gsn_contour(wks,dbz(0,:,::-1) , res)
plot1=gsn_vector(wks,-uu(0,:,::-1),w(0,:,::-1),vcres)
overlay(plot,plot1)
draw(plot)
