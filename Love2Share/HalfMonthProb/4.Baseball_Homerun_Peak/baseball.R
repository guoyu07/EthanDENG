setwd("E:/Sola/Git/Love2Share/HalfMonthProb/4.Baseball_Homerun_Peak")
library(dplyr)
library(ggplot2)
library(showtext)
showtext.auto()

Batting <- read.csv("Batting.csv")
Master <- read.csv("Master.csv")

big.df <- merge(Batting, Master, by = "playerID")
big.df <- tbl_df(big.df)

new.data <- big.df %>%
    select(playerID, yearID, birthYear, HR) %>%
    mutate(age = yearID - birthYear) %>%
    filter(!is.na(HR)) %>%
    filter(!is.na(age)) %>%
    filter(age >= 0) %>%
    group_by(playerID) %>%
    summarize(top.HR.age = age[HR == max(HR)][1])

ggplot(new.data, aes(x = top.HR.age)) + geom_histogram(colour = "cyan")
