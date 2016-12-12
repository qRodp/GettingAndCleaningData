library(XML)

url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlInternalTreeParse(url)
rootNode <- xmlRoot(doc)
names(rootNode)

names(rootNode[[1]][[1]])

zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
table(zipcode == 21231)