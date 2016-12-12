library(data.table)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
DT <- fread(f)
check <- function(y, t) {
        message(sprintf("Elapsed time: %.10f", t[3]))
        print(y)
}
t <- system.time(y <- sapply(split(DT$pwgtp15, DT$SEX), mean))
check(y, t)

t <- system.time(y <- mean(DT$pwgtp15, by = DT$SEX))
check(y, t)

t <- system.time(y <- DT[, mean(pwgtp15), by = SEX])
check(y, t)

t <- system.time(y <- rowMeans(DT)[DT$SEX == 1]) + system.time(rowMeans(DT)[DT$SEX == 
                                                                                    2])
t <- system.time(y <- mean(DT[DT$SEX == 1, ]$pwgtp15)) + system.time(mean(DT[DT$SEX == 
                                                                                     2, ]$pwgtp15))
check(y, t)

t <- system.time(y <- tapply(DT$pwgtp15, DT$SEX, mean))
check(y, t)