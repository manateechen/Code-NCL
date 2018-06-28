;;;;;;;;;;;;;;;;;;;;;;;
;用于画160站降水分布图;
;;;;;;;;;;;;;;;;;;;;;;;


load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

filepath="G:/0101.txt"                    
data=asciiread(filepath,(/160,3/),"float");NCL可以读取txt
lon=data(:,1)                             ;经度
lat=data(:,0)                             ;纬度
pre=data(:,2)                             ;降水资料



;;;;;;;;;;;;;;;;;;;;;;;;插值;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;设置插值的格点，每一个经纬度取一个格点
ilon = new(66,"float");
ilat = new(40,"float");
dat = new((/40,66/),"float")


;具体设置经纬度
do i=0,65
  ilon(i) =72+i
end do

do l=0,39
  ilat(l) = 17+l
end do


;为插值的格点设置属性，由于画这种图需使用命令gsn_csm_contour_map
;按照gsn_csm_contour_map对应要求设置属性
ilon!0 = "lon"
ilon@long_name = "lon"
ilon@units = "degrees-east"
ilon&lon = ilon

ilat!0 = "lat"
ilat@long_name = "lat"
ilat@units = "degrees_north"
ilat&lat = ilat

pre@_FillValue = 999999.000000            ;设置缺测值

rscan = (/10,5,3/)                        ;设置Cressman插值的扫描半径，最大为10

dat = obj_anal_ic_deprecated(lon,lat,pre,ilon,ilat,rscan, False);进行插值（Cressman, Barnes）




;;;;;;;;;;;;;;;;;;;;;;;;作图;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


wks=gsn_open_wks("x11","Precipitation")        ;建立工作站             

res=True

;设置数据的经纬度范围
res@sfXArray=ilon
res@sfYArray=ilat

;图像最大显示
res@gsnMaximize=True

;限制地图的显示范围
res@mpLimitMode="LatLon"
res@mpMinLatF = 17
res@mpMaxLatF = 55
res@mpMinLonF = 72
res@mpMaxLonF = 136

;选取合适的地图
res@mpDataSetName = "Earth..4"
res@mpDataBaseVersion = "MediumRes"
res@gsnAddCyclic = False        ;这样在0度经线会标出，因为它与180度经线相重合

;将颜色填充限制在要求范围内
res@mpOutlineOn = True
res@mpOutlineSpecifiers = (/"China:states","Taiwan"/)     ;突出地区的边界
res@mpMaskAreaSpecifiers = (/"China:states","Taiwan"/)    ;将地区内部隐藏，仅留下边缘线
res@mpPerimOn   = True                                    ;整张图加边框
res@mpGridMaskMode  = "MaskLand"                          ;在陆地上隐藏经纬线
res@mpOceanFillColor = 0                                  ;海洋水为白色
res@mpInlandWaterFillColor = 0                            ;内陆水为白色

;设置等值线属性
res@cnFillOn = True                               
res@cnFillDrawOrder = "PreDraw"                           ;等值线最先画出，在图像最下层
                                                          ;通过之前“挖空”的地方显示出来
                                                          ;这样可以使颜色只充满要求的范围 
res@cnLineLabelsOn = False                                ;等值线的数值不显示
res@cnLinesOn = False                                     ;等值线隐藏

;一些标注
res@tiMainString="Precipitation in January(mm)"


plot=gsn_csm_contour_map(wks,dat,res)

end
