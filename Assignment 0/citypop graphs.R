setwd("C:\\Users\\mandeep\\Desktop\\ms4826")
df <- read.csv("citypop.csv")
names(df) <- c("Year","Rank","City","Population")
#df[which(df$rank == 1),c("year","city","pop")]

library(plyr)
p1 <- ddply(df, .(Year), transform, avgPop = mean(Population))
ddply(df, .(City), summarise, mean = mean(Population), sd = sd(Population))

### SQLDF ###
library(sqldf)
df2 <- sqldf("SELECT Year, City, Population FROM df where Year > 1900")
df3 <- sqldf("SELECT avg(Population),year FROM df2 GROUP BY Year")
names(df3) <- c("Population","Year")

library(ggplot2)
p <- ggplot(df3, aes(x=Year, y=Population))
p + geom_line(color = "steelblue") + theme_gray()

(topcities <- c("New York", "San Francisco", "Los Angeles"))
library(lattice)
xyplot(Population ~ Year | City, df,
       subset = City %in% topcities)
     

