---
layout: post
title: Vivian's Blog Post 1
description: Remake of vaccine preventable outbreaks visualization
tags: blogpost
---

This blog post is part of a collaborative effort with Michael Thompson and Adam Vigiano from [Information for Humans](http://www.informationforhumans.com).

["The toll of the anti-vaccination movement, in one devastating graphic"](http://www.latimes.com/business/hiltzik/la-fi-mh-antivaccination-movement-20140120,0,5576371.story#axzz2rAAwoI7D). 

That is one hell of a charged statement--one that hits too to home for many American parents. 

One of those parents, Michael, was pulled into the article by the title and turned off by the graphic. \(Read his blog post [here](http://theauguriesofinnocence.blogspot.com/2014/02/frankensteins-creature-vaccinations-and.html)\). 

I agree with Michael and Adam's critiques on the [original data visualization](http://theauguriesofinnocence.blogspot.com/2014/02/frankensteins-creature-vaccinations-and.html):

<ol> 
	<li>The data source is from the Council on Foreign Relations, which scrapes news articles for updated reports on disease outbreaks. While this technique offers real-time data, it's not as rigorous as data from the CDC or WHO.</li>
	<li> The bubbles overlap and crowd the map, so it's hard to see where the breakouts actually occur.</li>
	<li> The color choices are completely unflattering.</li> 
</ol>

I was particularly interested in Whooping Cough, because there is an increasing trend in pertussis cases in the U.S. I also decided to only focus on the U.S., because it's simply unfair to make any claim on "vaccine preventable outbreaks" in countries that don't have the same access to vaccines as we do. 

For the scope of this blog post, I addressed the first issue of data collection. I will get to points 2 & 3 in the next blog post. 
Here's a breakdown of what I did:

<ol> 
	<li>Scraped Whooping Cough breakout cases from the [CDC](http://www.cdc.gov/pertussis/surv-reporting/cases-by-year.html)</li>

	<li>Plotted the data in R to see the trend
```{r chunkLabel}
require(plyr)
cases <- read.table("CDC_PertussisCases.csv", header = TRUE, stringsAsFactors= FALSE,sep="," )
colnames(cases) <- c("Year", "Cases")
as.numeric(cases$Cases)
# exploratory graphs

require(ggplot2)
ggplot(cases, aes(x=as.factor(Year), y=log(Cases))) +geom_point(color = "indianred1") + ggtitle("Pertussis Cases in the US")
```
![US Whooping Cough Cases](https://github.com/veeps/VAX/blob/master/CDCPertussisOutbreaksinUS.png?raw=true)
</li>
	<li>Downloaded CFR data in .csv format</li>

	<li>Cleaned the data in R

```{r chunkLabel}
#Exploring CFR Whooping Cough data

setwd("/Users/vivianpeng/git/VAX")
outbreaks <- read.csv("VAXpreventableOubtreaks.csv", header = TRUE, stringsAsFactors = FALSE, sep =",")
names(outbreaks)
# look for US cases
USoutbreaks <- outbreaks[grep("U.S.", outbreaks$Location),]

# select for Whooping Cough cases
WhoopingCough <- USoutbreaks[grep("Whooping Cough", USoutbreaks$Outbreak), ]
head(WhoopingCough)

# separate States from location column
require(plyr)
require(stringr)
location <- str_split_fixed(WhoopingCough$Location, " ",2)
colnames(location) <-c("Country", "State")
location<- as.data.frame(location)


# remove parenthesis from State column
a <- gsub("\\(", "", location$State)
State <- gsub("\\)", "", a)

# split city into its own column
City <- str_split_fixed(State, ", ",2)
colnames(City) <- c("State", "City")
Cities <- as.data.frame(City)

# add city and state columns back into Whooping Cough table
WhoopingCough$State <- Cities$State
WhoopingCough$City <- Cities$City
WhoopingCough <- WhoopingCough[,-3]

# Change numeric variables to numerics instead of characters
WhoopingCough$Long <- as.numeric(WhoopingCough$Long)
WhoopingCough$Lat <- as.numeric(WhoopingCough$Lat)
WhoopingCough$Cases <- as.numeric(WhoopingCough$Cases)
WhoopingCough$Fatalities <- as.numeric(WhoopingCough$Fatalities)
colnames(WhoopingCough) <- c("Category", "Outbreak", "Lat", "Long", "Date", "Cases", "Fatalities", "ImpactScale", "SourceCitation", "Source", "State", "City")
names(WhoopingCough)

WC <-WhoopingCough

# select for start and end dates for Date column
Dates<- str_split(WC$Date, "-", 2)

# since not all dates have a range, for the ones that do have a range, 
# I am going to replace the range with the start date value 
StartDate <- sapply(Dates, FUN=function(x) x[1])

# split Date to month and Year
MonthYear <- str_split(StartDate, "/", 2)
WhoopingCough$Month <- sapply(MonthYear, FUN= function(x) x[1])
WhoopingCough$Year <- sapply(MonthYear, FUN=function(x) x[2])
WhoopingCough$Year <- as.numeric(WhoopingCough$Year)

names(WhoopingCough)

# split data according to impact scale
epidemic <- WhoopingCough[grep("Epd", WhoopingCough$ImpactScale), ]
cluster <- WhoopingCough[grep("Clst", WhoopingCough$ImpactScale), ]
min(cluster$Cases) 

# remove commas from columns
WhoopingCough$SourceCitation <- gsub(",", "", WhoopingCough$SourceCitation)

# change month into numerics
WhoopingCough$Month <- as.numeric(WhoopingCough$Month)

# clean up row 5
WhoopingCough$SourceCitation[5] <- "Associated Press. Children's Health - Another infant dies of whooping cough in California July 30 2010"
WhoopingCough$ImpactScale[5] <- "Isl"

# write results to file
write.table(WhoopingCough, "WhoopingCough.csv", sep=",", col.names=TRUE, row.names = FALSE)


```
</li>
	<li>Merged CFR data with CDC data

``` {r chunkLabel}
#read in CDC data
CDCcases <- read.table("CDC_PertussisCases.csv", header = TRUE, stringsAsFactors= FALSE,sep="," )
colnames(CDCcases) <- c("Year", "CDCCases")

# filter for cases from 2008 to 2013
CDCcases$Year
CDC2008_2013 <- CDCcases [87:92, ]

require(ggplot2)
# merge CFR data with CDC data
mergedCases <- join(x=TotalCasesByYear, y= CDC2008_2013, by = "Year", match ="first")

# melt data
require(reshape)
meltMerged <- melt(mergedCases, "Year", c("CFRCases", "CDCCases"))
colnames(meltMerged) <- c("Year", "Source", "Cases")


```
</li>
	<li>[Plotted cases](https://github.com/veeps/VAX/blob/master/VAXpreventableOutbreaks.R) to see the difference in outbreak reportings between CFR and CDC
![CFRvCDC Cases](https://github.com/veeps/VAX/blob/master/CDCvsCFR_WCcases_nonLogscale.png?raw=true)
</li>

<li>I was also curious to see what the ranges for the CFR impact scale were.
![CFR Cases Impact Scale](https://github.com/veeps/VAX/blob/master/CFRPertussisCases_ImpactScale.png?raw=true)
</li>
</ol>


