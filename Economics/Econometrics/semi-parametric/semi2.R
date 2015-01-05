setwd("E:/Sola/Git/Economics/Econometrics/semi-parametric")
# semi parametric estimation process

# require DGP2.R -> fdata
source("DGP2.R")

ker <- function(v) {
    return(dnorm(v)) # std normal kernel
    # ifelse(abs(v)<=1, 0.5, 0)  # uniform kernel
}
Kh <- function(Zi,Zj,h=h) {
    return(prod(sapply((Zi-Zj)/h,ker))/prod(h))
}

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
    # Define K_h(Zi,Zj)
    # Note: Zi\Zj are the i\j row of Z=c(Z1,Z2)
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


n <- 100

hs <- data.frame(h1=rep(NA,n),h2=rep(NA,n),c1=rep(NA,n),c2=rep(NA,n))

for (i in seq(n)) {
   data <- sample_n(fdata, size , replace = FALSE)
   X <- cbind(data$x1,data$x2)
   Z <- cbind(data$z1,data$z2)
   Y <- data$y
   h0 <- c(1.06*sd(data$z1)*(size^(-1/6)),1.06*sd(data$z2)*(size^(-1/6)))
   XY <- data.frame(x1h = rep(NA,size),
                    x2h = rep(NA,size),
                     fz = rep(NA,size),
                     yh = rep(NA,size),
                     x1 = data$x1,
                     x2 = data$x2,
                      y = data$y)
   opth <- optim(h0,lscv)
   hs[i,] <- c(h0,opth$par/h0*1.06)
}

write.csv(hs,"hs.csv")

hs <- read.csv("hs.csv")
# con
con <- c(mean(hs$c1),mean(hs$c2))

data <- fdata
size <- 10000
X <- cbind(data$x1,data$x2)
Z <- cbind(data$z1,data$z2)
Y <- data$y


h <- c(con[1]*sd(data$z1)*(size^(-1/6)),con[2]*sd(data$z2)*(size^(-1/6)))

XY <- data.frame(x1h = rep(NA,size), x2h = rep(NA,size), fz = rep(NA,size), yh = rep(NA,size), x1 = data$x1, x2 = data$x2, y = data$y)

for (i in 1:size){
    HYi <- 0; FZi <- 0; HXi <- 0
    for (j in 1:size) {
        Khij <- Kh(Z[i,],Z[j,],h)
        HXi  <-    X[j,]*Khij + HXi
        FZi  <-        1*Khij + FZi
        HYi  <-     Y[j]*Khij + HYi
    }
    XY[i,c(1,2)] <- HXi/(size*FZi)
    XY[i,3] <- FZi/size
    XY[i,4] <- HYi/(size*FZi)
}


XY  <- mutate(XY,x1f=(x1-x1h)*fz,x2f=(x2-x2h)*fz,yf=(y-yh)*fz)
mod <- lm(yf~x1f+x2f-1,XY)
summary(mod)


cgz <- function(z) {
    Gzi <- 0; Khi <- 0;
    for (j in seq(size)) {
        Gzi <- Gzi + Kh(z,Z[j,],h)*(Y[j] - (X[j,] %*% betahat))
        Khi <- Khi + Kh(z,Z[j,],h)
    }
    gzi <- Gzi/Khi
    return(gzi)
}

cgz(z=c(0.5,1.2))

sizez <- 1000
set.seed(1234)
gz11 <- rnorm(sizez)
set.seed(4345)
gz12 <- rnorm(sizez)
sdata <- data.frame(gz11=gz11,gz12=gz12)
sdata <- mutate(sdata,
                gz1 = sqrt(0.4)*gz11+sqrt(0.6)*gz12,
                gz2 = 1,
                gz  = b0 + gz1 + gz2 + gz1*gz2)
gze <- rep(NA,sizez)

for (i in seq(sizez)) {
    gze[i] <- cgz(c(sdata$gz1[i],1))
}
sdata <- mutate(sdata, gze = gze)
sdata <- arrange(sdata,gz1)

write.csv(sdata,"sdata.csv")

# -----------------------restore the data ---------------------------#
sdata <- read.csv("sdata.csv")
sdata <- sdata[,-1]

# the true curve and the estimated
library(ggplot2)
df <- data.frame(gz1 = sdata$gz1, gz = sdata$gz, gze = sdata$gze)
ggplot(df, aes(gz1, y = value, color = variable)) +
    geom_line(aes(y =  gz, col =  "gz")) +
    geom_line(aes(y = gze, col = "gze"))

# the density of points
# install.packages("IDPmisc")
library(IDPmisc)
with(sdata,iplot(gz1,gze,main="The density of estimated value of gz"))

