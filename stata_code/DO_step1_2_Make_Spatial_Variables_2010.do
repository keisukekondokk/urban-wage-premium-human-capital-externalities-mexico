/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/
** [PACKAGES REQUIRED]
** ssc install spgen, replace
** 


** +++++++++++++++++++++++++++++++++++++++++++++++
** Data Set: Municipal Level
** +++++++++++++++++++++++++++++++++++++++++++++++

** LOAD MUNICIPAL POLYGON
use MUNICIPAL2005, clear

** SPSET
*spset 

** MERGE CENSUS WITH POLYGON
merge 1:1 muni_code using "dta_muni_estimation/muni_data_2010_census.dta"
drop _merge

** Rename variable name to make panel from 2005 to 2010
rename vph_con_agua_dren_elec vph_con_bienes

** For Count Neighbors
gen one = 1

** Population Density
gen pdens = p15ymas / area   

** Spatial Population Density
forvalues i = 10(10)30 {
	disp "###### DISTANCE = `i' ######"
	spgen one p15ymas grado_escolar area vph_compu vph_con_bienes, lon(lon_degree) lat(lat_degree) swm(bin) dist(`i') dunit(km) nostd dms
	** 
	gen num_muni`i'km = 1 + splag1_one_b
	gen weducyear`i'km = grado_escolar + splag1_grado_escolar_b
	gen wpop`i'km = p15ymas + splag1_p15ymas_b
	gen warea`i'km = area + splag1_area_b
	gen wcompu`i'km = vph_compu + splag1_vph_compu_b
	gen wbienes`i'km = vph_con_bienes + splag1_vph_con_bienes_b
	gen spdens`i'km = wpop`i'km / warea`i'km
	gen seducyear`i'km = weducyear`i'km / num_muni`i'km
	gen scompu`i'km = wcompu`i'km / num_muni`i'km
	gen sbienes`i'km = wbienes`i'km / num_muni`i'km
	**
	drop splag1_*
}

** Population Potential
gen dist_internal = 2/3 * sqrt(area / _pi) 
forvalues i = 1(1)3 {
	disp "###### DELTA = `i' ######"
	spgen p15ymas, lon(lon_degree) lat(lat_degree) swm(pow `i') dist(.) dunit(km) nostd dms
	** 
	gen pp_d`i' = p15ymas * dist_internal^(-`i') + splag1_p15ymas_p  
	** 
	drop splag1_*
}

** Take Logarithm
gen lnpdens = ln( pdens )
forvalues i = 10(10)30 {
	gen lnspdens`i'km = ln( spdens`i'km )
	gen lnscompu`i'km = ln( scompu`i'km )
	gen lnsbienes`i'km = ln( sbienes`i'km )
}
forvalues i = 1(1)3 {
	gen lnpp_d`i' = ln( pp_d`i' )
}

** Take Logarithm
gen lncomp = log(vph_compu)
gen lnbienes = log(vph_con_bienes)

** SAVE
save "dta_dataset_for_estimation/DTA_dataset_2010_step1.dta", replace
