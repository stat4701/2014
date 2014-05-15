---
layout: post
title: "Blog Post 3: Looking at the Relative Value of NBA Draft Picks"
description: examining the history of draft picks in NBA
tags: blogpost3
---


#Blog Post 3: Looking at the Relative Value of NBA Draft Picks#
###by [Bryan Kaufman](http://about.me/bkaufman)###


##Overview##


There have been some discussion on multiple blog posts about the NBA draft; however, the one that inspired me to write this blog post is [here](http://www.82games.com/barzilai1.htm).  This blog post does some great work - but I wanted to both update and expand on its (Excel) visualizations. This blog post is also a continuation of the work I did for my project.  Here is the visualization from the website:


![site]({{ site.baseurl }}/assets/webrel.gif)


##Obtaining the Data / Data Munging##


I decided to continue to try to improve my abilities in Pandas for data munging.  I took all the information for this blog post off of [Basketball Reference](http://www.basketball-reference.com/). There were two main csv files that were easy to copy and paste from the website.  One of them had a history of who was drafted in the NBA since 1985 and contained 2002 rows.  The other file had information on every single player's season in the NBA since 1985.  Obviously, this was the more extensive file and had 14,914 rows containing player information. I also imported salary data that showed the current rookie wage scale from a popular basketball site called [RealGM](http://basketball.realgm.com/nba/info/rookie_scale).  I copied and pasted into a Google Doc and saved to a .csv.  It turns out I came to the conclusion during my visualization process that this information was not as useful.   

Here are the three csv files that I used: https://www.dropbox.com/sh/zrx666xkf7qr818/AAAm2Qu7jv84eeJJkq-6eaq1a
 
Here is the pandas worksheet that I created:  http://nbviewer.ipython.org/urls/dl.dropbox.com/s/cgn2brapcp20c97/Draft%20Overview.ipynb?create=1

Some necessary data munging that was needed:

The file players.csv had every players stats.  I needed to find a way to get the first 4 and 7 years a players career.  This was tricky because basketball reference repeats a year when a player is traded.  For instance, if Joe Johnson (a player) is traded from Boston to Phoneix in 2001 then the there will be a Boston stat line, a Phoenix stat line and a TOT (total) stat line.  This posed a problem because my original function to get the first four years takes the first four lines of a Player sorted by Year; but if a year is repeated three times, the function would essentially only get two years for Joe Johnson.  In order to solve this problem I created a dictionary to make a custom sort.  It would always put TOT at the top, as this is a player's true total for a year and then delete duplicates. 

Another problem that I encountered was that some players had the same name, so on a potential merge between a players stats and his draft position, there would be error.  In order to fix this error, I searched my draft dataset for duplicates and then manually made the names unique.  

I then wrote a function for the first four and seven years of two player metrics.  The two metrics are called PER (player efficiency rating) and WS (win share) and they attempt to be an all-in-one gauge of a player's ability - nothing is perfect but they work for the analysis in this project.  The rest of the data munging was essentially spent calculating the mean and median for both the 4 year and 7 year data sets and merging them. Why four years and why seven years?  Four years is how long teams signed rookies in the first round, and seven years is how long they usually can have their rights.  After four years a rookie becomes an restricted free agent, meaning if another team signs the player the drafting team can match.  


##Data Visualizations##


The next step after data munging was creating effective visualizations to see the relative value of draft picks.  Since four years is the absolute minimum a team can hold a rookies rights, it was my determination to use the 4 year PER Minutes.   I created the following visualization as my first initial one:


![first]({{ site.baseurl }}/assets/firstviz.png)


It's important to note this is an initial visualization to see my data set.  I wanted something basic and that would allow me to see any trends.  Since I had individual data points I figured the best use would be to create a scatterplot using geom_point.   This visualization confirmed to me that overall the trend is the higher the draft pick (high draft pick = lower number) the better chance the player will be more productive.  It was actually more surprising to me to see one second round data point (pick number great than 30) jump up as an outlier.  I would of assumed that all second round picks were on an absolute basis as close to 0 as possible, since some teams don't even sign their second round pick.

Next, I thought the most important way to visualize draft positions was through a text plot. I felt this would be effective because it would allow me to show three variables, two of performance and the text as the pick number.   Here is the visualization:


![second]({{ site.baseurl }}/assets/textdraft.png)


I decided to do 7 years for this.  I also subsetted my dataset - my initial visualization showed me that the second round wasn't of great important visually.  For the most part, the median second round pick gives close to 0 absolute value.  I put the PER and the WS on opposite axis in order to show different all-in-one levels of performance- again, showing the advantage of a text visualization.  Again, the 1 pick is an outlier on both Win Shares and PER Minutes.  The most interesting gap to me if after pick number 5.  There seems to be a drop off historically if you are not picking in the top 5.  The next drop off seems to be after top 10.  

I next decided to improve upon the visualization from the blog post.  Here is my final product:


![third]({{ site.baseurl }}/assets/finalrel.png)


I initially had this as a scatterplot, but after testing a text graph I thought this would be of better fit.  It clearly shows the information that I want, and using the stat_smooth technique, I am able to include the best fit curve.  I also wanted to include the regression equation as part of the visualization.  If there is empty space that can benefit the end user, I wanted to put it to use.  

Overall, this graph show the relative value of draft picks compared to the first overall pick- this is why the 1 pick has a relative value of 100%.  I decided to use the median instead of the mean and did not feel the need to show the performance confidence interval.  To me, a draft bust is a draft bust, and there is no better way to gauge the value of a certain position than the median pick.  It very interesting how the number 2 pick has been historically below the 3-5 picks!  Again the drop off after top 5 is seen.  It's fascinating how much there is drop off too - the 24 pick is almost as valuable historically as the 8 pick.   Overall, I think this graph does a great job of visually showing where the value is in the NBA draft.

I want to draw this analysis back to my project analysis on tanking.  The risk in tanking is that if you tank and you don't get a top 5 pick, you could essentially be throwing away a year or more.   This is further supported by this graph as the lottery puts teams at a great degree of risk.   There has been a lot of criticism about the NBA lottery and how it does not effectively work; those correctly argue that teams still try to lose games.  After this finding one could only assume that there would be even more tanking if the lottery did not exist given the value of the first overall pick!

Below is my R code that was used to create the visualizations:


```{r chunkLabel}
#examing the draft picks in the NBA
getwd()
setwd('/Users/bryankaufman/Dropbox/DraftModel')

#importing the file I data munged in pandas
draft <- read.csv('draftdata.csv', header=TRUE)

#loading the needed libraries
library('ggplot2')
library('scales')
library('reshape2')


#looking at draft picks historically
m <- ggplot(draft, aes(x=Pick, y=MedPER4))
m + geom_point() + 
  xlab('Draft Pick Number') + ylab('Median PER Minutes (in thousands)') + ggtitle('Four Year Production of Draft Picks') +
  theme(axis.text = element_text(colour = "black")) +
  scale_y_continuous(labels=c("0","50","100","150","200"))


first <- draft[draft$Pick < 31,]
head(first)

#looking at 4th and 7th year differences
both <- ggplot(first, aes(x=MedPER4, y=MedPER7, label=Pick))
both + geom_point()
botht <- lm(MeanPER7 ~ MedPER4, data=first)
summary(botht) #high R Squared



#looking at 7 years for the first round with text
n <- ggplot(first, aes(x=MedWS7, y=MedPER7, label=Pick))
n + geom_text() + xlab("Median Win Shares") + ylab("Median PER Minutes (in thousands)") + ggtitle('Seven Year Production of Draft Picks') +
  theme(axis.text = element_text(colour = "black")) +
  scale_y_continuous(labels=c("0","100","200","300", "350"))

#exponential curve with text
ggplot(draft ,aes(x = Pick,y = RelativePER4, label=Pick)) +
  geom_text(size= 4) + 
  stat_smooth(method = 'nls', formula = 'y ~ a*exp(-b*(x-1))', start = list(a = 1,b=1),se=FALSE) +
  ggtitle("The Relative Value of Draft Picks since 1985") + xlab("Draft Pick") + ylab("Relative Value") +
  scale_y_continuous(labels=c("0","25%","50%","75%", "100%")) +
  scale_x_continuous(breaks=c(0,10,20,30,40,50,60)) +
  annotate("text", label = "Relative Value = 0.89e", x = 39, y = .90, size = 4.5, colour = "black") +
  annotate("text", label = "-0.7(Draft Pick - 1)", x = 51, y = .92, size = 3.5, colour = "black") +
  theme(axis.text = element_text(colour = "black"))

#checking out the fit
fit = nls(data=draft,formula=draft$RelativePER4 ~ a*exp(-b*(draft$Pick-1)), start=list(a=1,b=1))
summary(fit)

#relative salary - not useful
sal <- ggplot(first, aes(x=Pick, y=PerSalary))
sal + geom_point()
```