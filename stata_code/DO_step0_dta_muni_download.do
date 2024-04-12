/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** +++++++++++++++++++++++++++++++++++++++++++++++
** Conteo de Población y Vivienda 2005
** +++++++++++++++++++++++++++++++++++++++++++++++
**
local url = "https://www.inegi.org.mx/contenidos/programas/ccpv/2005/datosabiertos/"
local savepath = "dta_muni_download/"
local filename = "cpv2005_iter_00_csv.zip"
copy "`url'`filename'" "`savepath'`filename'", replace


cd "dta_muni_estimation"
unzipfile "../`savepath'`filename'", replace
cd ..


** +++++++++++++++++++++++++++++++++++++++++++++++
** Censo de Población y Vivienda 2010
** +++++++++++++++++++++++++++++++++++++++++++++++
**
local url = "https://www.inegi.org.mx/contenidos/programas/ccpv/2010/datosabiertos/"
local savepath = "dta_muni_download/"
local filename = "iter_nal_2010_csv.zip"
copy "`url'`filename'" "`savepath'`filename'", replace


cd "dta_muni_estimation"
unzipfile "../`savepath'`filename'", replace
cd ..

