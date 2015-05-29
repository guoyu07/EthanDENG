setwd("E:/Sola/Git/Economics/Macro/HP")
library(mFilter)
data <- read.csv("test.csv")

CalSd <- function(x) {
    m <- length(x)
    temp <- hpfilter(x,type="lambda",freq=1600)
    stdx <- sd(temp$cycle/temp$trend)*sqrt((m)/m)
    return(stdx)
}

