/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of First-Step
** +++++++++++++++++++++++++++++++++++++++++++++++

** 
import excel "table/results_first_step/tab_01_results_first_step_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

** 
import excel "table/results_first_step/tab_01_results_first_step_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

** 
import excel "table/results_first_step/tab_01_results_first_step_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** MERGE
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_first_step/tab_01_results_first_step.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close

** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of Second-Step
** Single Variable
** [Variable]
** Population Density
** +++++++++++++++++++++++++++++++++++++++++++++++

**
import excel "table/results_second_step/tab_02_results_second_step_spdens_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

**
import excel "table/results_second_step/tab_02_results_second_step_spdens_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

**
import excel "table/results_second_step/tab_02_results_second_step_spdens_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** 
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_second_step/tab_02_results_second_step_spdens.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close

** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of Second-Step
** Single Variable
** [Variable]
** Average Years of Schooling
** +++++++++++++++++++++++++++++++++++++++++++++++

**
import excel "table/results_second_step/tab_02_results_second_step_seducyear_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

**
import excel "table/results_second_step/tab_02_results_second_step_seducyear_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

**
import excel "table/results_second_step/tab_02_results_second_step_seducyear_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** 
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_second_step/tab_02_results_second_step_seducyear.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close

** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of Second-Step
** Single Variable
** [Variable]
** Population Potential
** +++++++++++++++++++++++++++++++++++++++++++++++

**
import excel "table/results_second_step/tab_02_results_second_step_pp_d2_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

**
import excel "table/results_second_step/tab_02_results_second_step_pp_d2_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

**
import excel "table/results_second_step/tab_02_results_second_step_pp_d2_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** 
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_second_step/tab_02_results_second_step_pp_d2.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close

** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of Second-Step
** Extention
** [Variables]
** Population Density
** Average Years of Education
** +++++++++++++++++++++++++++++++++++++++++++++++

**
import excel "table/results_second_step/tab_02_results_second_step_extention_spdens_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_spdens_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_spdens_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** 
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_second_step/tab_02_results_second_step_extention_spdens.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close


** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of Second-Step
** Extention
** [Variables]
** Population Potential
** Average Years of Education
** +++++++++++++++++++++++++++++++++++++++++++++++

**
import excel "table/results_second_step/tab_02_results_second_step_extention_pp_d2_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_pp_d2_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_pp_d2_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** 
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_second_step/tab_02_results_second_step_extention_pp_d2.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close


** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of Second-Step
** Extention
** [Variables]
** Population Density
** Average Years of Education
** Housing with HEA
** +++++++++++++++++++++++++++++++++++++++++++++++

**
import excel "table/results_second_step/tab_02_results_second_step_extention_omitted_spdens_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_omitted_spdens_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_omitted_spdens_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** 
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_second_step/tab_02_results_second_step_extention_omitted_spdens.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close

** +++++++++++++++++++++++++++++++++++++++++++++++
** Table: Estimation Results of Second-Step
** Extention
** [Variables]
** Population Potential
** Average Years of Education
** Housing with HEA
** +++++++++++++++++++++++++++++++++++++++++++++++

**
import excel "table/results_second_step/tab_02_results_second_step_extention_omitted_pp_d2_total.xlsx", clear first
drop B
mkmat *, mat(mTotal)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_omitted_pp_d2_univ.xlsx", clear first
drop B
mkmat *, mat(mUniv)

**
import excel "table/results_second_step/tab_02_results_second_step_extention_omitted_pp_d2_hschl.xlsx", clear first
drop B
mkmat *, mat(mHschl)

** 
matrix mTable = mTotal, mUniv, mHschl
matrix list mTable

** Export
putexcel set "table/results_second_step/tab_02_results_second_step_extention_omitted_pp_d2.xlsx", replace
putexcel B2 = matrix(mTable), names
putexcel close
