load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

setfileoption("nc","Format","LargeFile")
out01=addfile("all_geo_01.nc","c")
out02=addfile("all_geo_02.nc","c")

  d1=addfile("./case01/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case01/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)
   
  out01->c0101=var1
  out02->c0102=var2
    print("1")
    
  d1=addfile("./case02/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case02/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)


  out01->c0201=var1
  out02->c0202=var2
        print("2")
    
  d1=addfile("./case03/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case03/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c0301=var1
  out02->c0302=var2
        print("3")
        
        
  d1=addfile("./case04/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case04/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c0401=var1
  out02->c0402=var2
        print("4")
        
        
  d1=addfile("./case05/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case05/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c0501=var1
  out02->c0502=var2
        print("5")
    
    
 d1=addfile("./case06/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case06/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c0601=var1
  out02->c0602=var2
        print("6")
    
 d1=addfile("./case07/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case07/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)


  out01->c0701=var1
  out02->c0702=var2
        print("7")
        
  d1=addfile("./case08/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case08/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c0801=var1
  out02->c0802=var2
    
        print("8")
  d1=addfile("./case09/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case09/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c0901=var1
  out02->c0902=var2
        print("9")
    
  d1=addfile("./case10/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case10/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)
  out01->c1001=var1
  out02->c1002=var2
        print("10")
    
  d1=addfile("./case11/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case11/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c1101=var1
  out02->c1102=var2
        print("11")
    
  d1=addfile("./case13/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case13/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)
  out01->c1301=var1
  out02->c1302=var2
        print("13")
    
 d1=addfile("./case14/wrfpress_d01_1998-06-16_00:00:00","r")
  d2=addfile("./case14/wrfpress_d02_1998-06-16_00:00:00","r")

  tmp1 = wrf_user_getvar(d1,"GHT_PL",-1)
  tmp1(:,:,:,:)=tmp1(:,:,:,:)/10.0
  var1=dim_avg_n_Wrap(tmp1,0)
  
  tmp2 = wrf_user_getvar(d2,"GHT_PL",-1)
  tmp2(:,:,:,:)=tmp2(:,:,:,:)/10.0
  var2=dim_avg_n_Wrap(tmp2,0)

  out01->c1401=var1
  out02->c1402=var2
        print("14")