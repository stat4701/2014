---
layout: post
title: "Blog Post 1: 3 Point Rate"
description: examining the rise in three pointers
tags: blogpost1
---


#Blog Post 1: 3 Point Rate#
###by [Bryan Kaufman](http://about.me/bkaufman) ###

##NYTimes Chart##

The chart that I am going to look at is the following:


![Team Data]({{ site.baseurl }}/assets/web.jpg)


It is titled "The Rise of the 3-Point Shot", and the original link for it is [here](http://www.nytimes.com/2009/10/18/sports/basketball/18threes.html?_r=0)


The topic of the article is a known trend among basketball fans:  Teams throughout the NBA have been taking more and more three point shots.  This has to do with the fact that the NBA has seen an increase in analytically-minded executives.  Using simple math, a team would effectively have to shoot 60% from 2pt to match the point output of 40% from three pointer. 


The biggest and most obvious problem with this chart is that it just shows the 3pt **attempts**.  [Dean Oliver](http://en.wikipedia.org/wiki/Dean_Oliver_%28statistician%29) is famous for breaking down the game of basketball by possessions. Essentially, this helps to adjust for pace.  Teams may play at a faster pace so they see more possessions than other teams, and, therefore, take more shots.  The overall point is that pace is not consistent season to season; there was a significant rise in total FGAs from 1980 to 2014.  To further my point, think of this way, in an exaggerated example:  say in 2005, there was 1000 FGAs and 900 3PT FGAs (so 90% of the shots were 3pt attempts).  Now say in 2006, there was 2000 FGAs and 1000 3PT FGAs (so only half of the shots were threes).  The NYTimes chart would hypothetically show that in 2006, teams were shooting more threes, but in reality the teams would be doing so at a much lower rate.

##Solution: 3 Point Rate##

Three Point Rate is commonly used advanced statistic used to track the percentage of total shots that are three pointers.  This is a better way to visualize the true rise in three point shots.  If you look at the chart, it says that in 1999: "The season was shortened to 50 games because of a lockout".  Because I am visualizing a **rate** instead of an absolute number, it does not matter that a season was shortened.  Here is my chart:


![Team Data]({{ site.baseurl }}/assets/rise3pt.png)


It looks from my chart that there was actually a slight jump in the 3ptr in 1999.  This furthers my point that there are too many factors affecting "average attempts per team" to have that depict the rising trend.

There is a big jump in three point rate going into the 1995 season.  After doing some research, it looks like the NBA shorted the three point line to the college level for the 1995, 1996 and 1997 year.  This was put into place to address the decreased scoring. After the league office changed the rule back (increasing the 3 pt line), interestingly, teams pulled back on their three point shooting; however, it was still much higher than in 1994.  I'm actually very surprised this was not pointed out in the visual. 
  

##Team 3 Point Rates##

Next, I wanted to visualize the rise of three point rate by team.  The main question that I want to answer by this is if the rise is really a league-wide trend like the graph shows or are there certain teams that take an abnormally high amount of threes.

I first tried to do this with a facet wrap but the visualizations came out unclear.  I decided do a jitter plot with a red line that depicted the league average.  I came up with the following visualization:


![Team by Team]({{ site.baseurl }}/assets/teambyteam.png)


As you can see, I decided to include eFG% in the visualization.  Effective Field Goal Percentage quantifies how well a team is shooting from the field.  The difference between Effective Field Goal Percentage and Field Goal Percentage is that eFG% does not penalize the three point shot.  It looked to me that a majority of the green was above the league average.  This was interesting to me and I wanted to look at it more closely with less years.  Here is the visualization that I created:


![Closer]({{ site.baseurl }}/assets/closer.png)


Again, much of the yellow, indicating a high rate, is above the league average. A majority of the dark black is below the league average three point.  Running a correlation between 3ptr and eFG% has a significant p value. However, correlation does not imply causation and you must assume that some teams are simply taking more threes because they have better three point shooters, and also poor shooting teams are simply just poor shooting teams.  However, I believe you could conclude, that some teams aren't achieving their maximum eFG% because they are not taking enough threes - and that's a crucial point to consider.

To better look at the differences among teams, I decided to look at the standard deviation among teams in 3ptr for each year.  I created a quick plot to look at it, as shown below. I did this with the ddply function on R. I created a quick qplot to look at it, as shown below.


![Std]({{ site.baseurl }}/assets/stddev.png)


There was clearly an uptrend in terms of standard deviation, meaning that some teams believed strongly in taking threes while others resistant. Since 2005, however, and especially recently theres been a downtrend.  I wonder if teams are starting to realize the value of the three point shot!



##Some Other Points##

Data Extraction:
Luckily, at Basketball Reference, they have all league averages in .csv format easily [scrapable](http://www.basketball-reference.com/leagues/NBA_stats.html).  The individual team stats by year were also scraped from basketball reference and saved into a csv.   I have been working on a web scraper for basketball reference.  All of the data mungling is seen below using R.

```{r chunkLabel}
#setting working directory and loading the appropriate libraries
setwd('/Users/bryankaufman/Dropbox/nba')
library('plyr')
library('ggplot2')

#creating the rise of the 3pt shot, which is in comparison to the NYTimes article
leagueave <- read.csv('leagueave.csv', header= TRUE)
head(leagueave)
tail(leagueave)
leagueave
#looking at the problems with the original graph
leagueave[,"FGA"]
leagueave[,"Pace"]
#calculating the three point rate
leagueave$X3ptr <- (leagueave$X3PA)/(leagueave$FGA)
#creating my own graph in ggplot2
p <- ggplot(leagueave, aes(x=Year, y=X3ptr))
q <- p + geom_bar(stat="identity", fill="#aaaa99") + opts(panel.background = theme_rect(fill='white', colour='black')) + ggtitle("The Rise of the 3-Point Shot") + ylab("3 Point Rate") + scale_x_continuous(breaks=c(1980,1985,1990,1995,2000,2005,2010,2014)) + scale_y_continuous(breaks=c(0,.05,.1,.15,.2,.25), labels=c("0%","5%","10%","15%","20%","25%"))
q + geom_hline(yintercept=c(0.05,0.1,0.15,0.2,0.25), linetype="dotted", colour="#aaaa99")
i <- q + geom_hline(yintercept=c(0.05,0.1,0.15,0.2,0.25), linetype="dotted", colour="#aaaa99")
head(leagueave)
i + theme(axis.text = element_text(colour = "black"))

#looking at team by team
nbateam <- read.csv('3ptr.csv', header= TRUE)
head(nbateam)
a <- ggplot(nbateam,aes(x=Year,y=X3PAr))
lgav <- nbateam[nbateam$Team == "League Average",]
head(lgav)
a + theme(axis.text = element_text(colour = "black")) + geom_jitter(aes(colour=eFG.)) + scale_color_continuous(low="pink",high="dark green") + geom_line(data=lgav,colour="red",linetype=1) + opts(panel.background = theme_rect(fill='white', colour='black')) + ggtitle("3 Point Rate vs League Average") + ylab("3 Point Rate") + scale_x_continuous(breaks=c(1980,1985,1990,1995,2000,2005,2010,2014)) + scale_y_continuous(breaks=c(0,.05,.1,.15,.2,.25,.30,.35,.40), labels=c("0%","5%","10%","15%","20%","25%","30%","35%","40%"))

#looking at the trends since 2008
nba2008 <- nbateam[1:217,]
tail(nba2008)
y <- ggplot(nba2008,aes(x=Year,y=X3PAr))
ylgav <- nba2008[nba2008$Team == "League Average",]
ylgav
y + theme(axis.text = element_text(colour = "black")) + geom_point(aes(colour=eFG.), size=5) + scale_color_continuous(low="black",high="yellow") + geom_line(data=ylgav,colour="red",linetype=1) + opts(panel.background = theme_rect(fill='white', colour='black')) + ggtitle("3 Point Rate since 2008") + ylab("3 Point Rate") + scale_x_continuous(breaks=c(2008,2009,2010,2011,2012,2013,2014)) + scale_y_continuous(breaks=c(0,.05,.1,.15,.2,.25,.30,.35,.40), labels=c("0%","5%","10%","15%","20%","25%","30%","35%","40%"))


#looking at a regression with 3 point rate and eFG%
nbaregg <- lm(eFG. ~ X3PAr, data=nbateam)
summary(nbaregg)
#visualizing the regression
b <- ggplot(nbateam,aes(x=X3PAr,y=eFG.))
b + geom_jitter()

#quickly looking at standard deviation among teams
sdteam <- ddply(nbateam,c("Year"), summarise, X3PAr = sd(X3PAr))
qplot(data=sdteam,x=Year,y=X3PAr) + ylab("Standard Deviation 3 Point Rate")

```
