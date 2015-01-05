setwd("E:/Sola/Git/Economics/Econometrics/semi-parametric")
# semi parametric estimation process

# require DGP.R -> data
source("DGP.R")

# extract X \ Y \ Z from "data" in order to manipulate
X <- cbind(data$x1,data$x2)
Z <- cbind(data$z1,data$z2)
Y <- data$y

# ------------------------- FUNCTION DEFINITION ---------------------------

# Define the kernel function
# uniform kernel and std normal kernel
ker <- function(v) {
    return(dnorm(v)) # std normal kernel
    # ifelse(abs(v)<=1, 0.5, 0)  # uniform kernel
}
Kh <- function(Zi,Zj,h=h) {
    return(prod(sapply((Zi-Zj)/h,ker))/prod(h))
}
# ------------------------- ESTIMATION PROCESS ---------------------------
## bandwidth h (by method of Rule of Thumb in textbook p14)
# h0 = c(0.3303423, 0.3247018)
h0 <- c(1.06*sd(data$z1)*(size^(-1/6)),1.06*sd(data$z2)*(size^(-1/6)))

# Initial the storage data frame for the transformed
# dataset containing  x1hat(x1h)\x2hat(x2h)\yhat(yh)
# and f(Z_i) plus original data x1\x2\y
XY <- data.frame(x1h = rep(NA,size),
                 x2h = rep(NA,size),
                  fz = rep(NA,size),
                  yh = rep(NA,size),
                  x1 = data$x1,
                  x2 = data$x2,
                   y = data$y)

# Given h, estimate betahat with diffrent methods
estimatebeta <- function(h, method = "dwe") {
    for (i in 1:size){
        HYi <- 0; FZi <- 0; HXi <- 0
        for (j in 1:size) {
            Khij <- Kh(Z[i,],Z[j,],h)
            HYi  <-     Y[j]*Khij + HYi
            HXi  <-    X[j,]*Khij + HXi
            FZi  <-          Khij + FZi
        }
        XY[i,3] <- FZi/size
        XY[i,c(1,2)] <- HXi/(size*FZi)
        XY[i,4] <- HYi/(size*FZi)
    }
    if (method == "default") {
        XY  <- mutate(XY,x1d=(x1-x1h),x2d=(x2-x2h),yd=(y-yh))
        mod <- lm(yd~x1d+x2d-1,XY)
    } else {
        # Density Weighted Estimator
        XY  <- mutate(XY,x1f=(x1-x1h)*fz,x2f=(x2-x2h)*fz,yf=(y-yh)*fz)
        mod <- lm(yf~x1f+x2f-1,XY)
    }
    # betahat <<- mod$coef
    return(mod$coef)
}

lscv <- function(h) {
    LSCV = 0
    betahat <- as.matrix(estimatebeta(h, method = "dwe"))
    for (i in 1:size) {
        Gzi <- 0; Khi <- 0;
        for (j in seq(size)[-i]) {
            Gzi <- Gzi + Kh(Z[i,],Z[j,],h)*(Y[j] - (X[j,] %*% betahat))
            Khi <- Khi + Kh(Z[i,],Z[j,],h)
        }
        gzi <- Gzi/Khi
        LSCV <- (Y[i] - (X[i,] %*% betahat) - gzi)^2 + LSCV
    }
    return(LSCV)
}

opth <- optim(h0,lscv)

# opth$par = h <- c(0.2144863,0.2838966) #


