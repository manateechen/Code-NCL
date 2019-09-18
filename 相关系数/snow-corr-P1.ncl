load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

nyears = 40


JJA = asciiread("interannual-JJA.txt", nyears, "float")
JAS = asciiread("interannual-JAS.txt", nyears, "float")
ASO = asciiread("interannual-ASO.txt", nyears, "float")
SON = asciiread("interannual-SON.txt", nyears, "float")
OND = asciiread("interannual-OND.txt", nyears, "float")
NDJ = asciiread("interannual-NDJ.txt", nyears-1, "float")
DJF = asciiread("interannual-DJF.txt", nyears-1, "float")


JJA_JAS = escorc(JJA(0:15), JAS(0:15))
JJA_ASO = escorc(JJA(0:15), ASO(0:15))
JJA_SON = escorc(JJA(0:15), SON(0:15))
JJA_OND = escorc(JJA(0:15), OND(0:15))
JJA_NDJ = escorc(JJA(0:14), NDJ(0:14))
JJA_DJF = escorc(JJA(0:14), DJF(0:14))


JAS_ASO = escorc(JAS(0:15), ASO(0:15))
JAS_SON = escorc(JAS(0:15), SON(0:15))
JAS_OND = escorc(JAS(0:15), OND(0:15))
JAS_NDJ = escorc(JAS(0:14), NDJ(0:14))
JAS_DJF = escorc(JAS(0:14), DJF(0:14))


ASO_SON = escorc(ASO(0:15), SON(0:15))
ASO_OND = escorc(ASO(0:15), OND(0:15))
ASO_NDJ = escorc(ASO(0:14), NDJ(0:14))
ASO_DJF = escorc(ASO(0:14), DJF(0:14))


SON_OND = escorc(SON(0:15), OND(0:15))
SON_NDJ = escorc(SON(0:14), NDJ(0:14))
SON_DJF = escorc(SON(0:14), DJF(0:14))


OND_NDJ = escorc(OND(0:14), NDJ(0:14))
OND_DJF = escorc(OND(0:14), DJF(0:14))


NDJ_DJF = escorc(NDJ(0:14), DJF(0:14))

print("JJA_JAS: " + JJA_JAS)
print("JJA_ASO: " + JJA_ASO)
print("JJA_SON: " + JJA_SON)
print("JJA_OND: " + JJA_OND)
print("JJA_NDJ: " + JJA_NDJ)
print("JJA_DJF: " + JJA_DJF)


print("JAS_ASO: " + JAS_ASO)
print("JAS_SON: " + JAS_SON)
print("JAS_OND: " + JAS_OND)
print("JAS_NDJ: " + JAS_NDJ)
print("JAS_DJF: " + JAS_DJF)


print("ASO_SON: " + ASO_SON)
print("ASO_OND: " + ASO_OND)
print("ASO_NDJ: " + ASO_NDJ)
print("ASO_DJF: " + ASO_DJF)


print("SON_OND: " + SON_OND)
print("SON_NDJ: " + SON_NDJ)
print("SON_DJF: " + SON_DJF)


print("OND_NDJ: " + OND_NDJ)
print("OND_DJF: " + OND_DJF)


print("NDJ_DJF: " + NDJ_DJF)