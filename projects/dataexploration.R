setwd("/Users/vivianpeng/git/edav/_posts")
popdata <- read.table("uspop.csv", stringsAsFactors = FALSE, header = TRUE, sep= ",")
head(popdata)

require(ggplot2)

ggplot(popdata, aes(x=City, y=Pop, color = Year)) + geom_point() 
