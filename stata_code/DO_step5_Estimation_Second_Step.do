/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** LOAD Dataset
use "dta_dataset_for_estimation/DTA_dataset_step4.dta", clear


** +++++++++++++++++++++++++++++++++++++++++++++++
** Descriptive Statistics
** Second Step
** +++++++++++++++++++++++++++++++++++++++++++++++

** Dataset of Municipal Unit
duplicates drop muni_code, force
count

** Keep Variables
keep state_code muni_code muni_fe* p15ymas num_workers area seducyear* spdens* lnspdens* pp* lnpp*

** Merge
merge 1:1 muni_code using "dta_dataset_for_estimation/DTA_dataset_step1.dta"
drop _merge


** +++++++++++++++++++++++++++++++++++++++++++++++
** Dummy: Percentile
** 
** +++++++++++++++++++++++++++++++++++++++++++++++

** Average Years of Schooling
forvalues i = 10(10)30 {
	sum seducyear`i'km if muni_fe1_total != ., detail
	scalar p25_seducyear`i'km = r(p25) 
	scalar p50_seducyear`i'km = r(p50) 
	scalar p75_seducyear`i'km = r(p75) 
	** 
	gen dmy_seducyear`i'km_p50 = (seducyear`i'km > p50_seducyear`i'km)
	** 
	gen dmy_seducyear`i'km_p75 = (seducyear`i'km > p75_seducyear`i'km)
}

** Population Density
forvalues i = 10(10)30 {
	sum spdens`i'km if muni_fe1_total != ., detail
	scalar p25_spdens`i'km = r(p25) 
	scalar p50_spdens`i'km = r(p50) 
	scalar p75_spdens`i'km = r(p75) 
	** 
	gen dmy_spdens`i'km_p50 = (spdens`i'km > p50_spdens`i'km)
	** 
	gen dmy_spdens`i'km_p75 = (spdens`i'km > p75_spdens`i'km)
}

** Housing with HEA
forvalues i = 10(10)30 {
	sum sbienes`i'km if muni_fe1_total != ., detail
	scalar p25_sbienes`i'km = r(p25) 
	scalar p50_sbienes`i'km = r(p50) 
	scalar p75_sbienes`i'km = r(p75) 
	** 
	gen dmy_sbienes`i'km_p50 = (sbienes`i'km > p50_sbienes`i'km)
	** 
	gen dmy_sbienes`i'km_p75 = (sbienes`i'km > p75_sbienes`i'km)
}

** Population Potential
forvalues i = 1(1)3 {
	sum pp_d`i' if muni_fe1_total != ., detail
	scalar p25_pp_d`i' = r(p25) 
	scalar p50_pp_d`i' = r(p50) 
	scalar p75_pp_d`i' = r(p75) 
	** 
	gen dmy_pp_d`i'_p50 = (pp_d`i' > p50_pp_d`i')
	** 
	gen dmy_pp_d`i'_p75 = (pp_d`i' > p75_pp_d`i')
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** Descriptive Statistics
** 
** +++++++++++++++++++++++++++++++++++++++++++++++

** Summary for Exporting
tabstat ///
	muni_fe*_total  ///
	muni_fe*_univ  ///
	muni_fe*_hschl  ///
	seducyear10km ///
	seducyear20km ///
	seducyear30km ///
	lnspdens10km ///
	lnspdens20km ///
	lnspdens30km ///
	lnpp_d1 ///
	lnpp_d2 ///
	lnpp_d3 ///
	lnsbienes10km ///
	lnsbienes20km ///
	lnsbienes30km ///
	if muni_fe3_total != . & seducyear10km != . ///
	, ///
	c(stat) ///
	stat(n mean sd min p10 p25 p50 p75 p90 max) ///
	save
	
** Table
mat Stat = r(StatTotal)'
mat list Stat

** Export
putexcel set "table/tab_descriptive_statistics_second_step.xlsx", replace
putexcel B2 = matrix(Stat), names
putexcel close


** +++++++++++++++++++++++++++++++++++++++++++++++
** Estimation (OLS)
** Second Step
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mSecondEducCoef = J(1, 3, .)
matrix mSecondEducSE = J(1, 3, .)
matrix mSecondEducStat = J(3, 3, .)

