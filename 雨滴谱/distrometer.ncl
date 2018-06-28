rain_size=(/0.062,0.187,0.312,0.437,0.562,0.687,0.812,0.937,1.062,1.187,1.375,1.625,1.875,2.125,2.375,2.750,3.250,3.750,4.250,4.750,5.500,6.500,7.500,8.500,9.500,11.000,13.000,15.000,17.000,19.000,21.500,24.500/)

datasum1 = asciiread("bada_all_data_tmp",32,"float")
datasum1@missing_value=999999.000000
datasum1@_FillValue=999999.000000

datasum2 = asciiread("hecheng_all_data_tmp",32,"float")
datasum2@missing_value=999999.000000
datasum2@_FillValue=999999.000000

datasum3 = asciiread("chengcun_all_data_tmp",32,"float")
datasum3@missing_value=999999.000000
datasum3@_FillValue=999999.000000

datasum4 = asciiread("shuangjie_all_data_tmp",32,"float")
datasum4@missing_value=999999.000000
datasum4@_FillValue=999999.000000

datasum=(datasum1+datasum2+datasum3+datasum4)/4.0

print(datasum)

res=True
res@xyYStyle="Log"
res@xyMarkLineModes   = "Markers"
res@gsnMaximize=True
res@vpWidthF=0.45
res@vpHeightF=0.60 


wks = gsn_open_wks ("pdf","xy")   
plot = gsn_csm_xy(wks,rain_size,datasum,res) 
