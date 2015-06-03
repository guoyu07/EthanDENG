setwd("C:/Users/Administrator/Desktop")
library(ggplot2)
df <- read.csv("datax.csv")
df$w <- cumsum(df$width) + 2
df$wm <- df$w - df$width
df$wt <- with(df, wm + (w - wm)/2)
ggplot(df, aes(ymin = 0)) + geom_rect(aes(xmin = wm, xmax = w, ymax = height)) + scale_x_continuous(breaks=df$w) + theme_bw()


dati <- read.csv("datam.csv")
bins <- c(2,4,6,8,12,20,30)
ggplot(dati) +  geom_histogram( aes(x=class,y = ..density.., weight=num), breaks = bins, position = "identity") + scale_x_continuous(breaks = bins,labels=bins)

