/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** LOAD Dataset
use "dta_dataset_for_estimation/DTA_dataset_step3.dta", clear


** +++++++++++++++++++++++++++++++++++++++++++++++
** Descriptive Statistics
** First Step
** +++++++++++++++++++++++++++++++++++++++++++++++

** Dummy for High- and Low-Skilled Workers
gen dmy_univ_hschl = (educ > 12 & cs_p13_1 > 5)

** Year/Quarterly
encode yq, gen(yq_code)

** Summary for Exporting
tabstat ///
	ing_x_hrs ///
	educ ///
	exper ///
	fexper ///
	dmy_female ///
	dmy_marriage ///
	dmy_firmsize* ///
	dmy_occ* ///
	dmy_sec* ///
	if lnw != . & educ != . & exper != . & firmsize != . ///
	, ///
	c(stat) ///
	stat(n mean sd min p10 p25 p50 p75 p90 max) ///
	save
	
** Table
mat Stat = r(StatTotal)'
mat list Stat

** Export
putexcel set "table/descriptive_statistics/tab_descriptive_statistics_first_step.xlsx", replace
putexcel B2 = matrix(Stat), names
putexcel close


** +++++++++++++++++++++++++++++++++++++++++++++++
** First Step Regression
** Estimation (OLS)
** TOTAL
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mFirstCoef = J(11, 3, .)
matrix mFirstSE = J(11, 3, .)
matrix mFirstStat = J(3, 3, .)
matrix list mFirstCoef


** ----------------------------------------
** CASE 1: WITHOUT Control 
** ----------------------------------------
areg lnw ///
	b1.yq_code ///
	if educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(muni_code)
	
**
matrix mFirstStat[1, 1] = e(N)
matrix mFirstStat[2, 1] = e(k_absorb)
matrix mFirstStat[3, 1] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe1_total, d
by muni_code, sort: egen muniwage_fe1_total = median(muni_fe1_total)

** ----------------------------------------
** CASE 2: WITH Control Individuals
** ----------------------------------------
areg lnw ///
	educ ///
	exper ///
	expersq ///
	dmy_female ///
	dmy_marriage ///
	b1.occ ///
	b1.sec ///
	b1.yq_code ///
	if educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(muni_code)
	
** 
matrix mFirstCoef[1, 2] = _b[educ]
matrix mFirstCoef[2, 2] = _b[exper]
matrix mFirstCoef[3, 2] = _b[expersq]
matrix mFirstCoef[4, 2] = _b[dmy_female]
matrix mFirstCoef[5, 2] = _b[dmy_marriage]
** 
matrix mFirstSE[1, 2] = _se[educ]
matrix mFirstSE[2, 2] = _se[exper]
matrix mFirstSE[3, 2] = _se[expersq]
matrix mFirstSE[4, 2] = _se[dmy_female]
matrix mFirstSE[5, 2] = _se[dmy_marriage]
** 
matrix mFirstStat[1, 2] = e(N)
matrix mFirstStat[2, 2] = e(k_absorb)
matrix mFirstStat[3, 2] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe2_total, d
by muni_code, sort: egen muniwage_fe2_total = median(muni_fe2_total)


** ----------------------------------------
** CASE 3: WITH Control Individuals + Firms
** ----------------------------------------
areg lnw ///
	educ ///
	exper ///
	expersq ///
	dmy_female ///
	dmy_marriage ///
	b1.firmsize ///
	b1.occ ///
	b1.sec ///
	b1.yq_code ///
	if educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(muni_code)
	
