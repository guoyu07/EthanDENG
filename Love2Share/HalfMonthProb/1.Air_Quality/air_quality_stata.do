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
* set the working directory
cd D:\R\Love2ShareClub
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
label variable index2 "Tianjin"
label variable index3 "Shijiazhuang"
label variable index4 "Shanghai"

graph twoway line index1-index4 date2,title("The AQI of four cities in China") xtitle("") ytitle("AQI")
graph export "D:\R\Love2ShareClub\air_quality_stata.pdf", as(pdf) replace

* generate a variable named dm which is the "month of date" (mofd)
* in order to get the average AQI in each month
gen dm = mofd(date2)
format dm %tm
collapse index1-index4, by(dm) /* get the monthly average AQI */

label variable index1 "Beijing"
label variable index2 "Tianjin"
label variable index3 "Shijiazhuang"
label variable index4 "Shanghai"
label variable dm "Date"

graph twoway line index1-index4 dm,title("The AQI of four cities in China(monthly average)") xtitle("") ytitle("AQI")
graph export "D:\R\Love2ShareClub\air_quality_stata_month.pdf", as(pdf) replace
