/****************************************/
/*  Example Solution for Application 2  */
/*  Written by Peter Hull, 4/23/2024    */
/****************************************/

/* Install any needed packages */
* cap ssc install ftools
* cap ssc install reghdfe

/* Setup data */
clear all
use almond_chay_lee, clear

/* Baseline regressions */
reg bweight smoked blackm educm marm agem, r
reg bweight smoked

/* FWL check */
reg smoked blackm educm marm agem
predict smoked_r, resid
reg bweight smoked_r, r

/* Ex post weights */
gen num = smoked*smoked_r
summ num
gen psi = num/`r(sum)'
drop num
summ psi, d
summ smoked_r if smoked==0
summ smoked_r if smoked==1

/* Richer controls */
egen strata = group(blackm educm marm agem)
reghdfe bweight smoked, absorb(strata) vec(robust)

/* Ex ante weights */
reghdfe smoked, absorb(strata) resid vec(robust)
predict smoked_bar, xbd
gen num = smoked_bar*(1-smoked_bar)
replace num = 0 if smoked_bar==.
summ num
gen phi = num/`r(sum)'
kdensity phi

/* ATE estimation */
teffects ipw (bweight) (smoked blackm educm marm agem), vce(robust)

/* Hospital clustering */
reg bweight smoked blackm educm marm agem, cluster(hospital)
