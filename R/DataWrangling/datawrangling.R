# 4 data wrangling task in R

### 1. Add a column to an existing dataframe
### 2. Getting summaries by data subgroups
### 3. Grouping by data range (cut function with monthly data)
### 4. Sorting your results
### 5. Reshaping: Wide to Long
### 6. Reshaping: Long to Wide.

# input the dataframe
fy <- c(2010,2011,2012,2010,2011,2012,2010,2011,2012)
company <- c("Apple","Apple","Apple","Google","Google","Google","Microsoft","Microsoft","Microsoft")
revenue <- c(65225,108249,156508,29321,37905,50175,62484,69943,73723)
profit <- c(14013,25922,41733,8505,9737,10737,18760,23150,16978)
companiesData <- data.frame(fy, company, revenue, profit)

# view the structure of the dataset
str(companiesData)

# make the year as ordered factor
companiesData$fy <- factor(companiesData$fy, ordered = TRUE)

# add a new column to the dataframe
companiesData$margin <- (companiesData$profit/companiesData$revenue)*100
# round the margin at 1 decimal places
companiesData$margin <- round(companiesData$margin, 1)
# transform function with the same effects
companiesData <- transform(companiesData, margin = profit/revenue)
# apply function
companiesData$sums <- apply(companiesData[,c("revenue","profit")], 1, function (x) sum(x))
companiesData$margin <- apply(companiesData[, c("revenue","profit")], 1, function(x) {(x[2]/x[1])*100})
# dplyr 
require(dplyr)
companiesData <- mutate(companiesData, margin = round((profit/revenue)*100, 1))


# split by group 
install.packages("plyr")
require(plyr)
# only the result of summarized
highestProfitMargin <- ddply(companiesData, "company", summarize, bestMargin = max(margin))
# with each row exist repeat with same figure
highestProfitMargin <- ddply(companiesData, "company", transform, bestMargin = max(margin))

# apply more than one function at once
myResults <- ddply(companiesData, "company", transform, bestMargin = max(margin), lowestmargin = min(margin))

# the most compact result is given by 
highestProfitMargin <- ddply(companiesData, "company", function(x) x[x$margin == max(x$margin), ])

# update with the dplyr 
myResults <- companiesData %>%
  group_by(company) %>%
  summarise(highestMargin = max(margin))

# sort your data
companyOrder <- order(companiesData$margin)
companiesOrdered <- companiesData[companyOrder,]

companyOrder <- order(-companiesData$margin)
companiesOrdered <- companiesData[companyOrder,]


# reshape wide data to long data format
install.packages("reshape2")
longData <- melt(companiesData, c("fy","company"))
companiesLong <- melt(companiesData, id.vars = c("fy", "company"), measure.vars = c("revenue", "profit", "margin"), variable.name = "FinancialCatagory", value.name = "amount")

# reshape long data to wide data format
companiesWide <- dcast(companiesLong, fy + company ~ FinancialCatagory, value.var = "amount")
