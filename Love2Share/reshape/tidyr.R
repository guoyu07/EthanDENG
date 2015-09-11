setwd("E:/Sola/Git/Love2Share/reshape")
long.df <- read.csv("tuition.csv")
library(tidyr)

wide.df <- spread(long.df, "year", "falltuit")
# names(wide.df)[3:5] <- paste("falltuit", names(wide.df)[3:5], sep = "")

long.dfx <- gather(wide.df,"year","falltuit",starts_with("201"))
long.dfx <- gather(wide.df,"year","falltuit",3:5)
