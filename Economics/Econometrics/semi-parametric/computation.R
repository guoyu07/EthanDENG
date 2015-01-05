# --------------------------Computation Program--------------------------- #
h <- c(0.2144863,0.2838966)

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

# default method
# XY2  <- mutate(XY,x1d=(x1-x1h),x2d=(x2-x2h),yd=(y-yh))
# mod <- lm(yd~x1d+x2d-1,XY2)
# summary(mod)

betahat <- as.matrix(mod$coef)

# Define a function named cgz to compute the nonparametric component

cgz <- function(z) {
    Gzi <- 0; Khi <- 0;
    for (j in seq(size)) {
        Gzi <- Gzi + Kh(z,Z[j,],h)*(Y[j] - (X[j,] %*% betahat))
        Khi <- Khi + Kh(z,Z[j,],h)
    }
    gzi <- Gzi/Khi
    return(gzi)
}

# when z = c(0.5,1.2), what's the estimates?
# in DGP, g(z) = 1 + 0.5 + 1.2 + 0.5*1.2 = 3.3
# in our semiparametric model, the estimates is given by
cgz(z=c(0.5,1.2))
# which the value is 3.257743

# Consider z1 from sqrt(0.4)*rnorm(sizez)+sqrt(0.6)*rnorm(sizez)
# The real gz with the estimated gze
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

# plot(sdata$gz1,sdata$gze,type="l",col=3,xlim=c(-2,2.8))
# lines(sdata$gz1,sdata$gz,type="l",col=1)

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

