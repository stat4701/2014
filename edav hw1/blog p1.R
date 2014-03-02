setwd("C:/Users/mandeep/Desktop/ms4826")
df0 <- read.csv("cbo data.csv",  header = TRUE, stringsAsFactors = FALSE, sep =",")
colnames(df0)[1] <- c("Percentile")
require(reshape)
require(ggplot2)
df1 <- subset(df0, Percentile %in% c("1", "20"))

data1 <- tapply(df1$Labor, list(df1$Percentile,df1$year), sum)
barplot(data1,beside=T,col=c("#ee7700","#3333ff")
        ,main="Labor Income Concentration",xlab="Year",ylab="Labor Income (%)",
        legend.text = c("Top 1 Percentile", "Bottom 20 Percentile"),
        args.legend = list(x = "topleft"))

data2 <- tapply(df1$Business, list(df1$Percentile,df1$year), sum)
barplot(data2,beside=T,col=c("#ee7700","#3333ff")
        ,main="Business Income",xlab="Year",ylab="Business Income (%)",
        legend.text = c("Top 1 Percentile", "Bottom 20 Percentile"),
        args.legend = list(x = "topleft"))

data3 <- tapply(df1$CapitalIncome, list(df1$Percentile,df1$year), sum)
barplot(data3,beside=T,col=c("#ee7700","#3333ff")
        ,main="Capital Income Concentration (Excluding Capital Gain)",xlab="Year",ylab="Capital Income (%)",
        legend.text = c("Top 1 Percentile", "Bottom 20 Percentile"),
        args.legend = list(x = "topleft"))

data4 <- tapply(df1$CapitalGain, list(df1$Percentile,df1$year), sum)
barplot(data4,beside=T,col=c("#ee7700","#3333ff")
        ,main="Capital Gain Concentration",xlab="Year",ylab="Capital Gain (%)",
        legend.text = c("Top 1 Percentile", "Bottom 20 Percentile"),
        args.legend = list(x = "topleft"))


