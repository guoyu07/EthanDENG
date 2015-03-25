# NOTE: The R file just generates the data required
library(dplyr)
# ----------------------DGP-------------------------------------
# initial parameters to generate the data
b0 <- 1; b1 <- 1; b2 <- 1
# sample size step1 - > 100, step2 -> 1000/10000
size <- 100
# set the seed to generate x1 x2 z11 z12 z13 u
# seed <- sample(seq(1:1000),6,replace = FALSE)
seed <- c(123,323,432,378,245,765)
# define a function to generate the data according
# to the seed set to it
gnorm <- function(seed) {
    set.seed(seed)
    return(rnorm(size))
}
# Data Generating Process(DGP)
# Generate x1 x2 z11 z12 z13 and u at the same time.
data <- as.data.frame(sapply(seed,gnorm))

colnames(data) <- c("x1","x2","z11","z12","z13","u")
# get z1 and z2
data <- mutate(data, z1 = sqrt(0.4)*z11+sqrt(0.6)*z12, z2 = sqrt(0.4)*z11 + sqrt(0.6)*z13)
# get the response data
data <- mutate(data, y = b0 + b1*x1 + b2*x2 + z1 + z2 + z1*z2 +u)
# -----------------------END-------------------------------------
