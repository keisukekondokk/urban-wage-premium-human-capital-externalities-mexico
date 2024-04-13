/***********************************************************
** (C) KEISUKE KONDO
** FIRST UPLOADED: April 12, 2024
** 
** Kondo, K. (2024) "Distinguishing the urban wage premium from human capital externalities: Evidence from Mexico," RIEB Discussion Paper Series No.2024-09
** URL: https://github.com/keisukekondokk/urban-wage-premium-human-capital-externalities-mexico
***********************************************************/

** LOG
log using "log/LOG__fullestimation.smcl", replace smcl

** 
disp "======================================================"
disp "STEP 0"
disp "======================================================"
*do "DO_step0_dta_enoe_download.do"
*do "DO_step0_dta_enoe_estimation.do"

** 
*do "DO_step0_excel2dta_cpi.do"
*do "DO_step0_excel2dta_muni2005.do"
*do "DO_step0_excel2dta_muni2010.do"

** 
disp "======================================================"
disp "STEP 1"
disp "======================================================"
*do "DO_step1_1_Make_Spatial_Variables_2005.do"
*do "DO_step1_2_Make_Spatial_Variables_2010.do"
do "DO_step1_Make_Spatial_Variables.do"

** 
disp "======================================================"
disp "STEP 2"
disp "======================================================"
do "DO_step2_Make_Dataset.do"

** 
disp "======================================================"
disp "STEP 3"
disp "======================================================"
do "DO_step3_Make_Variables.do"

** 
disp "======================================================"
disp "STEP 4"
disp "======================================================"
do "DO_step4_Estimation_First_Step.do"

** 
disp "======================================================"
disp "STEP 5"
disp "======================================================"
do "DO_step5_Estimation_Second_Step.do"

** 
disp "======================================================"
disp "STEP 6"
disp "======================================================"
do "DO_step6_Estimation_Second_Step_Extention.do"

** Tables
disp "======================================================"
disp "STEP 9"
disp "======================================================"
do "DO_step9_Table_Results.do"

** Figures
disp "======================================================"
disp "STEP 9"
disp "======================================================"
do "DO_step9_Figure_Intro.do"
*do "DO_step9_Figure_Map.do"
do "DO_step9_Figure_Results_Hschl.do"
do "DO_step9_Figure_Results_Total.do"
do "DO_step9_Figure_Results_Univ.do"

** LOG
log close
