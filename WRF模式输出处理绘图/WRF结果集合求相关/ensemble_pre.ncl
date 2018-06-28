load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

setfileoption("nc","Format","LargeFile")
out01=addfile("all_pre_01.nc","c")
out02=addfile("all_pre_02.nc","c")

  wrff1=addfile("./case01/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case01/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  
  out01->c0101=var1
  out02->c0102=var2
    print("1")
    
  wrff1=addfile("./case02/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case02/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  
  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)


  out01->c0201=var1
  out02->c0202=var2
        print("2")
    
  wrff1=addfile("./case03/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case03/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  
  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c0301=var1
  out02->c0302=var2
        print("3")
  wrff1=addfile("./case04/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case04/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  tmp=rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  
  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  tmp2=rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c0401=var1
  out02->c0402=var2
        print("4")
  wrff1=addfile("./case05/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case05/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)
  
  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c0501=var1
  out02->c0502=var2
        print("5")
    
    
  wrff1=addfile("./case06/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case06/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  tmp=rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  tmp2=rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c0601=var1
  out02->c0602=var2
        print("6")
    
  wrff1=addfile("./case07/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case07/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)


  out01->c0701=var1
  out02->c0702=var2
        print("7")
  wrff1=addfile("./case08/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case08/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  tmp=rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  tmp2=rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c0801=var1
  out02->c0802=var2
    
        print("8")
  wrff1=addfile("./case09/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case09/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c0901=var1
  out02->c0902=var2
        print("9")
    
  wrff1=addfile("./case10/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case10/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c1001=var1
  out02->c1002=var2
        print("10")
    
  wrff1=addfile("./case11/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case11/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c1101=var1
  out02->c1102=var2
        print("11")
    
  wrff1=addfile("./case13/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case13/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c1301=var1
  out02->c1302=var2
        print("13")
    
  wrff1=addfile("./case14/wrfout_d01_1998-06-16_00:00:00","r")
  wrff2=addfile("./case14/wrfout_d02_1998-06-16_00:00:00","r")

  rainnc1 = wrf_user_getvar(wrff1,"RAINNC",-1)
  irainnc1 = wrf_user_getvar(wrff1,"I_RAINNC",-1)
  rainc1 = wrf_user_getvar(wrff1,"RAINC",-1)
  irainc1 = wrf_user_getvar(wrff1,"I_RAINC",-1)
  tmp=(irainnc1+irainc1)*100.0+rainnc1+rainc1
  var1=tmp(28,:,:)-tmp(0,:,:)
  copy_VarMeta(rainnc1(0,:,:),var1)

  rainnc2 = wrf_user_getvar(wrff2,"RAINNC",-1)
  irainnc2 = wrf_user_getvar(wrff2,"I_RAINNC",-1)
  rainc2 = wrf_user_getvar(wrff2,"RAINC",-1)
  irainc2 = wrf_user_getvar(wrff2,"I_RAINC",-1)
  tmp2=(irainnc2+irainc2)*100.0+rainnc2+rainc2
  var2=tmp2(28,:,:)-tmp2(0,:,:)
  copy_VarMeta(rainnc2(0,:,:),var2)

  out01->c1401=var1
  out02->c1402=var2
        print("14")