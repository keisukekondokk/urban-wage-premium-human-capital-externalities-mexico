/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/

** Municipal POLYGON
** NOTE: MUNICIPAL2005_shp.dta is required
use MUNICIPAL2005, clear

** 
sort muni_code

** 
merge 1:1 muni_code using "dta_dataset_for_estimation/DTA_dataset_step1.dta"
drop if _merge == 2
drop _merge

** 
xtset, clear
spset 


** +++++++++++++++++++++++++++++++++++++++++++++++
** MAP
** Education
** +++++++++++++++++++++++++++++++++++++++++++++++

	
** Average Years of Schooling
format grado_escolar %5.2f
grmap grado_escolar, ///
	clmethod(quantile) ///
	clnumber(9) ///
	fcolor(Greens) /// 
	osize(none .. none) ///
	ocolor(none .. none) ///
	ndfcolor(white) ///
	ndsize(none) /// 
	legend(position(2) size(medlarge)) ///
	legcount ///
	line(data("ESTADO2005_shp.dta") size(medthin))
** Save
graph export "figure/map/fig_map_educyear.svg", replace
graph export "figure/map/fig_map_educyear.eps", fontface("Palatino Linotype") replace

	
		
** Population Density
format seducyear10km %5.2f
grmap seducyear10km, ///
	clmethod(quantile) ///
	clnumber(9) ///
	fcolor(Greens) /// 
	osize(none .. none) ///
	ocolor(none .. none) ///
	ndfcolor(white) ///
	ndsize(none) /// 
	legend(position(2) size(medlarge)) ///
	legcount ///
	line(data("ESTADO2005_shp.dta") size(medthin))
** Save
graph export "figure/map/fig_map_seducyear.svg", replace
graph export "figure/map/fig_map_seducyear.eps", fontface("Palatino Linotype") replace

	
** +++++++++++++++++++++++++++++++++++++++++++++++
** MAP
** Population Density
** +++++++++++++++++++++++++++++++++++++++++++++++

** Population Density
format lnpdens %5.2f
grmap lnpdens, ///
	clmethod(quantile) ///
	clnumber(9) ///
	fcolor(Greens) /// 
	osize(none .. none) ///
	ocolor(none .. none) ///
	ndfcolor(white) ///
	ndsize(none) /// 
	legend(position(2) size(medlarge)) ///
	legcount ///
	line(data("ESTADO2005_shp.dta") size(medthin))
** Save
graph export "figure/map/fig_map_lnpdens.svg", replace
graph export "figure/map/fig_map_lnpdens.eps", fontface("Palatino Linotype") replace


** Population Density within 10km
format lnspdens10km %5.2f
grmap lnspdens10km, ///
	clmethod(quantile) ///
	clnumber(9) ///
	fcolor(Greens) /// 
	osize(none .. none) ///
	ocolor(none .. none) ///
	ndfcolor(white) ///
	ndsize(none) /// 
	legend(position(2) size(medlarge)) ///
	legcount ///
	line(data("ESTADO2005_shp.dta") size(medthin))
** Save
graph export "figure/map/fig_map_lnspdens10km.svg", replace
graph export "figure/map/fig_map_lnspdens10km.eps", fontface("Palatino Linotype") replace

	
** +++++++++++++++++++++++++++++++++++++++++++++++
** MAP
** Housing with HEA
** +++++++++++++++++++++++++++++++++++++++++++++++

** Bienes
format lnsbienes10km %5.2f
grmap lnsbienes10km, ///
	clmethod(quantile) ///
	clnumber(9) ///
	fcolor(Greens) /// 
	osize(none .. none) ///
	ocolor(none .. none) ///
	ndfcolor(white) ///
	ndsize(none) /// 
	legend(position(2) size(medlarge)) ///
	legcount ///
	line(data("ESTADO2005_shp.dta") size(medthin))
** Save
graph export "figure/map/fig_map_lnsbienes10km.svg", replace
graph export "figure/map/fig_map_lnsbienes10km.eps", fontface("Palatino Linotype") replace

	
** +++++++++++++++++++++++++++++++++++++++++++++++
** MAP
** Population Potential
** +++++++++++++++++++++++++++++++++++++++++++++++
		
** Population Potential
forvalues i = 1(1)3 {
	format lnpp_d`i' %5.2f
	grmap lnpp_d`i', ///
		clmethod(quantile) ///
		clnumber(9) ///
		fcolor(Greens) /// 
		osize(none .. none) ///
		ocolor(none .. none) ///
		ndfcolor(white) ///
		ndsize(none) /// 
		legend(position(2) size(medlarge)) ///
		legcount ///
		line(data("ESTADO2005_shp.dta") size(medthin))
	** Save
	graph export "figure/map/fig_map_lnpp_d`i'.svg", replace
	graph export "figure/map/fig_map_lnpp_d`i'.eps", fontface("Palatino Linotype") replace
}
