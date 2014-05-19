---
layout: post
title: "Project: Exploring the Risk in Tanking in the NBA"
description: basketball analytics
tags: finalproject
---


#Final Project: Exploring the Risk in Tanking in the NBA#
###by [Bryan Kaufman](http://about.me/bkaufman) ###


##Tanking in the NBA##


The main point of my project was to examine the concept of tanking in the NBA.  Currently, there is a "tanking problem" in the NBA.  Front office executives (and fans for the most part) have bought into the concept that if your team can not win a championship than it's better to 'tank' and try to get a higher draft pick.  The arguments for the pro-tankers is that by tanking it gives your team a better chance to draft a superstar; usually, in order to truly compete, a superstar is needed.  In addition, rookies are paid on a scale - their salaries are not determined by a free market.  To have a potentially great player locked up a cheap four year deal is rightfully considered a valuable asset.  However, the question that I wanted to examine through visualization is how easy is it to go from tanking to competing?  Is it as simple as drafting a young star(s) on a cheap contract?  Is it the right decision to make?  


##Data Collection##


In order to examine this issue, I first decided to look historically how easy it was for teams that tanked to become competitors.  I went to [Basketball Reference](http://www.basketball-reference.com/) and took the historical record from every team since 1985.  All the information was easily scraped off the website and saved in csv form.    All my csvs, including the initial one and the ones created for visualizations in R are held [here](https://www.dropbox.com/sh/jis1cfip6ifssfx/AABcYBc82zxthLhsTcHlApiMa)


##Data Munging##


One the main focuses for myself with the project was to improve my data munging skills, especially with pandas.  Here is my final [iPython worksheet](http://nbviewer.ipython.org/urls/dl.dropbox.com/s/hzpuyr8dnjqw2c6/Project.ipynb).   Even though team information was easily scrapable off Basketball Reference, there was still plenty of data munging to do.  I had to write a function in order to rank the teams.  I would later find out that since the number of teams have changed over the years, I had to normalize the league ranking.  For instance, the worst team in the league one year may be ranked 25th while today its ranked 30th.  In addition, many teams change team names or move.  I did a Groupby and Count in order to make sure that I had all the teams and if there were differences I made sure to fix it by replacing.  I next used binning, which let me break team rankings up into four bins, the top being a competitor and the bottom being a tanking team.  This made it very easy to examine just tanking teams and later see through visualization how the team did.  In order to create a potential heatmap visualization, I had to find a way to first bin the teams into ten separate percentile bins, and then show ten years of performance in a row.  The best way I could think of is by using a shift function 10 times.  For some reason this left my columns in a random order (I'm still not sure why), so I shifted them around to be in the proper place.  All in all, I learned a lot of useful data munging techniques that I can apply in my future work. 


##Visualizations##


The first visualization that I created was looking at how teams improved three years from its current state.  For instance, take the 1990 Boston Celtics.  The X axis would be the percentile rank for that 1990 team and the Y axis would have the 1993 Boston Celtics (three years later).  Because there are 810 data points, I thought it would be interesting to look at how teams did three years later.  Below is the initial visualization:


![intialchart]({{ site.baseurl }}/assets/firsttake.png)


The visualization was a good first look at the dataset that I had.  However, it was clear that I needed to make some visual modifications in order to better draw conclusions.  One quick conclusion from this graph, however, is that the top left and bottom right are the most empty boxes.  This tells me that if you are a bottom team odds are you won't be contending in a few years and vica versa. 

I decided to clean up the dataset.  Essentially, there are some repeat teams.  For instance, here is some of the dataframe of teams that went from tanking to competing:


![dataframe]({{ site.baseurl }}/assets/dataframe.png)


The 2008 and 2009 Okalahoma City Thunder are part of that group;  however, that is essentially the same team/management - it does not help me visualize how useful tanking is when there are repeat team/management.  I wrote a function in order to reduce the repeat teams.  Essentially, if a team made the same jump and its years were one or two years apart then it was counted a duplicate.  This would allow me to look at a cleaner visualization (show below):


![clean3]({{ site.baseurl }}/assets/cleaner.png)


I believe this visualization is much a cleaner and effective way to look at tanking.  I put in a color coded percentile jump to distinguish between teams that were able to make jumps up and down in its percentile ranking in a three year time period.   I think the color scale was effective because viewers can see that the majority of dots are black; essentially, there is not a lot of competitive balance in the NBA.  If you are in one spot you most likely are going to be there three years later - so there is a lot of risk in tanking.  The probability is that the team won't make the jump from bad to good and vica versa.

After completing the three year results, I wanted to do a similar visualization looking at five year results (shown below):


![five]({{ site.baseurl }}/assets/five.png)


Again, with five years, the results are certainly more spread out.  It's interesting to see the teams that were just above average (50-75 percentile) either made the jump to a complete competitor or went to the bottom - they didn't seem to stay pat, as shown by the empty area.

For my next two visualizations, I looked at teams that were in the bottom 25% of the league and examined their track record going forward.  For my presentation in class, I was not able to get a histogram created in d3 in time.  I created a quick histogram in ggplot2.  


![heatmap]({{ site.baseurl }}/assets/histo.png)


The histogram shows that a majority of teams three years later were below average (50 percentile).  This is a cleaner way to show that three years after tanking, the least likely scenario was being a competing team.  After my presentation, I was able to recreate the interactive histogram in d3.  I took a snapshot of it from my own webserver.  My html code to create it is [here](https://github.com/bkaufman/bkaufman.github.com/blob/master/_posts/tanking.htm)


![histogram]({{ site.baseurl }}/assets/d3.png)


The most effective visualization that I created was a heatmap for tanking teams:


![heatmap]({{ site.baseurl }}/assets/riskstanking.png)


 This is a very clear way to see on a 10 year span how bottom teams did and expect to do.  Essentially, if your team tanks and is a bottom 25% team, where will they be in 1 year?  In 2 years?    The color scale goes from blue to light yellow; the darker the blue, the more teams.  I felt after numerous attempts this was the most effective color scale for the visualization. Looking at the heatmap, it is clear that if you tank, then you should expect to continue to be a poor team the next year, as shown by the dark blue. The next interesting point is that it is really hard to be a top 10% team (almost impossible) until after five years following the initial tank.  


##What Went Wrong##


There was a lot of work that went into data munging in order to properly get the right, clean dataset.  However, from a visualization standpoint, the first objective I had was to create a heat map with simply three buckets.  I labeled them 'competitor', 'mediocre', and 'bottom'.  After I created the first visualization, I realized that it was hard to draw any necessary conclusions; there simply were not enough buckets.   This led me to rethink my process and break teams into 10 buckets.  The final visualization came out great. 


##Tools Used##


The main tool that I used during this project was Pandas for data munging and ggplot2 for data visualization.   Before I started my project, I considered myself an 'Excel Wizard'.  After reading that 80% of the time of data scientist is in data preparation and data munging, I wanted to primarily use the project to strengthen my skills in Pandas.  I read through Wes Mckinney's book and, through a lot of trial and error, was able to learn a lot about Pandas.  Below is my R code used to create all the graphs:


```{r chunkLabel}
#examing the value of tanking in the NBA
getwd()
setwd('/Users/bryankaufman/Dropbox/DraftModel')

#importing the files
wly <- read.csv('wlyR.csv', header= TRUE)
clean <- read.csv('cleanoutput.csv', header= TRUE)
five <- read.csv('five.csv', header= TRUE)
heatm <- read.csv('heatmapnew.csv', header=TRUE)

#loading the needed libraries
library('ggplot2')
library('scales')
library('reshape2')

#looking at team results of tanking and where they were three years later
p <- ggplot(wly, aes(x=Percentile, y=Percentile3))
p + geom_point() + xlab('Percentile') + ylab('Percentile - Three Years Later') + ggtitle("Tanking - Three Years Results") +
  theme(axis.text = element_text(colour = "black")) + scale_y_continuous(labels=c("0","25%","50%","75%","100%")) +
  scale_x_continuous(labels=c("0","25%","50%","75%","100%"))

#cleaner view of three years later
q <- ggplot(clean, aes(x=Percentile, y=Percentile3))
q <- q + geom_point(aes(colour = Jump2)) + xlab('Percentile') + ylab('Percentile - Three Years Later') + ggtitle("Tanking - Three Years Results") + scale_x_continuous(breaks=c(0,.25,.50,.75,1), labels=c("0%","25%","50%","75%","100%")) + scale_y_continuous(breaks=c(0,.25,.50,.75,1), labels=c("0%","25%","50%","75%","100%"))
q + theme(axis.text = element_text(colour = "black")) + scale_color_gradient2(name="Percentile Jump", label = percent,low="red", mid= "black",high="green")

#looking at five years later
i <- ggplot(five, aes(x=Percentile, y=Percentile5))
i + geom_point(aes(colour = Jump)) + xlab('Percentile') + ylab('Percentile - Five Years Later') + 
  ggtitle("Tanking - Five Years Results") + 
  scale_x_continuous(breaks=c(0,.25,.50,.75,1), labels=c("0%","25%","50%","75%","100%")) + 
  scale_y_continuous(breaks=c(0,.25,.50,.75,1), labels=c("0%","25%","50%","75%","100%")) +
  theme(axis.text = element_text(colour = "black")) + 
  scale_color_gradient2(name="Percentile Jump", label = percent,low="red", mid= "black",high="green")



#another look at the teams that tanked and where they finished in three years, using a histogram
wlytwo <- wly[wly$Percentile < 0.25,]
his <- ggplot(wlytwo, aes(x = Percentile3))
his + geom_histogram(binwidth = 0.1, colour="darkgreen", fill="white") +ggtitle('Percentile - Three Years Later') + ylab("Frequency") + xlab("Percentile")

#creating a tanking heatmap visualization
colnames(heatm) <- c("rank", c(1:10))
heatm2 <- melt(heatm,id.vars='rank')
head(heatm2)
q <- ggplot(heatm2, aes(x=variable,y=rank))
q + geom_tile(aes(fill=value)) + scale_fill_gradient(name= "Percent of Teams", label= percent, low="light yellow", high="blue") + 
  xlab('Number of Years Later') + ylab('Percentile Rank') + ggtitle('The Risks of Tanking') +
  scale_y_discrete(labels=c("0-10%","10-20%","20-30%","30-40%","40-50%","50-60%","60-70%","70-80%","80-90%","90-100%")) +
  theme(axis.text = element_text(colour = "black"))
```