fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
dst1 <- 'getwd()'
download.file(fileUrl1, dst1, method = 'curl')
data1 <- read.csv(dst1)
agricultureLogical <- (data1$ACR == 3 & data1$AGS == 6)
head(which(agricultureLogical), 3)