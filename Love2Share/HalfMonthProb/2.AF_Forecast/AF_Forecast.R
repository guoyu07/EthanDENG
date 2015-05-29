setwd("E:/Sola/Git/Love2Share/HalfMonthProb/2.AF_Forecast")
require(dplyr)
require(WindR)

data <- tbl_df(read.csv("AF_Forecast.csv", stringsAsFactors = FALSE,blank.lines.skip = TRUE))

data$Rptdt <- as.Date(data$Rptdt)
data$Fenddt <- as.Date(data$Fenddt)

GetEps <- function(rptDate) {
    temp <-
    return(temp$Data$EPS_BASIC)
}

n <- dim(data)[1]

REps <- rep(NA,n)

data <- mutate(data, temp = paste("rptDate=", gsub("-", '', data$Fenddt, fixed=TRUE), sep=""))

for (i in 1:n) {
    REps[i] <- w.wss('000001.SZ','eps_basic',data$temp[i])$Data$EPS_BASIC
}

name <- character()
for (i in 1:n) {
    temp <- strsplit(data$Ananm[i],',',fixed = TRUE)[[1]]
    temp2 <- rep("", 4 - length(temp))
    name <- rbind(name,cbind(temp),cbind(temp2))
}

datax <- data[rep(seq_len(nrow(data)), each = 4), ]
datax <- cbind(datax, name)
datax <- datax %>%
    rename(name = temp) %>%
    filter(name != "" | name != NA & Feps != NA) %>%
    select(-Ananm) %>%
    arrange(name,Rptdt)


m <- dim()