** Single Variable: Average Years of Education
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' seducyear10km i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondEducCoef[1, `k'] = _b[seducyear10km]
		** 
		matrix mSecondEducSE[1, `k'] = _se[seducyear10km]
		** 
		matrix mSecondEducStat[1, `k'] = e(N)
		matrix mSecondEducStat[2, `k'] = e(r2_a)
	}

	**
	matrix mSecondEducTable = mSecondEducCoef \ mSecondEducSE \ mSecondEducStat
	matrix list mSecondEducTable

	** Export
	putexcel set "table/tab_02_result_second_step_seducyear_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondEducTable), names
	putexcel close
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** Estimation (OLS)
** Second Step
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mSecondSpdensCoef = J(1, 3, .)
matrix mSecondSpdensSE = J(1, 3, .)
matrix mSecondSpdensStat = J(3, 3, .)

** Single Variable: Population Density
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnspdens10km i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondSpdensCoef[1, `k'] = _b[lnspdens10km]
		** 
		matrix mSecondSpdensSE[1, `k'] = _se[lnspdens10km]
		** 
		matrix mSecondSpdensStat[1, `k'] = e(N)
		matrix mSecondSpdensStat[2, `k'] = e(r2_a)
	}

	**
	matrix mSecondSpdensTable = mSecondSpdensCoef \ mSecondSpdensSE \ mSecondSpdensStat
	matrix list mSecondSpdensTable

	** Export
	putexcel set "table/tab_02_result_second_step_spdens_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondSpdensTable), names
	putexcel close
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** APPENDIX
** Estimation (OLS)
** Second Step
** Population Potential 
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mSecondPP1Coef = J(1, 3, .)
matrix mSecondPP1SE = J(1, 3, .)
matrix mSecondPP1Stat = J(3, 3, .)
**
matrix mSecondPP2Coef = J(1, 3, .)
matrix mSecondPP2SE = J(1, 3, .)
matrix mSecondPP2Stat = J(3, 3, .)
**
matrix mSecondPP3Coef = J(1, 3, .)
matrix mSecondPP3SE = J(1, 3, .)
matrix mSecondPP3Stat = J(3, 3, .)


** Single Variable: Population Potential Delta=1
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnpp_d1 i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondPP1Coef[1, `k'] = _b[lnpp_d1]
		** 
		matrix mSecondPP1SE[1, `k'] = _se[lnpp_d1]
		** 
		matrix mSecondPP1Stat[1, `k'] = e(N)
		matrix mSecondPP1Stat[2, `k'] = e(r2_a)
	}

	**
	matrix mSecondPP1Table = mSecondPP1Coef \ mSecondPP1SE \ mSecondPP1Stat
	matrix list mSecondPP1Table

	** Export
	putexcel set "table/tab_02_result_second_step_pp_d1_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondPP1Table), names
	putexcel close
}


** Single Variable: Population Potential Delta=2
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnpp_d2 i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondPP2Coef[1, `k'] = _b[lnpp_d2]
		** 
		matrix mSecondPP2SE[1, `k'] = _se[lnpp_d2]
		** 
		matrix mSecondPP2Stat[1, `k'] = e(N)
		matrix mSecondPP2Stat[2, `k'] = e(r2_a)
	}
	**
	matrix mSecondPP2Table = mSecondPP2Coef \ mSecondPP2SE \ mSecondPP2Stat
	matrix list mSecondPP2Table

	** Export
	putexcel set "table/tab_02_result_second_step_pp_d2_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondPP2Table), names
	putexcel close
}

** Single Variable: Population Potential Delta=3
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnpp_d3 i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondPP3Coef[1, `k'] = _b[lnpp_d3]
		** 
		matrix mSecondPP3SE[1, `k'] = _se[lnpp_d3]
		** 
		matrix mSecondPP3Stat[1, `k'] = e(N)
		matrix mSecondPP3Stat[2, `k'] = e(r2_a)
	}
	**
	matrix mSecondPP3Table = mSecondPP3Coef \ mSecondPP3SE \ mSecondPP3Stat
	matrix list mSecondPP3Table

	** Export
	putexcel set "table/tab_02_result_second_step_pp_d3_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondPP3Table), names
	putexcel close
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** SAVE
** +++++++++++++++++++++++++++++++++++++++++++++++

**
save "dta_dataset_for_estimation/DTA_dataset_step5.dta", replace


