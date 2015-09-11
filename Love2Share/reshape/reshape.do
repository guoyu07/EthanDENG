insheet using "E:\Sola\Git\Love2Share\reshape\tuition.csv", clear
* long -> wide
reshape wide falltuit,i(inst) j(year)

* wide -> long: method 1
reshape long falltuit,i(inst) j(year)
* wide -> long: method 2
reshape long falltuit,i(inst)
rename _j year
