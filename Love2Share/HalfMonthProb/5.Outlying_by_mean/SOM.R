# substitute outliers with colMeans
SOM <- function (data) {
  if (is.vector(data)) data <- as.matrix(data)
  if (is.matrix(data)){
    m <- dim(data)[2]
    mu <- colMeans(data)
    upper <- apply(data, 2, function(x) mean(x, na.rm = TRUE) + sd(x, na.rm = TRUE))
    lower <- apply(data, 2, function(x) mean(x, na.rm = TRUE) - sd(x, na.rm = TRUE))
    for (i in 1:m){
      data[,i][data[,i] < lower[i] | data[,i] > upper[i]] <- mu[i]
    }
    return(data)
  } else {
    print("The input is not matrix!")
  }

}  