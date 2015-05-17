*********************************************
*                                           *
*       This file is used for the           *
*       Half Month Problem   No.1           *
*                                           *
*********************************************
/*
    Last Modified on:   2015-05-07
    Last Modified by:   Ethan_Deng
*/
cd "E:\Sola\Git\Love2Share\HalfMonthProb\1.Air_Quality"
* import the data from csv
insheet city date index level pollutant using air_quality_stata.csv,clear
* index is the Air Quality Index (AQI)
destring index, replace
* drop the duplicates
drop if date == "26-Mar-14"
* convert the string to Date type
gen date2 = date(date, "DMY",2019)
format date2 %td

* reshape the long data to wide in order to graph the city separately
encode city, gen(city_num)
drop city level pollutant /* drop the string variables */
reshape wide index, i(date2) j(city_num)

label variable index1 "Beijing"
label variable index2 "Shanghai"
label variable index3 "Shijiazhuang"
label variable index4 "Tianjin"

graph twoway (line index1 date2, lcolor("241 146 62")) (line index2 date2, lcolor("67 154 185")) (line index3 date2, lcolor("155 151 182")) (line index4 date2, lcolor("77 159 109")) ,title("The AQI of four cities in China") xtitle("") ytitle("AQI")
graph export "E:\Sola\Git\Love2Share\HalfMonthProb\1.Air_Quality\air_quality_stata.pdf", as(pdf) replace
graph export "E:\Sola\Git\Love2Share\HalfMonthProb\1.Air_Quality\air_quality_stata.png", as(png) width(600) replace

* generate a variable named dm which is the "month of date" (mofd)
gen dm = mofd(date2)
format dm %tm
collapse index1-index4, by(dm) /* get the monthly average AQI */

label variable index1 "Beijing"
label variable index2 "Shanghai"
label variable index3 "Shijiazhuang"
label variable index4 "Tianjin"
label variable dm "Date"

graph twoway (line index1 dm, lcolor("241 146 62")) (line index2 dm, lcolor("67 154 185")) (line index3 dm, lcolor("155 151 182")) (line index4 dm, lcolor("77 159 109")) ,title("The AQI of four cities in China(monthly average)") xtitle("") ytitle("AQI")
graph export "E:\Sola\Git\Love2Share\HalfMonthProb\1.Air_Quality\air_quality_stata_month.pdf", as(pdf) replace
graph export "E:\Sola\Git\Love2Share\HalfMonthProb\1.Air_Quality\air_quality_stata_month.png", as(png) width(600) replace
