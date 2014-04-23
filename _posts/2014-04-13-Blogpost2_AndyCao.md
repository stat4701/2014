---
layout: post
title: AndyCao’s Blog post #2
description: Visualizing market cap and price data -- Take 2 (Using rCharts)
tags: Blogpost2
---


## Visualizing Stock Data Using rCharts package

### Summary:

In my [first blogpost](http://malecki.github.io/edav/2014/03/03/Blogpost1_AndyCao/) I modified a [line chart](http://images.businessweek.com/slideshows/2014-01-29/facebook-growing-up#slide9) contained in a BusinessWeek article using the motion chart tool from Google Doc. The original motion chart solved some of the problems with the graph, but I want to utilize the rCharts package to further improve the graph. 

### Problems with Blog Post 1:

As I pointed out toward the end of my first blog post, the original graph was meant to show the incredible speed that Facebook becomes one of the largest companies in the world. My first blog post only showed the progression of its stock price and market capitalization compared to other technology companies, it didn't specifically emphasis the speed of Facebook's ascendance.

Another issue with the first blog post was that I was only able to scrap data for technology companies in the list. As a result, the motion chart looks a little "empty" with only nine bubbles and a lot of white space.

### Improvements I Made in Blog Post 2:

The first improvement I made is to include all companies appeared in the original graph. According to the BusinessWeek article, only 26 U.S companies have ever reached a market cap of $150 billion. In my first blog post, I tried but failed to find the source of the data. As a result, I had to manually scrap the data from varies sources. The problem with that approach was I could only find data starting from 2000. This time, I borrowed the "detetive hat" that Mike wore when investigating the data source from a html page. I first tried to look for a js or html file that contained all the original d3 codes, and I found them in an index.html file. I then found a link and a file name (market_cap.tsv) inside the index.html page. After a few trial and errors, I was able to download the table to my working directory. 

I then spent some time manually scraping [Yahoo! finance](http://finance.yahoo.com/q/hp?s=FB+Historical+Prices) for historical stock prices of the 26 companies. I should probably try to write a web scrapper in Python to automate the process, but I'm not very familiar with Python, so I decided to leave that as a later exercise. After a little data wrangling in Excel and R, I got the stock price data in the same format as the downloaded market cap data. 

The second improvement I made was to utilitze the [rCharts package](http://rcharts.io/gallery/) created by Ramnath Vaidyanathan and a [helper function](http://www.r-bloggers.com/generating-d3js-motion-charts-from-rcharts/) written by Tony Hirst. So it turned out that I wasn't the only R learner intrigued by Professor Rosling's Gapminder work (what a surprise), Tony Hirst actually already wrote a helper function using rCharts to visualize some of Gapminder's works. Standing on the shoulders of giants, I only need to modify the code slightly to tailor for my need. And the new motion chart looks like this:

![]({{ site.baseurl }}/assets/Andycao_assets/mchart_all.html

Similar to the motion chart in Google Doc, viewers can click on any circle to highlight a specific company, and see the progression over time. By moving the mouse along the black bar on the right side, viewers can change the time quickly. I'm not sure why it shows a black bar, instead of years.

One problem with have 26 companies all in the same graph is that the circles tend to group together and overlap each other. So I subset the original data with only tech companies, for a cleaner look. 

![]({{ site.baseurl }}/assets/Andycao_assets/mchart_tech.html

To show the ascendance of Facebook market cap, I created a horizonal bar chart:

![]({{ site.baseurl }}/assets/Andycao_assets/project2_barChart.png

I think this graph really highlighted the astonishing growth of Facebook, although I'm a bit surprised by the fact that Citi Group actually had the second fastest time (24 months). 

#### Code

```{r}
#setwd("C:/Users/P65208/Google Drive/Columbia/STAT W4701/Blogpost2")
setwd('/Users/Macbook/Google Drive/Columbia/STAT W4701/Blogpost2/example')
require(devtools)
install_github("rCharts", "ramnathv")
require(reshape2)
require(ggplot2)

### Create Motion Charts ###
source('testfn_rChartMotionChart.R')
# read in the marketcap table, transform it into long format
time <- seq(as.Date("1990/03/31"), as.Date("2013/12/31"), by = "3 month") 
marketcap <- read.table('market_cap.tsv',  header=TRUE, sep="\t")
marketcap <- melt(marketcap, id.vars = "name")
colnames(marketcap) <- c("company", "Time", "marketCap")
marketcap$Time <- rep(time, each = 26)

# read in the stock price table, transform it into long format, sort it by time
price <- read.table('price.tsv',  header=TRUE, sep="\t", fileEncoding="windows-1252")
price <- melt(price, id.vars = "name")
colnames(price) <- c("company", "Time", "price")
time2 <- seq(as.Date("2013/12/31"), as.Date("1990/03/30"), by = "-3 month") 
price$Time <- rep(time2, each =26)
price <- price[with(price, order(Time)),]

#combine the marketcap and price tables, group them into different industries
stock.data <- merge(price, marketcap, by=c("company", "Time"), all = TRUE)
group <- c("Financial Services","Tabacco","Retail","Technology","Telecom","Financial Services","Financial Services"
            ,"Oil/Gas","Technology","Financial Services","Household Proudcts","Oil/Gas","Technology","Household Proudcts"
            , "Technology","Technology","Technology","Household Proudcts","Financial Services","Pharmceutical"
            , "Technology","Technology","Pharmceutical","Household Proudcts","Retail","Financial Services")
stock.data$group  <- rep(group, each=96)

#extract only the year end data, since the helper function can't handle quarterly
stock.yrdata <- stock.data[seq(0,length(stock.data$Time),4),]
stock.yrdata$Time <- as.integer(seq(1990, 2013,1))
stock.yrdata <- stock.yrdata[complete.cases(stock.yrdata),]
tech.yrdata <- stock.yrdata[stock.yrdata$group == "Technology", ]

# plot the data
mchart.all <- rChartMotionChart(stock.yrdata, 'company', 'Time', 'price', 'marketCap', 'group', 'marketCap')
mchart.tech <- rChartMotionChart(tech.yrdata, 'company', 'Time', 'price', 'marketCap', 'company', 'marketCap')


### Create bar chart ###
timeto150 <- read.csv('race_to_150b.csv', header= TRUE)
timeto150 <- timeto150[with(timeto150, order(time)),c(1,2,4)]
colnames(timeto150) <- c("Company", "Time", "Industry")
mchart <- ggplot(timeto150, aes(x=reorder(Company,-Time), y=Time,  fill = Industry)) + geom_bar(stat = "identity") + 
 ggtitle("Race to 150 billion") + xlab("Company") + ylab("Time to Reach $150b Market Cap")+ coord_flip()
mchart

### Export to html ###
library(knitr)
opts_chunk$set(comment = NA, results = "asis", comment = NA, tidy = F) 
mchart.all$show('inline', include_assets = TRUE, cdn = TRUE)      
mchart.tech$show('inline', include_assets = TRUE, cdn = TRUE)
``` 