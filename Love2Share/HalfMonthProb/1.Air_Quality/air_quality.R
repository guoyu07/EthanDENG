########################################################
##   This file is used to plot time series line plot  ##
##   of Love2Share Club Half Month Problem No.1       ##
##   Created by: EthanDeng                            ##
##   Created on: 2015-05-06                           ##
########################################################
setwd("D:/R/Love2ShareClub")

# pkgs needed
require(dplyr)
require(ggplot2)
require(lubridate)
require(showtext)
showtext.auto()

# loading the data into R
air_quality <- tbl_df(read.csv("air_quality.csv", head = FALSE, sep = "\"", stringsAsFactors = FALSE))
air_quality[air_quality == ""] <- NA
levs <- c("优","良","轻度污染","中度污染","重度污染","严重污染")

# clean the data
air_quality <- air_quality %>%
    select(city = V2, date = V4, index = V8, level = V12, pollutant1 = V16, pollutant2 = V18) %>%
    mutate(date = as.Date(date),
           level = factor(level, ordered = TRUE, levels = levs))

# Method: Use ggplot2 to plot and showtext to render the Chinese Character
# Construct the graph (base layer)
g <- ggplot(air_quality, aes(x = date, y = index)) + geom_line(aes(colour = factor(city))) + ylab("AQI index") + theme(plot.title = element_text(lineheight=.8, face="bold",vjust=1.3)) + scale_colour_discrete(name="城市名称")
# Add the title and print out the pdf
g + ggtitle("四个城市的空气污染指数（日变化）")
ggsave("air_quality.pdf")


# To compute the monthly data from the original daily data
air_quality_month <- air_quality %>%
    mutate(year = year(date), month = month(date)) %>%
    group_by(city,year,month) %>%
    summarise(index = mean(index,na.rm = TRUE)) %>%
    filter(index > 0) %>%
    mutate(month = sprintf("%02d",month),
            date = as.Date(paste(year,month,"01",sep="-")))

# Just change the data, modify the title, add the point on the graph
g %+% air_quality_month + ggtitle("四个城市的空气污染指数（月变化）") + scale_y_continuous(limits=c(0, 350)) + geom_point(aes(colour = factor(city)))
ggsave("air_quality_month.pdf")
