/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/


** +++++++++++++++++++++++++++++++++++++++++++++++
** Encuesta Nacional de Ocupación y Empleo (ENOE), población de 15 años y más de edad
** +++++++++++++++++++++++++++++++++++++++++++++++
**
** 2005
forvalues t = 5(1)5 {
	forvalues i = 1/1 {
		** 
		local year = string(`t', "%02.0f")
		display "+++++ 20`year'Q`i' +++++"
		
		** 
		use "dta_enoe_estimation/coe1t`i'`year'.dta", clear
		keep cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent per n_ren ent p3q p3r_anio p3r_mes
		save "dta_enoe_estimation/coe1_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdemt`i'`year'.dta", clear
		keep loc mun est ageb t_loc cd_a ent con upm d_sem sex n_pro_viv v_sel n_hog h_mud n_ent per n_ren eda nac_dia nac_mes nac_anio l_nac_c ///
			cs_p13_1 cs_p16 cs_p17 e_con cs_nr_mot cs_nr_ori salario pos_ocu seg_soc rama c_ocu11c rama_est1 rama_est2 anios_esc ing_x_hrs
		save "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace
		merge 1:1 upm ent con d_sem n_pro_vi v_sel n_hog h_mud n_ent per n_ren ///
			using "dta_enoe_estimation/coe1_20`year'q`i'.dta", gen(_merge_m1)
		gen year = int(20`year')
		gen qtr = int(`i')
		drop if _merge_m1 == 1
		save "dta_enoe_estimation/DTA_dataset_20`year'q`i'.dta", replace
	}
}

** +++++++++++++++++++++++++++++++++++++++++++++++
** Encuesta Nacional de Ocupación y Empleo (ENOE), población de 15 años y más de edad
** +++++++++++++++++++++++++++++++++++++++++++++++

** 2006
forvalues t = 6(1)6 {
	forvalues i = 1/1 {
		** 
		local year = string(`t', "%02.0f")
		display "+++++ 20`year'Q`i' +++++"
		
		** 
		use "dta_enoe_estimation/coe1t`i'`year'.dta", clear
		if( `i' == 1 | `i' == 2 ){
			keep cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent per n_ren ent p3q p3r_anio p3r_mes
		}
		else {
			keep cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent per n_ren ent p3l
			rename p3l p3q
		}
		save "dta_enoe_estimation/coe1_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdemt`i'`year'.dta", clear
		keep loc mun est ageb t_loc cd_a ent con upm d_sem sex n_pro_viv v_sel n_hog h_mud n_ent per n_ren eda nac_dia nac_mes nac_anio l_nac_c ///
			cs_p13_1 cs_p16 cs_p17 e_con cs_nr_mot cs_nr_ori salario pos_ocu seg_soc rama c_ocu11c rama_est1 rama_est2 anios_esc ing_x_hrs
		save "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace
		merge 1:1 upm ent con d_sem n_pro_vi v_sel n_hog h_mud n_ent per n_ren ///
			using "dta_enoe_estimation/coe1_20`year'q`i'.dta", gen(_merge_m1)
		gen year = int(20`year')
		gen qtr = int(`i')
		drop if _merge_m1 == 1
		save "dta_enoe_estimation/DTA_dataset_20`year'q`i'.dta", replace
	}
}


** +++++++++++++++++++++++++++++++++++++++++++++++
** Encuesta Nacional de Ocupación y Empleo (ENOE), población de 15 años y más de edad
** +++++++++++++++++++++++++++++++++++++++++++++++

** 2007
forvalues t = 7(1)8 {
	forvalues i = 1/4 {
		** 
		local year = string(`t', "%02.0f")
		display "+++++ 20`year'Q`i' +++++"
		
		** 
		use "dta_enoe_estimation/coe1t`i'`year'.dta", clear
		if( `i' == 2 ){
			keep cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent per n_ren ent p3q p3r_anio p3r_mes
		}
		else {
			keep cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent per n_ren ent p3l
			rename p3l p3q
		}
		save "dta_enoe_estimation/coe1_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdemt`i'`year'.dta", clear
		keep loc mun est ageb t_loc cd_a ent con upm d_sem sex n_pro_viv v_sel n_hog h_mud n_ent per n_ren eda nac_dia nac_mes nac_anio l_nac_c ///
			cs_p13_1 cs_p16 cs_p17 e_con cs_nr_mot cs_nr_ori salario pos_ocu seg_soc rama c_ocu11c rama_est1 rama_est2 anios_esc ing_x_hrs
		save "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace
		merge 1:1 upm ent con d_sem n_pro_vi v_sel n_hog h_mud n_ent per n_ren ///
			using "dta_enoe_estimation/coe1_20`year'q`i'.dta", gen(_merge_m1)
		gen year = int(20`year')
		gen qtr = int(`i')
		drop if _merge_m1 == 1
		save "dta_enoe_estimation/DTA_dataset_20`year'q`i'.dta", replace
	}
}


** +++++++++++++++++++++++++++++++++++++++++++++++
** Encuesta Nacional de Ocupación y Empleo (ENOE), población de 15 años y más de edad
** +++++++++++++++++++++++++++++++++++++++++++++++

** 2009
forvalues t = 9(1)10 {
	forvalues i = 1/4 {
		** 
		local year = string(`t', "%02.0f")
		display "+++++ 20`year'Q`i' +++++"
		
		** 
		use "dta_enoe_estimation/coe1t`i'`year'.dta", clear
		if( `i' == 1 ){
			keep cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent per n_ren ent p3q p3r_anio p3r_mes
		}
		else {
			keep cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent per n_ren ent p3l
			rename p3l p3q
		}
		save "dta_enoe_estimation/coe1_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdemt`i'`year'.dta", clear
		keep loc mun est ageb t_loc cd_a ent con upm d_sem sex n_pro_viv v_sel n_hog h_mud n_ent per n_ren eda nac_dia nac_mes nac_anio l_nac_c ///
			cs_p13_1 cs_p16 cs_p17 e_con cs_nr_mot cs_nr_ori salario pos_ocu seg_soc rama c_ocu11c rama_est1 rama_est2 anios_esc ing_x_hrs
		save "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace

		** 
		use "dta_enoe_estimation/sdem_20`year'q`i'.dta", replace
		merge 1:1 upm ent con d_sem n_pro_vi v_sel n_hog h_mud n_ent per n_ren ///
			using "dta_enoe_estimation/coe1_20`year'q`i'.dta", gen(_merge_m1)
		gen year = int(20`year')
		gen qtr = int(`i')
		drop if _merge_m1 == 1
		save "dta_enoe_estimation/DTA_dataset_20`year'q`i'.dta", replace
	}
}
