packages <- c("data.table", "sqldf")
sapply(packages, require, character.only = TRUE, quietly = TRUE)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
acs <- data.table(read.csv(f))
sqldf("select pwgtp1 from acs where AGEP < 50") #OK

sqldf("select pwgtp1 from acs")  ## NO
sqldf("select * from acs where AGEP < 50 and pwgtp1")  ## NO
sqldf("select * from acs where AGEP < 50")  ## NO
