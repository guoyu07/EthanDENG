# Love2Share Club - HalfMonthPro 5
# Created By: EthanDeng
# Last Modified: 2015/08/03
# Function: To substitute the outliers with the colMeans

# step 1: generate the matrix
setwd("E:/Sola/Git/Love2Share/HalfMonthProb/5.Outlying_by_mean")
n <- 10 # nrow
m <- 8 # ncol
set.seed(1090)
data <- matrix(rnorm(n*m), nrow = n)
# write.csv(data,file = "data.csv")

# step 2: compute the mean + 1*sd
mu <- colMeans(data)
upper <- apply(data, 2, function(x) mean(x, na.rm = TRUE) + sd(x, na.rm = TRUE))
lower <- apply(data, 2, function(x) mean(x, na.rm = TRUE) - sd(x, na.rm = TRUE))

# step 3: substitute the value which not in range [mean - sd, mean + sd]
for (i in 1:m){
  data[,i][data[,i] < lower[i] | data[,i] > upper[i]] <- mu[i]
}