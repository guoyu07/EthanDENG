# This file is the answer to the HalfMonthProb
# Created by: EthanDeng
# Created on: 2015/5/31
setwd("E:/Sola/Git/Love2Share/HalfMonthProb/2.AF_Forecast")
require(dplyr)
require(WindR)
require(lfe)
w.start(showmenu=F);

data <- tbl_df(read.csv("AF_Forecast.csv", stringsAsFactors = FALSE,blank.lines.skip = TRUE))
data$Rptdt <- as.Date(data$Rptdt)
data$Fenddt <- as.Date(data$Fenddt)

# Get the rptDate information
data <- mutate(data, EDates = paste("rptDate=", gsub("-", '', data$Fenddt, fixed=TRUE), sep=""))

# Since the data contains only 17 rptDate, we can
# construct a small database which get the real eps from
# WindR
RealEPS <- data.frame(EDates = paste("rptDate=",c(2002:2018),"1231",sep=""),REps = rep(NA,17))
for (i in 1:17) {
    tempx <- w.wss('000001.SZ','eps_basic',RealEPS$EDates[i])
    if (tempx$ErrorCode == 0){
        RealEPS$REps[i] <- tempx$Data$EPS_BASIC
    } else {
        RealEPS$REps[i] <- NA
    }
}

# Use left_join to Join the data and RealEPS dataset together
data <- left_join(data,RealEPS)

name <- character()
n <- dim(data)[1]
for (i in 1:n) {
    temp <- strsplit(data$Ananm[i],',',fixed = TRUE)[[1]]
    temp2 <- rep("", 4 - length(temp))
    name <- rbind(name,cbind(temp),cbind(temp2))
}

datax <- data[rep(seq_len(nrow(data)), each = 4), ]
datax <- cbind(datax, name)

datam <- datax %>%
    rename(name = temp) %>%
    filter(name != "") %>%
    select(-Ananm) %>%
    arrange(name,Rptdt) %>%
    mutate(dev = abs(Feps - REps)/REps) %>%
    mutate(DateDiff = Fenddt - Rptdt)

write.csv(datam,"datam.csv")

mod <- felm(datam$dev ~ datam$DateDiff + G(datam$name))
summary(mod)

mody <- felm(datam$dev ~ datam$DateDiff + G(datam$name) + G(datam$REps))
summary(mody)

