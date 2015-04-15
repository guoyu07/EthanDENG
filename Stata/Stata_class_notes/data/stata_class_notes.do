/*
* The datasets can be download from:
* http://stack.ddswhu.com/Stata/Stata_class_notes/data.zip
*/

*********************************************
*                                           *
*       This file is used for the           *
*       Stata Notes Entering Data           *
*                                           *
*********************************************
/*
    Last Modified on:   2015-04-13
    Last Modified by:   Ethan_Deng
*/

cd D:/stata/data
dir

* inport the csv files into stata
insheet using hs0.csv,clear
describe

** import no header csv file into stata
insheet gender id race ses schtyp prgtype read write math science socst using hs0_noname.csv, clear

* import space delimited file
infile gender id race ses schtyp str10 prgtype read write math science socst using hs0.raw,clear

* import fix-format file
infix id 1-2 a1 3-4 t1 5-6 gender 7 a2 8-9 t2 10-11 tgender 12 using schdat.fix,clear

* import the excel file into stata
import excel using hsbdemo.xlsx, sheet("hsbdemo") firstrow clear

clear
input id female race ses str3 schtype prog read write math science socst
147 1 1 3 pub 1 47 62 53 53 61
108 0 1 2 pub 2 34 33 41 36 36
 18 0 3 2 pub 3 50 33 49 44 36
153 0 1 2 pub 3 39 31 40 39 51
 50 0 2 2 pub 2 50 59 42 53 61
 51 1 2 1 pub 2 42 36 42 31 39
102 0 1 1 pub 1 52 41 51 53 56
 57 1 1 2 pub 1 71 65 72 66 56
160 1 1 2 pub 1 55 65 55 50 61
136 0 1 2 pub 1 65 59 70 63 51
end

describe
compress
save hsb10,replace

use "http://www.ats.ucla.edu/stat/data/hs0.dta",clear

*********************************************
*                                           *
*       This file is used for the           *
*       Stata Notes Data Explore            *
*                                           *
*********************************************
/*
    Last Modified on:   2015-04-13
    Last Modified by:   Ethan_Deng
*/

use "http://www.ats.ucla.edu/stat/data/hs0.dta", clear
describe
codebook
lookfor score
labelbook
list
list gender-read in 1/20

log using units2.txt,text replace
summarize
summarize read math science write
display 9.48^2
summarize write,detail
summarize write if read>=60
summarize write if prgtype=="academic"
summarize write in 1/40
tabstat read write math,by(prgtype) stat(n mean sd)
tabstat write, by(prgtype) stat(n mean sd p25 p50 p75)

stem write
stem write,lines(2)

histogram write,normal
histogram write,normal start(30) width(5)

kdensity write,normal
kdensity write,normal width(5)
kdensity math,normal

graph box write
graph box write,over(prgtype)
graph box write,over(prgtype) by(gender)


histogram ses
histogram ses, discrete
tabulate ses
tabulate write
tab1 gender schtyp prgtype

tabulate prgtype ses
tabulate prgtype ses, column row
tabulate prgtype ses, col row

correlate write read science
pwcorr write read science
scatter write read
scatter write read,jitter(2)
graph matrix read science write, half

log close

view units2.txt



*********************************************
*                                           *
*       This file is used for the           *
*       Stata Notes Modifying data          *
*                                           *
*********************************************
/*
    Last Modified on:   2015-04-13
    Last Modified by:   Ethan_Deng
*/
cd D:\stata\data
use hs0,clear

codebook
order id gender
sort id gender

label variable schtyp "type of school"
label define scl 1 public 2 private
label values schtyp scl
codebook schtyp
list schtyp in 1/10
list schtyp in 1/10,nolabel

encode prgtype, gen(prog)
label variable prog "type of program"
codebook prog
list prog in 1/10
list prog in 1/10, nolabel

rename gender female
codebook female
recode female (1=0) (2=1)
label define female_lbl 1 female 0 male
label values female female_lbl
codebook female
list female in 1/10
list female in 1/10, nolabel

list race if race == 5
recode race  5=.
list race if race ==.

generate total = read + write + math + science
summarize total

recode total (0/140=0 F) (141/180=1 D) (181/210=2 C) ( 211/234=3 B) (235/300=4 A),gen(grade)
label variable grade "combined grades of read, write,  math, science"
codebook grade
list read write math science total grade in 1/10
list read write math science total grade in 1/10, nolabel

label data "High School and Beyond"
notes female: the variable gender was renamed to female
notes race: values of race coded as 5 were recoded to be missing
notes

egen zread = std(read)
summarize zread
list read zread in 1/10
egen row_mean = rowmean(read write math science)
list read write math science row_mean in 1/10

save hs1,replace


*********************************************
*                                           *
*       This file is used for the           *
*       Stata Notes Managing Data           *
*                                           *
*********************************************
/*
    Last Modified on:   2015-04-15
    Last Modified by:   Ethan_Deng
*/

use hs1,clear
pwd
dir
ls
cd D:/stata/data
keep if read >= 60
describe
summarize read
save hsgoodread,replace
pwd

* Keep variables
keep id female read write
save hskept,replace
describe
list in 1/20

use hsgoodread,clear
drop ses prog
save hsddropped,replace
describe
list in 1/10

cd masters
dir
use hsmale
tabulate female
append using hsfemale
tabulate female
save hsmasters,replace
cd ..


cd diss
dir
use hsdem,clear
list

merge 1:1 id using hstest

tab _merge
list

save hsdiss,replace
cd ..
dir


*********************************************
*                                           *
*       This file is used for the           *
*       Stata Notes Analyzing Data          *
*                                           *
*********************************************
/*
    Last Modified on:   2015-04-15
    Last Modified by:   Ethan_Deng
*/

use "http://www.ats.ucla.edu/stat/data/hsbdemo.dta",clear

tabulate prog ses,all

tabulate prog ses,all expected

ttest write = 50

ttest write = read

ttest write,by(female)

ttest write,by(female) unequal

anova write prog
anova write prog female prog#female

anova write prog##female

margins prog#female

marginsplot

anova write prog female prog#female c.read

margins prog#female,asbalanced

marginsplot

regress write read i.female
regress write read i.female,robust

predict p
predict r,resid
list write p r in 1/20

kdensity r,normal

pnorm r

qnorm r

rvfplot

regress write read i.prog

test 2.prog 3.prog

regress write i.prog##c.read

test 2.prog 3.prog

testparm prog#c.read
test 2.prog 3.prog

tabulate honors
logit honors read female
logit,or
logistic honors read female
logistic,coef

signtest write = 50
signrank write = read

ranksum write,by(female)
kwallis write,by(pro)


*********************************************
*                                           *
*       End of the Stata .do file           *
*       for the Stata Class Notes           *
*                                           *
*********************************************
