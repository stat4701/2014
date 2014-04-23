---
layout: post
title: Blog post #2: Digital Advertising Frequency Research
description: 
tags: blogpost1, dtjones
---

#Context
Advertisers want to tune parameters such that their ads are most effective. One of these parameters is the number of times a user is exposed to an ad. The goal is to find the appropriate number of exposures such that the ad is effective yet does not waste advertising dollars in excess impressions. 
 
Based on log level data and ad serving technology, we can understand which users act in a desirable fashion, such as view a product page or confirmation page after advertising exposure. We also log the media planning parameters used to serve the ad, such as targeting type, ie behavioral, contextual or demographic targeting, as well as the ad format & media partner among others. 

Based on domain knowledge, we believe that campaign dimensions such as media partner, targeting type & ad format can influence the optimal frequency. Based on probability theory, we hypothesize that this frequency data assumes a [Poisson distribution](http://en.wikipedia.org/wiki/Poisson_distribution ) because of its discrete domain and the Poisson's insight into the probability of an event after a sequence of influences. 

#Data
I munged through log level data in SQL Server to arrive at a dataset that consists of users that completed a successful action (converted), the different site, targeting, and ad format combinations to which they were exposed as well as the count of exposures before they converted. The final dataset has 3 columns: record ID, campaign dimension, and frequency. There were ~35,000 observed conversions in this data. 

From there I imported the data into R to parameterize each Poisson distribution, calculated the probability point estimates over a domain for graphing and visualized in ggplot2. 

#Chart
A jitter/scatter plot nicely shows the variability of converter frequency across campaign dimensions:

![Jitter](https://raw.githubusercontent.com/devintjones/edav/djproject/assets/jitter.jpeg)

And we can better see the distributions in a histogram, and business users can easily see how the parameterized distribution fits the empirical data. I had to scale the probability distributions to the largest value in the histogram to mimic a dual axis plot. 

![FreqDist](https://raw.githubusercontent.com/devintjones/edav/djproject/assets/dist.jpeg)

Here is my R code that parameterizes the distributions:

'''
library(ggplot2)
library(plyr)
library(grid)

#load data
SiteTacticFreq <- read.csv("~/SiteTacticFreq.csv")

#calculate average frequency by site tactic
lambdas <- data.frame()
lambdas <- aggregate(Frequency~SiteTactic, SiteTacticFreq, mean)

#create parameters to evaluate poisson distribution
values <- merge(lambdas,c(1:20),ALL = TRUE)
values<- data.frame(values)
#evaluate poisson distribution. I scaled by 2 to visualize against the histogram
values <- within(values, pois <- 0.5*dpois(y,Frequency))

#find max value in histogram to rescale poisson
maxvalue_hist<- ddply(SiteTacticFreq,.(SiteTactic, Frequency), summarise, count = length(SiteTactic))
maxvalue_hist<- aggregate(count~SiteTactic, maxvalue_hist, max)

#rescale poisson eval
poisson <- merge(values, maxvalue_hist, by = "SiteTactic", all.values=TRUE)
poisson <- within(poisson, rescaled_pois <- pois*8*count)
'''


And here is the jitter chart:
'''
#scatter plot by targeting type
scatter <- ggplot(SiteTacticFreq, aes(y=SiteTactic,x=Frequency)) 
scatter <- scatter + geom_jitter(colour = "#2121D9", size = .1)
scatter <- scatter + ggtitle("Frequency of Converted Users\nby Site, Ad Type, TargetingType")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) +
  ylab("Site & Tactic") 
#scatter <- scatter + annotate("text", x = 400, y = 10, label = "Malicious Software?")
#scatter <- geom_segment(aes(x = 416, y = 10, xend = 416, yend = 12), arrow = arrow())
scatter
'''

And here is the code for over laying the histogram and the distributions:
'''#overlay plots, user rescaled histogram
combined <- ggplot(SiteTacticFreq, aes(x=Frequency)) + 
    geom_histogram(binwidth = .5, colour="#2121D9") +  
    xlim(1,30) +
    geom_line(data=poisson, aes(y,rescaled_pois),colour="#FF9326", fill = cut, size = 1) +
    facet_wrap(~SiteTactic, scales="free") +
    ggtitle("Frequency of Converters & Parameterized Frequency Distribution \nby Site, Ad Type, TargetingType")+
    theme(axis.line = element_line(colour = "black"),
       panel.grid.major = element_blank(),
       panel.grid.minor = element_blank(),
       panel.border = element_blank(),
       panel.background = element_blank()) +
    ylab("Number of Users & P(Conversion)")
    
combined
'''


#Next steps
The data in this example is limited to only those who converted. As a next step I will explore non-parametric survival functions to describe the probability of conversion using all observations, whether they have converted or not. 

<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->