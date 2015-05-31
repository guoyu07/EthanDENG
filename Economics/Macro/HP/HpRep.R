setwd("E:/Sola/Git/Economics/Macro/HP")
library(mFilter)
library(dplyr)

# READ THE DATA FILE INTO R
data <- read.csv("FinalDataX.csv")
data$year <- rep(1960:2008,each=4)

# Clean the data and choose the subsample from 1973
datax <- data %>%
    filter(year > 1972) %>%
    mutate(c = pc + gc) %>%
    mutate(nx = (ex - im)/y) %>%
    select(time,y,c,x,ex,im,nx,ir,p,rx)

attach(datax)

# If transform == TRUE, then use the log data to HP filter,
# If transform != TRUE, then use the original data to HP fun
# compute the std dev manually(cycle/trend)

CalSd <- function(x,transform = TRUE) {
    m <- length(x)
    if (transform == TRUE) {
        temp <- hpfilter(log(x),type="lambda",freq=1600)
        stdx <- sd(temp$cycle)
    } else {
        temp <- hpfilter(x,type="lambda",freq=1600)
        stdx <- sd(temp$cycle/temp$trend)
    }
    return(stdx)
}

# Compute the correlation btw two variables
# Except for nx, use the cycle(HP to log data) to compute the cor
# For nx, DO NOT take log!
CalCor <- function(x1,x2){
    x1temp <- hpfilter(log10(x1),type="lambda",freq=1600)
    x2temp <- hpfilter(log10(x2),type="lambda",freq=1600)
    rel <- cor(x1temp$cycle,x2temp$cycle)
    return(rel)
}


CalSd(y)*100
CalSd(c)/CalSd(y)
CalSd(x)/CalSd(y)
CalSd(ex)*100
CalSd(im)*100
CalSd(nx,FALSE)
CalSd(ir)*100
CalSd(p)*100
CalSd(rx)*100

CalCor(y,c)
CalCor(y,x)
CalCor(y,ex)
CalCor(y,im)
CalCor(y,10^nx)
CalCor(y,p)
CalCor(y,rx)

detach(datax)
