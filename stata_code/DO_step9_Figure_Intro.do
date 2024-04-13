/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


**
use "dta_dataset_for_estimation/DTA_dataset_step6.dta", clear



** +++++++++++++++++++++++++++++++++++++++++++++++
** Scatter
** +++++++++++++++++++++++++++++++++++++++++++++++

**
twoway /// 
	(scatter seducyear10km lnspdens10km [aw=p15ymas], msymbol(oh) msize(medium)) ///
	(lfit seducyear10km lnspdens10km [aw=p15ymas], lwidth(thick)) ///
	, ///
	ytitle("Average Years of Schooling",tstyle(size(medlarge))) ///
	xtitle("Log(Population Density)",tstyle(size(medlarge)) height(7)) ///
	ysize(3) ///
	xsize(5) ///
	ylabel(, ang(h) labsize(medlarge) grid gmin gmax) ///
	xlabel(-2(2)10, labsize(medlarge) grid gmin gmax) ///
	legend(off) ///
	graphregion(color(white) fcolor(white))
** 
graph export "figure/intro/fig_scatter_seducyear_lnspdens10km.svg", replace
graph export "figure/intro/fig_scatter_seducyear_lnspdens10km.eps", fontface("Palatino Linotype") replace
graph export "figure/intro/fig_scatter_seducyear_lnspdens10km.png", width(800) replace
