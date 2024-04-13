/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** LOAD Dataset
use "dta_dataset_for_estimation/DTA_dataset_step2.dta", clear


** +++++++++++++++++++++++++++++++++++++++++++++++
** Variables
** +++++++++++++++++++++++++++++++++++++++++++++++

** CPI
merge m:1 year qtr using "dta_cpi/cpi.dta"

** Price Index from Area Minimum Wage
sum salario
scalar max_salario = r(max)
gen col_index = salario / max_salario

** Nominal Hourly Wage
gen lnnw = ln( ing_x_hrs )

** Real Hourly Wage: TIME Control
replace ing_x_hrs = . if ing_x_hrs == 0
gen rw = ing_x_hrs / deflator_wage
gen lnrw = ln( rw )

** Real Hourly Wage: TIME and SPACE Control
gen lnrw_sp = ln( rw / col_index )
gen lnw = lnrw_sp

** AGE
drop if nac_mes == 99 | nac_mes == .
gen qtr_birth = 1 if nac_mes == 1 | nac_mes == 2 | nac_mes == 3
replace qtr_birth = 2 if nac_mes == 4 | nac_mes == 5 | nac_mes == 6
replace qtr_birth = 3 if nac_mes == 7 | nac_mes == 8 | nac_mes == 9
replace qtr_birth = 4 if nac_mes == 10 | nac_mes == 11 | nac_mes == 12

** AGE
gen age = eda if qtr - qtr_birth == 0 
** Birthday in Q1
replace age = eda + 0.25 if qtr - qtr_birth == 1 & qtr_birth == 1
replace age = eda + 0.5 if qtr - qtr_birth == 2 & qtr_birth == 1
replace age = eda + 0.75 if qtr - qtr_birth == 3 & qtr_birth == 1
** Birthday in Q2
replace age = eda + 0.25 if qtr - qtr_birth == 1 & qtr_birth == 2
replace age = eda + 0.5 if qtr - qtr_birth == 2 & qtr_birth == 2
replace age = eda + 0.75 if qtr - qtr_birth == -1 & qtr_birth == 2
** Birthday in Q3
replace age = eda + 0.25 if qtr - qtr_birth == 1 & qtr_birth == 3
replace age = eda + 0.5 if qtr - qtr_birth == -2 & qtr_birth == 3
replace age = eda + 0.75 if qtr - qtr_birth == -1 & qtr_birth == 3
** Birthday in Q4
replace age = eda + 0.25 if qtr - qtr_birth == -3 & qtr_birth == 4
replace age = eda + 0.5 if qtr - qtr_birth == -2 & qtr_birth == 4
replace age = eda + 0.75 if qtr - qtr_birth == -1 & qtr_birth == 4

** AGE
gen agesq = eda^2 / 100
gen agecb = eda^3 / 100
drop eda

** Years of Schooling
drop if anios_esc == 99
gen educ = anios_esc
drop anios_esc

** Years of Experience
gen exper = age - educ - 6
replace exper = . if exper < 0
gen expersq = exper^2 / 100
gen expercb = exper^3 / 100

** Tenure
replace p3r_anio = . if p3r_anio == 9999
gen fexper = 2005 - p3r_anio
replace fexper = . if fexper < 0
replace fexper = fexper + 0.25 if qtr == 1
replace fexper = fexper + 0.5 if qtr == 2
replace fexper = fexper + 0.75 if qtr == 3
gen fexpersq = fexper^2 / 100
gen fexpercb = fexper^3 / 100

** Dummy: Female
gen dmy_female = .
replace dmy_female = 0 if sex == 1
replace dmy_female = 1 if sex == 2

** Dummy: Marriage
gen dmy_marriage = .
replace dmy_marriage = 1 if e_con == 5
replace dmy_marriage = 0 if e_con != 5

** Dummy: Sector 2-Digit
drop if rama_est2 == 0
gen sec = rama_est2
tab sec, gen(dmy_sec)
drop rama_est2

** Dummy: Firmsize
replace p3q = . if p3q == 99
gen firmsize = .
replace firmsize = 1 if p3q <= 3
replace firmsize = 2 if p3q > 3 & p3q <= 7
replace firmsize = 3 if p3q > 8 & p3q <= 9
replace firmsize = 4 if p3q == 10
replace firmsize = 5 if p3q == 11
tab firmsize, gen(dmy_firmsize)

** Dummy: Occupation
gen occ = c_ocu11c
drop if occ == 0
tab occ, gen(dmy_occ)
drop c_ocu11c

** Dummy: Year and Quarterly
tab year, gen(dmy_year)
tab qtr, gen(dmy_qtr)
tab yq, gen(dmy_yq)
		
** +++++++++++++++++++++++++++++++++++++++++++++++
** Data Cleaning
** Drop Outliers for First Step
** +++++++++++++++++++++++++++++++++++++++++++++++

** Wage
sum lnw, detail
return list 
** 
scalar p1_lnw = r(p1)
scalar p99_lnw = r(p99)
** 
replace lnw = . if lnw <= p1_lnw
replace lnw = . if lnw >= p99_lnw


** Years of Education
sum educ, detail
return list 
** 
scalar p1_educ = r(p1)
scalar p99_educ = r(p99)
** 
replace educ = . if educ >= p99_educ


** Years of Experience
sum exper, detail
return list 
** 
scalar p1_exper = r(p1)
scalar p99_exper = r(p99)
** 
replace exper = . if exper >= p99_exper


** 
sum fexper, detail
return list 
** 
scalar p1_fexper = r(p1)
scalar p99_fexper = r(p99)
** 
replace fexper = . if fexper >= p99_fexper

** +++++++++++++++++++++++++++++++++++++++++++++++
** Save
** +++++++++++++++++++++++++++++++++++++++++++++++

** SAVE
save "dta_dataset_for_estimation/DTA_dataset_step3.dta", replace
