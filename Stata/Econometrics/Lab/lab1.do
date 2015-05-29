* sample code 1

* change directory
cd "E:\Sola\Git\Stata\Econometrics\Lab"

* chagne directory
use "Data\HTV", clear

* use a log file to recode the data manipulation process
log using "result\lab1.log", replace

* run simple regression of wage on education
regress wage educ 

* close the log file
 log close
 
 
 
 /*
 -------------  remark  -------------------
 1. comment the log command until in the final process,
 2. uncomment in the final step!
 */