** 
matrix mFirstCoef[1, 3] = _b[educ]
matrix mFirstCoef[2, 3] = _b[exper]
matrix mFirstCoef[3, 3] = _b[expersq]
matrix mFirstCoef[4, 3] = _b[dmy_female]
matrix mFirstCoef[5, 3] = _b[dmy_marriage]
matrix mFirstCoef[6, 3] = .
matrix mFirstCoef[7, 3] = .
matrix mFirstCoef[8, 3] = _b[2.firmsize]
matrix mFirstCoef[9, 3] = _b[3.firmsize]
matrix mFirstCoef[10, 3] = _b[4.firmsize]
matrix mFirstCoef[11, 3] = _b[5.firmsize]
** 
matrix mFirstSE[1, 3] = _se[educ]
matrix mFirstSE[2, 3] = _se[exper]
matrix mFirstSE[3, 3] = _se[expersq]
matrix mFirstSE[4, 3] = _se[dmy_female]
matrix mFirstSE[5, 3] = _se[dmy_marriage]
matrix mFirstSE[6, 3] = .
matrix mFirstSE[7, 3] = .
matrix mFirstSE[8, 3] = _se[2.firmsize]
matrix mFirstSE[9, 3] = _se[3.firmsize]
matrix mFirstSE[10, 3] = _se[4.firmsize]
matrix mFirstSE[11, 3] = _se[5.firmsize]
** 
matrix mFirstStat[1, 3] = e(N)
matrix mFirstStat[2, 3] = e(k_absorb)
matrix mFirstStat[3, 3] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe3_total, d
by muni_code, sort: egen muniwage_fe3_total = median(muni_fe3_total)


