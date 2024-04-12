/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** LOAD Dataset
use "dta_dataset_for_estimation/DTA_dataset_step6.dta", clear



** +++++++++++++++++++++++++++++++++++++++++++++++
** Scatter
** Second Step
** +++++++++++++++++++++++++++++++++++++++++++++++


** Average Years of Schooling
forvalues k = 1(1)3 {
	twoway /// 
		(scatter muni_fe`k'_hschl seducyear10km [aw=p15ymas] if muni_fe`k'_hschl != ., msymbol(oh) msize(medium)) ///
		(lfit muni_fe`k'_hschl seducyear10km [aw=p15ymas] if muni_fe`k'_hschl != ., lwidth(thick)) ///
		, ///
		ytitle("Municipal Wage Fixed Effect",tstyle(size(large))) ///
		xtitle("Average Years of Schooling",tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(-1.5(0.5)1.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(2(2)12, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_scatter_wagepremium`k'_seducyear10km_hschl.svg", replace
	graph export "figure/fig_scatter_wagepremium`k'_seducyear10km_hschl.eps", fontface("Palatino Linotype") replace
}

** Population Density
forvalues k = 1(1)3 {
	twoway /// 
		(scatter muni_fe`k'_hschl lnspdens10km [aw=p15ymas] if muni_fe`k'_hschl != ., msymbol(oh) msize(medium)) ///
		(lfit muni_fe`k'_hschl lnspdens10km [aw=p15ymas] if muni_fe`k'_hschl != ., lwidth(thick)) ///
		, ///
		ytitle("Municipal Wage Fixed Effect",tstyle(size(large))) ///
		xtitle("Log(Population Density)",tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(-1.5(0.5)1.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(-2(2)10, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_scatter_wagepremium`k'_lnspdens10km_hschl.svg", replace
	graph export "figure/fig_scatter_wagepremium`k'_lnspdens10km_hschl.eps", fontface("Palatino Linotype") replace
}

** Housing with HEA
forvalues k = 1(1)3 {
	twoway /// 
		(scatter muni_fe`k'_hschl lnsbienes10km [aw=p15ymas] if muni_fe`k'_hschl != ., msymbol(oh) msize(medium)) ///
		(lfit muni_fe`k'_hschl lnsbienes10km [aw=p15ymas] if muni_fe`k'_hschl != ., lwidth(thick)) ///
		, ///
		ytitle("Municipal Wage Fixed Effect",tstyle(size(large))) ///
		xtitle("Log(Housing with HEA)",tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(-1.5(0.5)1.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(2(2)12, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_scatter_wagepremium`k'_lnsbienes10km_hschl.svg", replace
	graph export "figure/fig_scatter_wagepremium`k'_lnsbienes10km_hschl.eps", fontface("Palatino Linotype") replace
}

** Population Potential
forvalues k = 1(1)3 {
	twoway /// 
		(scatter muni_fe`k'_hschl lnpp_d2 [aw=p15ymas] if muni_fe`k'_hschl != ., msymbol(oh) msize(medium)) ///
		(lfit muni_fe`k'_hschl lnpp_d2 [aw=p15ymas] if muni_fe`k'_hschl != ., lwidth(thick)) ///
		, ///
		ytitle("Municipal Wage Fixed Effect",tstyle(size(large))) ///
		xtitle("Log(Population Potential, delta=2)",tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(-1.5(0.5)1.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(4(2)14, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_scatter_wagepremium`k'_lnpp_d2_hschl.svg", replace
	graph export "figure/fig_scatter_wagepremium`k'_lnpp_d2_hschl.eps", fontface("Palatino Linotype") replace
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** Kdensity
** Second Step
** +++++++++++++++++++++++++++++++++++++++++++++++


** Average Years of Schooling
forvalues k = 1(1)3 {
	twoway ///
		(kdensity muni_fe`k'_hschl if dmy_seducyear10km_p50 == 1, lwidth(thick) lcolor(maroon) lpattern(solid) ) ///
		(kdensity muni_fe`k'_hschl if dmy_seducyear10km_p50 == 0, lwidth(thick) lcolor(navy) lpattern(dash) ) ///
		, ///
		ytitle("Density Estimate", tstyle(size(large))) ///
		xtitle("Municipal Wage Fixed Effect", tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(0(0.5)2.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(-1.5(0.5)1.5, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_kdensity_wagepremium`k'_seducyear10km_hschl.svg", replace
	graph export "figure/fig_kdensity_wagepremium`k'_seducyear10km_hschl.eps", fontface("Palatino Linotype") replace
}

** Population Density
forvalues k = 1(1)3 {
	twoway ///
		(kdensity muni_fe`k'_hschl if dmy_spdens10km_p50 == 1, lwidth(thick) lcolor(maroon) lpattern(solid) ) ///
		(kdensity muni_fe`k'_hschl if dmy_spdens10km_p50 == 0, lwidth(thick) lcolor(navy) lpattern(dash) ) ///
		, ///
		ytitle("Density Estimate", tstyle(size(large))) ///
		xtitle("Municipal Wage Fixed Effect", tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(0(0.5)2.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(-1.5(0.5)1.5, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_kdensity_wagepremium`k'_lnspdens10km_hschl.svg", replace
	graph export "figure/fig_kdensity_wagepremium`k'_lnspdens10km_hschl.eps", fontface("Palatino Linotype") replace
}

** Housing with HEA
forvalues k = 1(1)3 {
	twoway ///
		(kdensity muni_fe`k'_hschl if dmy_sbienes10km_p50 == 1, lwidth(thick) lcolor(maroon) lpattern(solid) ) ///
		(kdensity muni_fe`k'_hschl if dmy_sbienes10km_p50 == 0, lwidth(thick) lcolor(navy) lpattern(dash) ) ///
		, ///
		ytitle("Density Estimate", tstyle(size(large))) ///
		xtitle("Municipal Wage Fixed Effect", tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(0(0.5)2.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(-1.5(0.5)1.5, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_kdensity_wagepremium`k'_lnsbienes10km_hschl.svg", replace
	graph export "figure/fig_kdensity_wagepremium`k'_lnsbienes10km_hschl.eps", fontface("Palatino Linotype") replace
}

** Population Potential
forvalues k = 1(1)3 {
	twoway ///
		(kdensity muni_fe`k'_hschl if dmy_pp_d2_p50 == 1, lwidth(thick) lcolor(maroon) lpattern(solid) ) ///
		(kdensity muni_fe`k'_hschl if dmy_pp_d2_p50 == 0, lwidth(thick) lcolor(navy) lpattern(dash) ) ///
		, ///
		ytitle("Density Estimate", tstyle(size(large))) ///
		xtitle("Municipal Wage Fixed Effect", tstyle(size(large)) height(7)) ///
		ysize(4) ///
		xsize(5) ///
		ylabel(0(0.5)2.5, ang(h) labsize(large) grid gmin gmax) ///
		xlabel(-1.5(0.5)1.5, labsize(large) grid gmin gmax) ///
		legend(off) ///
		graphregion(color(white) fcolor(white))
	graph export "figure/fig_kdensity_wagepremium`k'_lnpp_d2_hschl.svg", replace
	graph export "figure/fig_kdensity_wagepremium`k'_lnpp_d2_hschl.eps", fontface("Palatino Linotype") replace
}
