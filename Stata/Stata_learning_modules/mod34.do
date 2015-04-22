twoway (scatter read write) ///
       (lfit read write) , ///
       ytitle(Reading Score)
	   
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod344.pdf", as(pdf) replace

twoway (scatter read write, mlabel(id)) ///
          (lfit read write, range(30 70)) , ///
          ytitle(Reading Score) by(ses female)
		  
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod345.pdf", as(pdf) replace

twoway (scatter read write, mlabel(id)) ///
       (lfit read write, range(30 70)) ///
       (lfit read write if id != 51, range(30 70)) if female==1 & ses==3,
        ytitle(Reading Score) legend(lab(3 "Fitted values without Obs 51"))
		
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod346.pdf", as(pdf) replace
		
		
twoway (scatter read write) ///
       (scatter math write)
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod347.pdf", as(pdf) replace
	   
	   
twoway (scatter read write) ///
       (scatter math write) ///
       (lfit read write)  ///
       (lfit math write)
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod348.pdf", as(pdf) replace

	   
twoway (scatter read write) ///
       (scatter math write) ///
       (lfit read write)  ///
       (lfit math write), ///
       legend(label(3 "Linear Fit") label(4 "Linear Fit")) ///
       legend(order(1 3 2 4))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod349.pdf", as(pdf) replace


twoway (scatter read write) ///
          (scatter math write) ///
       (lfit read write, pstyle(p1) range(25 80) )  ///
       (lfit math write, pstyle(p2) range(25 80) ), ///
       legend(label(3 "Linear Fit") label(4 "Linear Fit")) ///
       legend(order(1 3 2 4))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3410.pdf", as(pdf) replace


separate write, by(female)
twoway (scatter write0 read) (scatter write1 read), ///
  ytitle(Writing Score) legend(order(1 "Males" 2 "Females"))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3411.pdf", as(pdf) replace
  
  
twoway (scatter write0 read) (scatter write1 read) ///
     (lfit write0 read) (lfit write1 read), ///
     ytitle(Writing Score) ///
     legend(order(1 "Males" 2 "Females" 3 "Lfit Males" 4 "Lfit Females")) 
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3412.pdf", as(pdf) replace

	 
twoway (scatter read write) (lfit read write),  name(scatter) 
regress read write
rvfplot,  name(rvf)
lvr2plot, name(lvr) 
graph combine scatter rvf lvr 	 
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3413.pdf", as(pdf) replace


graph combine scatter rvf lvr, hole(2) 
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3414.pdf", as(pdf) replace

////////////////////////////////////////

graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing")
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod351.pdf", as(pdf) replace 

graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing", ///
  color(black) position(11))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod352.pdf", as(pdf) replace 

graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing", ///
  size(medium) position(5) ring(0))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod353.pdf", as(pdf) replace 

graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing", ///
         box bcolor(cyan) blcolor(magenta) bmargin(medium)) 
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod354.pdf", as(pdf) replace 
		 
graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing" ///
  "Sample of 200 Students", linegap(3) )
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod355.pdf", as(pdf) replace 

graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing") /// 
  subtitle("Sample of 200 Students") ///
  note(High School and Beyond Data) ///
  caption(From www.ats.ucla.edu)
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod356.pdf", as(pdf) replace 

graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing") ///
  subtitle("Sample of 200 Students") ///
  note(High School and Beyond Data, size(medium) position(5)) /// 
  caption(From www.ats.ucla.edu, size(vsmall) position(5))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod357.pdf", as(pdf) replace 

// <----->
twoway scatter read write, ///
  ytitle(Score on Writing Test) ///
  xtitle(Score on Reading Test)
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod358.pdf", as(pdf) replace 

twoway scatter read write, ///
  title("Scatterplot of Reading and Writing") ///
  subtitle("Sample of 200 Students") ///
  note(High School and Beyond Data, size(medium) position(5)) /// 
  caption(From www.ats.ucla.edu, size(vsmall) position(5)) ///
  ytitle(Score on Writing Test) ///
  xtitle(Score on Reading Test)
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod359.pdf", as(pdf) replace 

twoway scatter read write, ysize(2) xsize(4)
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3510.pdf", as(pdf) replace 

graph twoway scatter read write, scale(1.5)
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3511.pdf", as(pdf) replace 

// <----->
graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing") /// 
  graphregion( color(sand) ) plotregion(  fcolor(gray) )
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3512.pdf", as(pdf) replace 
  
graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing") /// 
  graphregion( fcolor(red)  ifcolor(sand) ) ///
  plotregion(  fcolor(blue) ifcolor(gray))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3513.pdf", as(pdf) replace 

graph twoway scatter read write, ///
  title("Scatterplot of Reading and Writing") /// 
  graphregion( fcolor(red)   lcolor(yellow)    lwidth(thick)  ///
              ifcolor(sand) ilcolor(orange) ilwidth(thick)) ///
  plotregion(  fcolor(blue)  lcolor(green)    lwidth(thick)  ///
              ifcolor(gray) ilcolor(purple)   ilwidth(thick))
graph export "E:\Sola\Git\Stata\Stata_learning_modules\graph\mod3514.pdf", as(pdf) replace 







