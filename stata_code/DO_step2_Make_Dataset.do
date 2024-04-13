/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** +++++++++++++++++++++++++++++++++++++++++++++++
** Append Data 
** +++++++++++++++++++++++++++++++++++++++++++++++

** 
clear

** 2005 Q1-Q4
forvalues t = 2005(1)2010 {
	forvalues i = 1/4 {
		append using "dta_enoe_estimation/DTA_dataset_`t'q`i'.dta"
	}
}

** 
drop _merge_m1

** State and Municipality Code
gen state_code = ent
gen muni_code = ent*1000 + mun

** Merge Municipal Data with Microdata
merge m:1 muni_code using "dta_dataset_for_estimation/DTA_dataset_2005_step1.dta"
drop _merge

** SAVE
save "dta_dataset_for_estimation/DTA_dataset_step2.dta", replace