** 
matrix mFirst = J(22, 3, .)
forvalues i = 1(1)11 {
	local idx_odd = 2 * `i' - 1 
	local idx_even = 2 * `i'
	matrix mFirst[`idx_odd', 1] = mFirstCoef[`i', 1...]
	matrix mFirst[`idx_even', 1] = mFirstSE[`i', 1...]
}

** Table
matrix list mFirst
matrix mFirstTable = mFirst \ mFirstStat
matrix list mFirstTable

	
** Export
putexcel set "table/results_first_step/tab_01_results_first_step_total.xlsx", replace
putexcel B2 = matrix(mFirstTable), names
putexcel close


** +++++++++++++++++++++++++++++++++++++++++++++++
** First Step Regression
** Estimation (OLS)
** UNIV
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mFirstCoef = J(11, 3, .)
matrix mFirstSE = J(11, 3, .)
matrix mFirstStat = J(3, 3, .)
matrix list mFirstCoef


** ----------------------------------------
** WITHOUT Control
** ----------------------------------------
areg lnw ///
	b1.yq_code ///
	if dmy_univ_hschl == 1 & educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(state_code)
	
**
matrix mFirstStat[1, 1] = e(N)
matrix mFirstStat[2, 1] = e(k_absorb)
matrix mFirstStat[3, 1] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe1_univ, d
by muni_code, sort: egen muniwage_fe1_univ = median(muni_fe1_univ)


** ----------------------------------------
** WITH Control Individuals
** ----------------------------------------
areg lnw ///
	educ ///
	exper ///
	expersq ///
	dmy_female ///
	dmy_marriage ///
	b1.occ ///
	b1.sec ///
	b1.yq_code ///
	if dmy_univ_hschl == 1 & educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(state_code)
	
** 
matrix mFirstCoef[1, 2] = _b[educ]
matrix mFirstCoef[2, 2] = _b[exper]
matrix mFirstCoef[3, 2] = _b[expersq]
matrix mFirstCoef[4, 2] = _b[dmy_female]
matrix mFirstCoef[5, 2] = _b[dmy_marriage]
** 
matrix mFirstSE[1, 2] = _se[educ]
matrix mFirstSE[2, 2] = _se[exper]
matrix mFirstSE[3, 2] = _se[expersq]
matrix mFirstSE[4, 2] = _se[dmy_female]
matrix mFirstSE[5, 2] = _se[dmy_marriage]
** 
matrix mFirstStat[1, 2] = e(N)
matrix mFirstStat[2, 2] = e(k_absorb)
matrix mFirstStat[3, 2] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe2_univ, d
by muni_code, sort: egen muniwage_fe2_univ = median(muni_fe2_univ)


** ----------------------------------------
** WITH Control Individuals + Firms
** ----------------------------------------
areg lnw ///
	educ ///
	exper ///
	expersq ///
	dmy_female ///
	dmy_marriage ///
	b1.firmsize ///
	b1.occ ///
	b1.sec ///
	b1.yq_code ///
	if dmy_univ_hschl == 1 & educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(state_code)
	
** 
matrix mFirstCoef[1, 3] = _b[educ]
matrix mFirstCoef[2, 3] = _b[exper]
matrix mFirstCoef[3, 3] = _b[expersq]
matrix mFirstCoef[4, 3] = _b[dmy_female]
matrix mFirstCoef[5, 3] = _b[dmy_marriage]
matrix mFirstCoef[6, 3] = .
matrix mFirstCoef[7, 3] = .
matrix mFirstCoef[8, 3] = _b[2.firmsize]
matrix mFirstCoef[9, 3] = _b[3.firmsize]
matrix mFirstCoef[10, 3] = _b[4.firmsize]
matrix mFirstCoef[11, 3] = _b[5.firmsize]
** 
matrix mFirstSE[1, 3] = _se[educ]
matrix mFirstSE[2, 3] = _se[exper]
matrix mFirstSE[3, 3] = _se[expersq]
matrix mFirstSE[4, 3] = _se[dmy_female]
matrix mFirstSE[5, 3] = _se[dmy_marriage]
matrix mFirstSE[6, 3] = .
matrix mFirstSE[7, 3] = .
matrix mFirstSE[8, 3] = _se[2.firmsize]
matrix mFirstSE[9, 3] = _se[3.firmsize]
matrix mFirstSE[10, 3] = _se[4.firmsize]
matrix mFirstSE[11, 3] = _se[5.firmsize]
** 
matrix mFirstStat[1, 3] = e(N)
matrix mFirstStat[2, 3] = e(k_absorb)
matrix mFirstStat[3, 3] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe3_univ, d
by muni_code, sort: egen muniwage_fe3_univ = median(muni_fe3_univ)



** ----------------------------------------
** EXPORT
** ----------------------------------------

** 
matrix mFirst = J(22, 3, .)
forvalues i = 1(1)11 {
	local idx_odd = 2 * `i' - 1 
	local idx_even = 2 * `i'
	matrix mFirst[`idx_odd', 1] = mFirstCoef[`i', 1...]
	matrix mFirst[`idx_even', 1] = mFirstSE[`i', 1...]
}

** Table
matrix list mFirst
matrix mFirstTable = mFirst \ mFirstStat
matrix list mFirstTable

	
** Export
putexcel set "table/results_first_step/tab_01_results_first_step_univ.xlsx", replace
putexcel B2 = matrix(mFirstTable), names
putexcel close




** +++++++++++++++++++++++++++++++++++++++++++++++
** First Step Regression
** Estimation (OLS)
** HIGH SCHOOL
** +++++++++++++++++++++++++++++++++++++++++++++++

** Matrix to store results
matrix mFirstCoef = J(11, 3, .)
matrix mFirstSE = J(11, 3, .)
matrix mFirstStat = J(3, 3, .)
matrix list mFirstCoef


** ----------------------------------------
** CASE 1: WITHOUT Control
** ----------------------------------------
areg lnw ///
	b1.yq_code ///
	if dmy_univ_hschl == 0 & educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(state_code)
	
**
matrix mFirstStat[1, 1] = e(N)
matrix mFirstStat[2, 1] = e(k_absorb)
matrix mFirstStat[3, 1] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe1_hschl, d
by muni_code, sort: egen muniwage_fe1_hschl = median(muni_fe1_hschl)


** ----------------------------------------
** CASE 2: WITH Control Individuals
** ----------------------------------------
areg lnw ///
	educ ///
	exper ///
	expersq ///
	dmy_female ///
	dmy_marriage ///
	b1.occ ///
	b1.sec ///
	b1.yq_code ///
	if dmy_univ_hschl == 0 & educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(state_code)
	
** 
matrix mFirstCoef[1, 2] = _b[educ]
matrix mFirstCoef[2, 2] = _b[exper]
matrix mFirstCoef[3, 2] = _b[expersq]
matrix mFirstCoef[4, 2] = _b[dmy_female]
matrix mFirstCoef[5, 2] = _b[dmy_marriage]
** 
matrix mFirstSE[1, 2] = _se[educ]
matrix mFirstSE[2, 2] = _se[exper]
matrix mFirstSE[3, 2] = _se[expersq]
matrix mFirstSE[4, 2] = _se[dmy_female]
matrix mFirstSE[5, 2] = _se[dmy_marriage]
** 
matrix mFirstStat[1, 2] = e(N)
matrix mFirstStat[2, 2] = e(k_absorb)
matrix mFirstStat[3, 2] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe2_hschl, d
by muni_code, sort: egen muniwage_fe2_hschl = median(muni_fe2_hschl)



** ----------------------------------------
** CASE 3: WITH Control Individuals + Firms
** ----------------------------------------
areg lnw ///
	educ ///
	exper ///
	expersq ///
	dmy_female ///
	dmy_marriage ///
	b1.firmsize ///
	b1.occ ///
	b1.sec ///
	b1.yq_code ///
	if dmy_univ_hschl == 0 & educ != . & exper != . & firmsize != . ///
	, ///
	absorb(muni_code) ///
	cl(state_code)
	
** Matrix
matrix mFirstCoef[1, 3] = _b[educ]
matrix mFirstCoef[2, 3] = _b[exper]
matrix mFirstCoef[3, 3] = _b[expersq]
matrix mFirstCoef[4, 3] = _b[dmy_female]
matrix mFirstCoef[5, 3] = _b[dmy_marriage]
matrix mFirstCoef[6, 3] = .
matrix mFirstCoef[7, 3] = .
matrix mFirstCoef[8, 3] = _b[2.firmsize]
matrix mFirstCoef[9, 3] = _b[3.firmsize]
matrix mFirstCoef[10, 3] = _b[4.firmsize]
matrix mFirstCoef[11, 3] = _b[5.firmsize]
** 
matrix mFirstSE[1, 3] = _se[educ]
matrix mFirstSE[2, 3] = _se[exper]
matrix mFirstSE[3, 3] = _se[expersq]
matrix mFirstSE[4, 3] = _se[dmy_female]
matrix mFirstSE[5, 3] = _se[dmy_marriage]
matrix mFirstSE[6, 3] = .
matrix mFirstSE[7, 3] = .
matrix mFirstSE[8, 3] = _se[2.firmsize]
matrix mFirstSE[9, 3] = _se[3.firmsize]
matrix mFirstSE[10, 3] = _se[4.firmsize]
matrix mFirstSE[11, 3] = _se[5.firmsize]
** 
matrix mFirstStat[1, 3] = e(N)
matrix mFirstStat[2, 3] = e(k_absorb)
matrix mFirstStat[3, 3] = e(r2_a)

** Municipal Wage Fixed Effect
predict muni_fe3_hschl, d
by muni_code, sort: egen muniwage_fe3_hschl = median(muni_fe3_hschl)


** ----------------------------------------
** EXPORT
** ----------------------------------------

** Matrix
matrix mFirst = J(22, 3, .)
forvalues i = 1(1)11 {
	local idx_odd = 2 * `i' - 1 
	local idx_even = 2 * `i'
	matrix mFirst[`idx_odd', 1] = mFirstCoef[`i', 1...]
	matrix mFirst[`idx_even', 1] = mFirstSE[`i', 1...]
}

** Table
matrix list mFirst
matrix mFirstTable = mFirst \ mFirstStat
matrix list mFirstTable

	
** Export
putexcel set "table/results_first_step/tab_01_results_first_step_hschl.xlsx", replace
putexcel B2 = matrix(mFirstTable), names
putexcel close


** +++++++++++++++++++++++++++++++++++++++++++++++
** SAVE Data Set
** +++++++++++++++++++++++++++++++++++++++++++++++
** 
save "dta_dataset_for_estimation/DTA_dataset_step4.dta", replace


