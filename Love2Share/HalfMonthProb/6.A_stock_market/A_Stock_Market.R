# set the working directory
setwd("E:\\Sola\\Git\\Love2Share\\HalfMonthProb\\6.A_stock_market")
# load the required pkg, xlsx pkg need rJava, we use readxl instead
require(readxl)
require(dplyr)

FirstTable  <- read_excel("dataset.xlsx", 1)[,-1]
SecondTable  <- read_excel("dataset.xlsx", 2)[,-1]
ThirdTable <- read_excel("dataset.xlsx", 3)[, -1]

# NOTE: One stock has many used names
STstock <- ThirdTable %>%
  mutate(st = grepl("ST", S_INFO_NAME)) %>%
  group_by(S_INFO_WINDCODE) %>%
  summarise(st_tag = max(st))

Table1 <- left_join(FirstTable, SecondTable, by = c("S_INFO_WINDCODE" = "s_info_windcode"))
MainTable <- left_join(Table1, STstock)

# we combine all the expressions with a simple one
FinalResult <- MainTable %>%
  mutate(status = (S_PCT_CHG >= (9.8 - 4.9*st_tag))*1 + (S_PCT_CHG <= -9.8 + 4.9*st_tag)*-1)
