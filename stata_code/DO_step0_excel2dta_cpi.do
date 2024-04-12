/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** +++++++++++++++++++++++++++++++++++++++++++++++
** CPI for REAL WAGE
** +++++++++++++++++++++++++++++++++++++++++++++++

** 
import excel "dta_cpi/cpi.xlsx", sheet("data") firstrow clear

** 
save "dta_cpi/cpi.dta", replace

