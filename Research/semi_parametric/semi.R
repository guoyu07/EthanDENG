library(dplyr)
# initial parameters to generate the data
b0 <- 1; b1 <- 1; b2 <- 1
# sample size
size <- 1000
# set the seed to generate x1 x2 z11 z12 z13 u
# seed <- sample(seq(1:1000),6,replace = FALSE)
seed <- c(123,323,432,378,245,765)
# define a function to generate the data according
# to the seed set to it
gnorm <- function(seed) {
    set.seed(seed)
    return(rnorm(size))
}
# Define K_h(Zi,Zj)
# Note: Zi\Zj are the i\j row of Z=c(Z1,Z2)
Kh <- function(Zi,Zj) {
    return(prod(sapply((Zi-Zj)/h,ker))/prod(h))
}
# Define the kernel function
# uniform kernel and std normal kernel
ker <- function(v) {
    return(dnorm(v)) # std normal kernel
    # ifelse(abs(v)<=1, 0.5, 0)  # uniform kernel
}
# Data Generating Process(DGP)
# Generate x1 x2 z11 z12 z13 and u at the same time.
data <- as.data.frame(sapply(seed,gnorm))
colnames(data) <- c("x1","x2","z11","z12","z13","u")
# get z1 and z2
data <- mutate(data, z1 = sqrt(0.4)*z11+sqrt(0.6)*z12, z2 = sqrt(0.4)*z11 + sqrt(0.6)*z13)
# get the response data
data <- mutate(data, y = b0 + b1*x1 + b2*x2 + z1 + z2 + z1*z2 +u)

# bandwidth h (by method of Rule of Thumb in textbook p14)
h1 <- 1.06*sd(data$z1)*(size^(-1/5))
h2 <- 1.06*sd(data$z2)*(size^(-1/5))
h <- c(h1,h2)

# extract X \ Y \ Z from "data" in order to manipulate
X <- cbind(data$x1,data$x2)
Z <- cbind(data$z1,data$z2)
Y <- data$y

# Initial the storage data frame for the transformed
# dataset containing  x1hat(x1h)\x2hat(x2h)\yhat(yh)
# and f(Z_i) plus original data x1\x2\y
XY <- data.frame(x1h=rep(NA,size),x2h=rep(NA,size),fz = rep(NA,size),yh=rep(NA,size),x1=data$x1,x2=data$x2,y=data$y)

# Compute the expectation with respect to Z
for (i in 1:size){
    HYi <- 0; FZi <- 0; HXi <- 0
    for (j in 1:size) {
        Khij <- Kh(Z[i,],Z[j,])
        HYi  <-     Y[j]*Khij + HYi
        HXi  <-    X[j,]*Khij + HXi
        FZi  <-          Khij + FZi
    }
    XY[i,3] <- FZi/size
    XY[i,c(1,2)] <- HXi/(size*FZi)
    XY[i,4] <- HYi/(size*FZi)
}


# Default method with the multiply fz at both sides
XY <- mutate(XY,x1d=(x1h-x1),x2d=(x2h-x2),yd=(yh-y))
mod1 <- lm(yd~x1d+x2d-1,XY)

# Density Weighted Estimator
XY <- mutate(XY,x1f=(x1h-x1)*fz,x2f=(x2h-x2)*fz,yf=(yh-y)*fz)
mod2 <- lm(yf~x1f+x2f-1,XY)

summary(mod1)
summary(mod2)
