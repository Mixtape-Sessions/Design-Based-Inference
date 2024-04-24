/****************************************/
/*  Example Solution for Application 1  */
/*  Written by Peter Hull, 4/20/2024    */
/****************************************/

/* Install any needed packages */
cap ssc install ranktest
cap ssc install ivreg2

/* Setup data */
clear all
use angrist_krueger_mod, clear
gen z=(qob==1)

/* Basline IV, RF, and FS */
ivreg2 lwage (educ=z) i.yob if year==1980, r
reg lwage z i.yob if year==1980, r
reg educ z i.yob if year==1980, r

/* Check assignment varies by year */
reg z i.yob if year==1980, r 

/* Check balance on parental income */
ivreg2 pwage z i.yob if year==1980, r
ivreg2 lwage (educ=z) pwage i.yob if year==1980, r

/* Check exclusion on athelete status */
ivreg2 athlete z i.yob if year==1980, r

/* New data IV and balance */
ivreg2 lwage (educ=z) i.yob if year==2000, r
ivreg2 pwage z i.yob if year==2000, r
ivreg2 lwage (educ=z) pwage i.yob if year==2000, r
