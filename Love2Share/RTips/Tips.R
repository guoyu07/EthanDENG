# 1. Never use as.numeric() to convert a factor variable to numeric, instead
#    use as.numeric(as.character(myFactorVar)).
cha2fac <- as.factor(c("4","8","10","15"))
as.numeric(cha2fac)
as.numeric(as.character(cha2fac))

# 2. options(show.error.messages=F) turns printing error messages off.
class(x) # error msg: Error: object 'x' not found

# 3. Use file.path() to create file paths. It works independent of OS platform.
setwd(file.path("F:", "git", "roxygen2"))

# 4. mixedsort() from gtools package sorts strings with embedded numbers so
#    even the numbers are in correct order. This is not achieved by regular
#    sort() function.
Treatment <- c("Control", "Asprin 10mg/day", "Asprin 50mg/day",
               "Asprin 100mg/day", "Acetomycin 100mg/day",
               "Acetomycin 1000mg/day")
sort(Treatment)
require(gtools)
mixedsort(Treatment)

# 5. Use ylim = range(myNumericData) + 10 as an argument in plot()
#    function to set and adjust the Y axis limits in your plot
x <- seq(1:10)
set.seed(1101)
y <- 10*rnorm(10)
plot(x, y)
plot(x, y, ylim = 1.25*range(y))


# 6. Use las parameter in your plot() to customise the orientation of axis
#    labels. Accepted values are {0, 1, 2, 3} for {parallel to axis, horizontal,
#    perpendicular to axis, vertical}
plot(x, y, las = 1)
plot(x, y, las = 2)

# 7. A compilation of advanced regression types in R:
#    http://rstatistics.net/special-forms-of-regression/

# 8. Use memory.limit(size=2500), where the size is in MB, to manage the
#    maximum memory allocated for R on a Windows machine.


# 9. Use alarm() to produce a short beep sound at the end of your script to
#    notify that the run has completed.
#    NOTES: not functioning in RStudio
for (i in 1:5) {
   Sys.sleep(1)
   alarm()
}

# 10. eval(parse(text=paste("a <- 10"))) will create a new variable 'a' and
#    assign value 10 to it. It executes your strings as if they are R statements.
eval(parse(text=paste("a <- 10")))
a

# 11. sessionInfo() gets the version information about current R session and
#    attached or loaded packages.
sessionInfo()

# 12. Compute the number of changes in characters required to convert one
#    word to another using adist(word1, word2).
adist("hello world","hello wordx")

# 13. options(max.print=1000000) sets the max no. of lines printable in console.
#    Adjust this if you want to see more lines.
options(max.print=1000000)

# 14. Introducing practical and robust anomaly detection in a time series:
#    https://blog.twitter.com/2015/introducing-practical-and-robust-anomaly-detection-in-a-time-series

# 15. Two R sessions running simultaneously is guaranteed to have unique IDs.
#    Get the ID of current R session using Sys.getpid()
Sys.getpid()

# 16. Remove the names attributes from an R object using the unname() function.
y <- quantile(mtcars$mpg)
unname(y)

# 17. Check if two R objects are same with identical(x,y). Use all.equal() to
#     test if values are equal.

x <- c(1, 2)
y <- as.vector(x)
identical(x, y)
all.equal(x, y)
y2 <- c(y, 3)
all.equal(x, y2)

# 18. Extract twitter feed and user tweets from R console.
#     http://rstatistics.net/extracting-tweets-with-r/

# 19. A quick and simplified introduction to Time series Analysis
#     http://rstatistics.net/time-series-analysis/

# 20. Use withTimeout() function from R.utils package to interrupt functions if
#     run time exceeds a preset time limit and move to next step.

# 21. Use dist() to compute the distance between rows of a matrix.
x <- matrix(seq(1:20), ncol = 4, byrow = FALSE)
dist(x, method = "euclidean", upper = TRUE)


# 22. Use diff() to calculate lagged and iterated differences of a numeric vector.
x <- c(seq(1:5), seq(from = 1, to = 9, by = 2))
diff(x, 2)

# 23.Turn off printing scientific notation such 1e-5 in output, using options(scipen=999)
1e-5
options(scipen=999)
1e-5

# 24. bagEarth() from earth package performs a bagged MARS (Multivariate Adaptive Regressive Spline)

# 25. setClass('myClass') will define a new user defined class called 'myClass''.
#     Use setAs() to further customisation.

# 26. assign ("varName", 10) is a convenient way to create numerous
#     variables, as the var name can be passed as a programmable string.
assign("x", 10)

# 27. dim(matrix) returns the number of rows and columns.
my.Matrix <- matrix(1:20, ncol = 4)
dim(my.Matrix)

# 28. 2 Tips to write awesome R functions. https://www.youtube.com/watch?v=ahRHTXNjixU
1. Pass the default argument with ... argument.
2. Use invisible() to decorate the function to hide the output.

# 29. data.matrix() converts a data frame to a numeric matrix. Factors will be
#     converted to appropriate numeric values.

# 30. Use invisible(..) to suppress printing the output to console. Widely used
#     from within functions.

# 31. cat("\014") clears the R Console in Windows.
cat("\014")

# 32. dir("folder.path") shows the files in 'folder path'. Works much like the
#     same way as in windows cmd prompt.
dir()
dir("subfolder.path")

# 33. Make missing values in a factor variable as another category in one-line
#     using: levels(Var) <-c(levels(Var), "UNKNOWN")
my.Factor <- as.factor(c("First", "Second", "Third", NA))
levels(my.Factor) <-c(levels(my.Factor), "UNKNOWN")
my.Factor

# 34. Initialise all required packages in one line:
#     lapply(x, require, character.only = T), where x is char of all required package names
lapply(c("dplyr", "tidyr"), require, character.only = T)

# 35. rev(x) reverses the elements of x
x <- seq(1:10)
rev(x)

# 36. Use complete.cases() to get the rows which are complete (with no missing values)
nrow(mtcars)
mtcars$mpg[mtcars$disp > 200] <- NA
mtcars
mtcars2 <- mtcars[complete.cases(mtcars), ]
mtcars2

# 37. avNNet() from nnet pkg to implement Model Averaged Neural Network

# 38. file.remove('filepath') removes the file from directory. Use this wisely
#     to delete multiple files esp in repetitive tasks.
file.create("tempfile.R")
file.remove("tempfile.R")

# 39. Use ada() in ada pkg to implement Boosted classification trees.


# 40. Use unclass() on objects like 'lm' to break it down to a 'list'. Makes it easier
#     to access un-printed elements this way.
mod <- lm(wt ~ disp + cyl, data = mtcars)
unclass(mod)
