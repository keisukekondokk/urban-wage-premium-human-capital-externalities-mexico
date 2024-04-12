/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** +++++++++++++++++++++++++++++++++++++++++++++++
** Encuesta Nacional de Ocupación y Empleo (ENOE), población de 15 años y más de edad
** +++++++++++++++++++++++++++++++++++++++++++++++
**

forvalues year = 2006(1)2006 {
	forvalues q = 1(1)1 {
		**
		local url = "https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/microdatos/"
		local savepath = "dta_enoe_download/"
		local filename = "`year'trim`q'_dta.zip"
		copy "`url'`filename'" "`savepath'`filename'", replace


		cd "dta_enoe_estimation"
		unzipfile "../`savepath'`filename'", replace
		cd ..
	}
}
