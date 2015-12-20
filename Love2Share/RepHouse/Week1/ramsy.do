cd "E:\Sola\Git\Love2Share\RepHouse\Week1"

import excel using "finaldata.xlsx",clear firstrow

gen logGDP85 = ln(perGDP_85)
gen logiy = log(iy/100)
gen logngd = log(g_Labor/100 + 0.05)

reg logGDP85 logiy logngd if NonOil == 1
outreg2 using "model.doc",replace
test logiy + logngd = 0

reg logGDP85 logiy logngd if Intermediate == 1
outreg2 using "model.doc",append
test logiy + logngd = 0

reg logGDP85 logiy logngd if OECD == 1
outreg2 using "model.doc",append
test logiy + logngd = 0



gen X1 = logiy - logngd

reg logGDP85 X1 if NonOil == 1
reg logGDP85 X1 if Intermediate == 1
reg logGDP85 X1 if OECD == 1

gen final = (log(perGDP_85/perGDP_65)*1/25)*100
gen log65 = log(perGDP_65)
scatter final log65 if Intermediate == 1
