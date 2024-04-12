/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** +++++++++++++++++++++++++++++++++++++++++++++++
** Data Set: Municipal Level
** +++++++++++++++++++++++++++++++++++++++++++++++

** ==========================
** Housing
** ==========================
**
import excel "dta_muni/INAFED_Vivienda2010.xlsx", sheet("data") firstrow clear

** 
drop if id_municipio == 0

**
keep estado municipio id_estado id_municipio vph_compu vph_con_agua_dren_elec
**
rename estado state_name
rename municipio muni_name
**
gen muni_code = id_estado * 1000 + id_municipio

**
save "dta_muni/muni_data_2010_vivienda.dta", replace


** ==========================
** Population
** ==========================
**
import excel "dta_muni/INAFED_Poblacion2010.xlsx", sheet("data") firstrow clear

** 
drop if id_municipio == 0

**
keep estado municipio id_estado id_municipio superficie localidades cabecera longitud latitud altitud total p5ymas p15ymas
**
rename estado state_name
rename municipio muni_name
rename superficie area
**
gen muni_code = id_estado * 1000 + id_municipio
**
gen lon_degree = - longitud / 10000, before(longitud)
gen lat_degree = latitud / 10000, after(lon_degree)

**
save "dta_muni/muni_data_2010_poblacion.dta", replace


** ==========================
** Education
** ==========================

**
import excel "dta_muni/INAFED_Educacion2010.xlsx", sheet("data") firstrow clear

** 
drop if id_municipio == 0

**
keep estado municipio id_estado id_municipio grado_escolar
**
rename estado state_name
rename municipio muni_name
**
gen muni_code = id_estado * 1000 + id_municipio

** 
save "dta_muni/muni_data_2010_educacion.dta", replace


** ==========================
** Integrated Data Set in 2010
** ==========================

**
use "dta_muni/muni_data_2010_poblacion.dta", clear

** 
merge 1:1 muni_code using "dta_muni/muni_data_2010_educacion.dta"
drop _merge

** 
merge 1:1 muni_code using "dta_muni/muni_data_2010_vivienda.dta"
drop _merge

** 
save "dta_muni/muni_data_2010_census.dta", replace
