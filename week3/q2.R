library(jpeg)

fileUrl2 = 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
dst2 = 'getwd()'
download.file(fileUrl2, dst2, mode = 'wb', method = 'curl')
data2 = readJPEG(dst2, native = TRUE)
quantile(data2, probs = c(0.3, 0.8))