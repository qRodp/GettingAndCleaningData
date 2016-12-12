library(data.table)

fileurl3a = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
dst3a = 'getwd()'
fileurl3b = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
dst3b = 'getwd()'
download.file(fileurl3a, dst3a, method = 'curl')
download.file(fileurl3b, dst3b, method = 'curl')
gdp = fread(dst3a, skip=4, nrows = 190, select = c(1, 2, 4, 5), col.names=c("CountryCode", "Rank", "Economy", "Total"))
edu = fread(dst3b)
merge = merge(gdp, edu, by = 'CountryCode')
merge_sorted <- arrange(merge, desc(Rank))

#q3
nrow(merge_sorted)
merge_sorted[13, "Economy"]

#q4
tapply(merge$Rank, merge$`Income Group`, mean)

#q5
library(dplyr)
library(Hmisc)
merge$RankGroups <- cut2(merge$Rank, g=5)
table(merge$RankGroups, merge$`Income Group`)