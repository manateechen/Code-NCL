load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

wrfout_d03=addfile("./wrfout_d03_2013-07-06_00:00:00","r")
T2_d03=wrf_user_getvar(wrfout_d03,"T2",-1)

wrfout_d04=addfile("./wrfout_d04_2013-07-06_00:00:00","r")
T2_d04=wrf_user_getvar(wrfout_d04,"T2",-1)

T2_d03_mean=dim_avg_n_Wrap(T2_d03, 0)
T2_d03_min=dim_min_n_Wrap(T2_d03, 0)
T2_d03_max=dim_max_n_Wrap(T2_d03, 0)

T2_d04_mean=dim_avg_n_Wrap(T2_d04, 0)
T2_d04_min=dim_min_n_Wrap(T2_d04, 0)
T2_d04_max=dim_max_n_Wrap(T2_d04, 0)

opt = True
fmtx = "f8.2"

opt@fout = "T2_d03_mean"
write_matrix (T2_d03_mean, fmtx, opt)

opt@fout = "T2_d03_min"
write_matrix (T2_d03_min, fmtx, opt)

opt@fout = "T2_d03_max"
write_matrix (T2_d03_max, fmtx, opt)


opt@fout = "T2_d04_mean"
write_matrix (T2_d04_mean, fmtx, opt)

opt@fout = "T2_d04_min"
write_matrix (T2_d04_min, fmtx, opt)

opt@fout = "T2_d04_max"
write_matrix (T2_d04_max, fmtx, opt)