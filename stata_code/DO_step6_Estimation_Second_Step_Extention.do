/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** LOAD Dataset
use "dta_dataset_for_estimation/DTA_dataset_step5.dta", clear


** +++++++++++++++++++++++++++++++++++++++++++++++
** Estimation (OLS)
** Second Step
** Extention
** [Variables]
** Population Density
** Average Years of Education
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mSecondSpdensCoef = J(3, 3, .)
matrix mSecondSpdensSE = J(3, 3, .)
matrix mSecondSpdensStat = J(3, 3, .)

** Second Step Regression
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnspdens10km seducyear10km i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondSpdensCoef[1, `k'] = _b[lnspdens10km]
		matrix mSecondSpdensCoef[2, `k'] = _b[seducyear10km]
		** 
		matrix mSecondSpdensSE[1, `k'] = _se[lnspdens10km]
		matrix mSecondSpdensSE[2, `k'] = _se[seducyear10km]
		** 
		matrix mSecondSpdensStat[1, `k'] = e(N)
		matrix mSecondSpdensStat[2, `k'] = e(r2_a)
	}
		
	** 
	matrix mSecond = J(4, 3, .)
	forvalues i = 1(1)2 {
		local idx_odd = 2 * `i' - 1 
		local idx_even = 2 * `i'
		matrix mSecond[`idx_odd', 1] = mSecondSpdensCoef[`i', 1...]
		matrix mSecond[`idx_even', 1] = mSecondSpdensSE[`i', 1...]
	}

	**
	matrix mSecondSpdensTable = mSecond \ mSecondSpdensStat
	matrix list mSecondSpdensTable

	** Export
	putexcel set "table/tab_02_result_second_step_extention_spdens_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondSpdensTable), names
	putexcel close
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** Estimation (OLS)
** Second Step
** Extention
** [Variables]
** Population Density
** Average Years of Education
** Housing with HEA
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mSecondSpdensCoef = J(3, 3, .)
matrix mSecondSpdensSE = J(3, 3, .)
matrix mSecondSpdensStat = J(3, 3, .)

** Second Step Regression
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnspdens10km seducyear10km lnsbienes10km i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondSpdensCoef[1, `k'] = _b[lnspdens10km]
		matrix mSecondSpdensCoef[2, `k'] = _b[seducyear10km]
		matrix mSecondSpdensCoef[3, `k'] = _b[lnsbienes10km]
		** 
		matrix mSecondSpdensSE[1, `k'] = _se[lnspdens10km]
		matrix mSecondSpdensSE[2, `k'] = _se[seducyear10km]
		matrix mSecondSpdensSE[3, `k'] = _se[lnsbienes10km]
		** 
		matrix mSecondSpdensStat[1, `k'] = e(N)
		matrix mSecondSpdensStat[2, `k'] = e(r2_a)
	}
		
	** 
	matrix mSecond = J(6, 3, .)
	forvalues i = 1(1)3 {
		local idx_odd = 2 * `i' - 1 
		local idx_even = 2 * `i'
		matrix mSecond[`idx_odd', 1] = mSecondSpdensCoef[`i', 1...]
		matrix mSecond[`idx_even', 1] = mSecondSpdensSE[`i', 1...]
	}

	**
	matrix mSecondSpdensTable = mSecond \ mSecondSpdensStat
	matrix list mSecondSpdensTable

	** Export
	putexcel set "table/tab_02_result_second_step_extention_omitted_spdens_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondSpdensTable), names
	putexcel close
}


** +++++++++++++++++++++++++++++++++++++++++++++++
** APPENDIX
** Estimation (OLS)
** Second Step
** Extention
** [Variables]
** Population Potential
** Average Years of Education
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mSecondPPCoef = J(3, 3, .)
matrix mSecondPPSE = J(3, 3, .)
matrix mSecondPPStat = J(3, 3, .)

** Second Step Regression
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnpp_d2 seducyear10km i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondPPCoef[1, `k'] = _b[lnpp_d2]
		matrix mSecondPPCoef[2, `k'] = _b[seducyear10km]
		** 
		matrix mSecondPPSE[1, `k'] = _se[lnpp_d2]
		matrix mSecondPPSE[2, `k'] = _se[seducyear10km]
		** 
		matrix mSecondPPStat[1, `k'] = e(N)
		matrix mSecondPPStat[2, `k'] = e(r2_a)
	}
		
	** 
	matrix mSecond = J(4, 3, .)
	forvalues i = 1(1)2 {
		local idx_odd = 2 * `i' - 1 
		local idx_even = 2 * `i'
		matrix mSecond[`idx_odd', 1] = mSecondPPCoef[`i', 1...]
		matrix mSecond[`idx_even', 1] = mSecondPPSE[`i', 1...]
	}

	**
	matrix mSecondPPTable = mSecond \ mSecondPPStat
	matrix list mSecondPPTable

	** Export
	putexcel set "table/tab_02_result_second_step_extention_pp_d2_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondPPTable), names
	putexcel close
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** APPENDIX
** Estimation (OLS)
** Second Step
** Extention
** [Variables]
** Population Potential
** Average Years of Education
** Housing with HEA
** +++++++++++++++++++++++++++++++++++++++++++++++

** Second Step Regression
foreach G in "total" "univ" "hschl" {
	disp "##############################"
	disp "###### TYPE = `G'"
	disp "##############################"
	** 
	forvalues k = 1(1)3 {
		** REGRESSION
		reg muni_fe`k'_`G' lnpp_d2 seducyear10km lnsbienes10km i.state_code [aw=p15ymas], cl(state_code)
		** 
		matrix mSecondPPCoef[1, `k'] = _b[lnpp_d2]
		matrix mSecondPPCoef[2, `k'] = _b[seducyear10km]
		matrix mSecondPPCoef[3, `k'] = _b[lnsbienes10km]
		** 
		matrix mSecondPPSE[1, `k'] = _se[lnpp_d2]
		matrix mSecondPPSE[2, `k'] = _se[seducyear10km]
		matrix mSecondPPSE[3, `k'] = _se[lnsbienes10km]
		** 
		matrix mSecondPPStat[1, `k'] = e(N)
		matrix mSecondPPStat[2, `k'] = e(r2_a)
	}
		
	** 
	matrix mSecond = J(6, 3, .)
	forvalues i = 1(1)3 {
		local idx_odd = 2 * `i' - 1 
		local idx_even = 2 * `i'
		matrix mSecond[`idx_odd', 1] = mSecondPPCoef[`i', 1...]
		matrix mSecond[`idx_even', 1] = mSecondPPSE[`i', 1...]
	}

	**
	matrix mSecondPPTable = mSecond \ mSecondPPStat
	matrix list mSecondPPTable

	** Export
	putexcel set "table/tab_02_result_second_step_extention_omitted_pp_d2_`G'.xlsx", replace
	putexcel B2 = matrix(mSecondPPTable), names
	putexcel close
}


** +++++++++++++++++++++++++++++++++++++++++++++++
** SAVE
** +++++++++++++++++++++++++++++++++++++++++++++++

**
save "dta_dataset_for_estimation/DTA_dataset_step6.dta", replace


