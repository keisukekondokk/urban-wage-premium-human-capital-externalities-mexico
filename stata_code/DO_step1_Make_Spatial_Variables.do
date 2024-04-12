/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** LOAD Municipal Data 2005
use "dta_dataset_for_estimation/DTA_dataset_2005_step1.dta", clear
gen year = 2005

** APPEND Municipal Data 2010
append using "dta_dataset_for_estimation/DTA_dataset_2010_step1.dta"
replace year = 2010 if year == .

** PANEL STRUCTURE
xtset muni_code year, yearly

** AVERAGE VALUES between 2005 and 2010
collapse (first) _ID _CX _CY ObjName state_name muni_name (mean) p15ymas area grado_escolar pdens lnpdens *10km *20km *30km **pp*, by(muni_code)

** Take Logarithm
gen lnmean_spdens10km = log(spdens10km)
gen mean_lnspdens10km = lnspdens10km

** Take Logarithm
gen lnmean_sbienes10km = log(sbienes10km)
gen mean_lnsbienes10km = lnsbienes10km

** SAVE
save "dta_dataset_for_estimation/DTA_dataset_step1.dta", replace
