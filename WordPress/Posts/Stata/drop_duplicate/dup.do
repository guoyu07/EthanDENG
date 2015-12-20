use http://www.ats.ucla.edu/stat/stata/notes/hsb2,clear
keep id female ses math read `write'
sort id
drop if id > 10

expand 2 if _n <=5
sort id

replace math = 84 if _n==1
list in 1/15, noobs

duplicates list, nolabel sepby(id)

duplicates tag id math, gen(dup_idmath)
drop if dup_idmath==1
drop dup_idmath

duplicates drop id math,force
