load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

root = "/home/qqf/Data/NCEP1-DAILY/monthlymean/"

uinfile = addfile(root+"vwnd.mon.mean.nc", "r")

vinfile = addfile(root+"omega.mon.mean.nc", "r")

tinfile = addfile(root+"air.mon.mean.nc", "r")

udata = uinfile->vwnd
vdata = vinfile->omega
tdata = tinfile->air

lev = uinfile->level
lat = uinfile->lat
lon = uinfile->lon

t_201805 = tdata(:,0:11,:,:) + 273.15
copy_VarMeta(tdata(:,0:11,:,:), t_201805)
t_201805@units = "degK"

level = conform(t_201805, lev(0:11), 1)
level = level * 100
level@units = "Pa"

v_201805 = -omega_to_w(vdata, level, t_201805)
copy_VarMeta(vdata, v_201805)
delete(v_201805@units)
v_201805@units = "m/s"

out=addfile("w.mon.mean.nc", "c")
out->w = v_201805
out->level = lev(0:11)
out->lat = lat
out->lon = lon
