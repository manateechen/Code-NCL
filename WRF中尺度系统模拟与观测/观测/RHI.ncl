load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

nelevation=893
nbin=1000

datafile=asciiread("DBZ_20140522145922",(/nelevation,nbin/),"float")/100.0
levfile=asciiread("lev",(/nelevation/),"float")

xx=new((/nelevation,nbin/),"float")
yy=new((/nelevation,nbin/),"float")
do ii = 0,nelevation-1
    do jj=0,nbin-1
        xx(ii,jj)=(jj+0.5)*150*cos(levfile(ii)/180.0*3.1415926)/1000.0
        yy(ii,jj)=(jj+0.5)*150*sin(levfile(ii)/180.0*3.1415926)/1000.0
    end do
end do

datafile@_FillValue=-32768/100.0  

res=True
res@gsnDraw         = False
res@gsnFrame        = False
res@gsnLeftString = ""
res@gsnRightString = ""
res@gsnMaximize=True
res@cnLinesOn       = False
res@cnLineLabelsOn  = False
res@cnInfoLabelOn   = False
res@cnFillOn=True
res@gsnSpreadColors=True
res@cnLevelSelectionMode = "ExplicitLevels"
res@cnLevels=ispan(5,55,5)
res@vpHeightF=0.3
res@vpWidthF=0.7
res@tiMainString="20140522145922"
res@sfDataArray=datafile
res@sfXArray=xx
res@sfYArray=yy
res@trGridType        = "TriangularMesh"
res@trYMaxF = 15  

wks=gsn_open_wks("pdf","20140522145922")
gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
plot=gsn_csm_contour(wks,datafile,res)    
draw(wks)
