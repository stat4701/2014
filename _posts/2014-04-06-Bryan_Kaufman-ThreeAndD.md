---
layout: post
title: "Blog Post 2: 3 and D Players"
description: examining the league's best 3 and D Players
tags: blogpost2
---


#Blog Post 2: Finding the year's best '3 and D Players'#
###by [Bryan Kaufman](http://about.me/bkaufman) ###


##3 and D players##


Recently, in the NBA, with the rise of analytics, there has been the creation of the term '3 and D' to describe certain type of NBA players.  Having someone in the lineup who can provide great defense and hit open threes is a great complement for stars and an asset for a team.  Overall, defensively, these players are disruptive, and, offensively, they can space the floor. 

I wanted to look if anyone has done research on this topic: who are the best 3 and D players in the NBA?  I recently saw [this article](http://www.poundingtherock.com/2013/8/17/4626210/an-attempt-to-find-and-rank-the-leagues-best-3-and-d-role-players).  The article provided some nice information but the visualization could be improved upon, as shown below, and the data was not up to date.  


![3andDViz]({{ site.baseurl }}/assets/web.PNG)


##Obtaining the right data##


I wanted to update the data and explore visually the best '3 and D' players in the NBA.  There are two criteria to deal with: __three point shooting__ and __defensive ability__.

The article takes three stats to come up with a 'three point score'.  It takes three point percentage, three point attempts, and three point rate.  In my opinion, there is too much overlap between three point attempts and three point rate, so I just focused on the current three point rate of players.  I also believe that typical 3 and D players are catch-and-shoot players. Luckily, with the new data made available by SportsVu, I was able to get the Catch-and-Shoot 3 Pt Percentage of each player.  

For defense, the website uses a paid service called Synergy Sports and on/off court defensive rating.  A note should be made that defense is extremely hard to quantify.  I myself took Dean Oliver's Defensive Rating.  This is an estimate of how many points a player allows per 100 possessions.  It must be noted that Defensive Rating is influenced by how efficient his team is.  Big men tend to be somewhat overrated by this metric, while perimeter defenders who do not get many steals are underrated.  The next defensive stat that I used was defensive xRAPM.  RAPM stands for regulated adjusted plus minus; xRAPM essentially tries to evaluate a player by a box score and also by regulated plus-minus (trying to quantify impact that isn't recorded in a traditional box score).  

There was a lot of data munging needed in order to get the clean dataset where I could plot and explore.  I scraped data from three different websites.  I used [Basketball Reference](http://www.basketball-reference.com/leagues/NBA_2014_advanced.html), [stats-for-the-nba](http://stats-for-the-nba.appspot.com/) and [NBA.com](http://stats.nba.com/).   NBA.com was the most frustrating in terms of data scraping because it used Microsoft Silverlight, so this required a lot of manual scraping.  All of the data was scrapped into separate Microsoft Excel files and saved as csv files.  I then used Pandas in the iPython notebook in order to open the files and do the data munging.  

There were three csv files, and they, in theory, included the names of all NBA players.  The tough part is sometimes they go by different names, so I had to make sure that with my final clean data set, every player was correctly matched.  


The code is shown below:

```
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

%cd ~/Dropbox/nba/
cas = pd.read_csv('41catchshoot.csv')
bbr = pd.read_csv('41bbr.csv')
xrapm = pd.read_csv('41xrapm.csv')
acas = cas.iloc[:,[0,1,9,10,11]]
#selecting what i want from bbr data
abbr = bbr[['Player','Tm','G','MP','3PAr','DRtg','USG%']]
abbr = abbr[bbr.G>40]
abbr['MPG'] = abbr['MP']/abbr['G']
abbr = abbr[abbr.MPG > 12]
a = pd.match(abbr.Player,axrapm.Name)
abbr['match'] = a
abbr = abbr.sort('match')
#fix the one part that does not match
abbr.iloc[0,0] = 'Amare Stoudemire'
#merge the two data sets
merge = pd.merge(abbr,axrapm,left_on='Player',right_on='Name',how='left')
#getting rid of duplicates and checking to see if it worked
merge = merge.drop_duplicates(cols='Player')
merge[merge.Player == 'Quincy Acy']
#choose the columns that I want
merge = merge[['Player', '3PAr', 'DRtg','USG%','MPG','Defense per 100']]
b = pd.match(merge.Player,acas.Player)
merge['match2'] = b
#looking at what needs to be matched
merge.Player[merge.match2 == -1]
#finding the replacements
acas[acas['Player'].str.contains("Nen")]
s = pd.Series(['Dennis Schroder', 'Timothy Hardaway Jr.','JJ Hickson','Amare Stoudemire','Jose Juan Barea','John Lucas III','Ish Smith','CJ Watson','PJ Tucker','CJ Miles','Patty Mills','Nene'],
[299,296,285,284,272,271,255,169,164,76,59,40])
merge['new'] = s
merge.head(16)
merge.Player[merge.match2 == -1]  = merge.new[merge.match2 == -1]
merge.head(16)
del merge['new']
del merge['match2']
merge2 = pd.merge(merge,acas,left_on='Player',right_on='Player',how='left')
#getting rid of duplicates and checking to see if it worked
merge2 = merge2.drop_duplicates(cols='Player')
merge2.to_csv('merge2.csv')
```

##Exploring the Data##


After the majority of data munging was finished, I opened the .csv files in R.  My initial goal was to explore the data set that I created. I created the following visualization to essentially locate any trends and see if there was any additional data munging needed:

![intialchart]({{ site.baseurl }}/assets/leagueview.png)


As previously said, this chart was mainly for my exploratory use.  The chart essentially has defensive ability on the x-axis (represented by Defensive xRAPM) and Three Point Rate on the Y Axis.   This allows me to look at the whole league and decide where I should set some conditions within the dataset.  I also put the Catch and Shoot 3PT% as the size of the bubble.  Clearly, there needed to be some addiitonal munging given that there was someone who hit 100% on an extremely low three point rate.  

The first takeaway from my first visual was that anyone who did not shoot a lot of three pointers should be exempt from the analysis.  As shown in the R code (below), I put in the condition that the player must have a rate above 20%.  In addition, anyone with a negative defensive xRAPM should be excluded. Since the players usually are not the stars on the team and mainly complementary players, I also excluded any player with a usage rate less than 20%.


##Final Two Charts##  


After I did my initial exploring and subsequent munging, I had a cleaner dataset.  The next step was creating visualizations to show who were the best 3 and D players.   It's important to note that everyone on these next visualizations is a good 3 and D player; the purpose was finding the best 3 and D players.

I decided to visualize this information in two ways.  As I previously said, defense is extremely hard to quantity defense.   For my first visualization with the clean dataset, I decided to put both the X and Y axis as defensive metrics.  This would help to show the best defenders using both metrics.  I then put the size of the player's name as the player's Catch and Shoot Three Point Percentage.  The visualization is shown below


![defensive]({{ site.baseurl }}/assets/defender3d.png)


I did not want to fill the visualization with too much information, so I left out the three point rate.  Simply by looking at the chart, it is clear who is a great defender and shoots threes efficiently.  It's interesting that Andre Iguodala and Draymond Green both play for the same team as do Danny Green and Kawhi Leonard.  The biggest text size for a player is Kyle Korver, who has the highest rate but his individual Defensive Rating clearly is where he struggles. Again, it is really clear how Andre Iguodala is constantly a great plus-minus player.  He provides a lot defensively and is a complement on the offensive end with his catch and shoot ability. In my opinion, two interesting names on the list are DeMarre Carroll and Anthony Tolliver.   While most of the names are familiar ones, these two stick out as solid 3 and D players that may not get enough credit.  

I next wanted to create a similar visualization; this time I wanted to illustrate defensive ability and three point ability on separate axis.  Since I view Defensive xRAPM as the better metric, I made it the X axis.   I wanted to incorporate both statistics of three point shooting, rate and catch and shoot efficiency . Below is the visualization.


![both]({{ site.baseurl }}/assets/best3andD.png)


This visualization truly shows how great of a player Kyle Korver is; again, the size of his name shows how effective of a three point shooter he is.  Tolliver again is impressive.  He's a better defender than the majority of the good defenders; an extremely high amount of FGs that he attempts are threes, and he is relatively efficient off the catch and shoot.  In addition, one could argue the best '3 and D' player is Danny Green.  He is exceptional defensively, has a three point rate over 60% and, given the size of his name, it is clear that he is efficient.    Andre Iguodala almost looks like an outlier due to how skilled he is defensively!

For both my visualizaitons, I tried to make it clear what part of the graph the best players should be in.  I believe I was able to effectively create a visualization that shows, among all 3 and D players, which ones were truly the best.

Below is the R code used to create all the graphs.

```{r chunkLabel}
#load the needed libraries
library('ggplot2')
library('scales')

#check and set the working directories
getwd()
setwd('/Users/bryankaufman/Dropbox/nba/')

#load the file from pandas
threed <- read.csv('merge2.csv', header= TRUE)
head(threed)
#change the colnames
threed <- threed[c(2:8,11)]
colnames(threed) <- c("Player","X3PAr","DRtg","USG","MPG","DxRAPM","Team","CS3")

#looking at the whole league
p <- ggplot(threed, aes(x=DxRAPM, y=X3PAr))
p + geom_point(aes(size=CS3)) + theme(axis.text = element_text(colour = "black")) + xlab('Defensive xRAPM') + ylab('Three Point Rate') + ggtitle("Three and D Rate - All League") + opts(panel.background = theme_rect(fill='white', colour='black'))+ labs(size = "Catch and Shoot 3PT%") + scale_size(label = percent)


#adding some conditions
threed2 <- threed[threed$X3PAr > 0.2,]
threed3 <- threed2[threed2$DxRAPM > 0,]
q <- ggplot(threed2, aes(x=DxRAPM, y=X3PAr))
q + geom_point(aes(size=CS3)) + xlab('Defensive Rating') + ylab('Three Point Rate') + ggtitle("Three and D Rate - Higher 3PAr") + opts(panel.background = theme_rect(fill='white', colour='black'))

#looking at low usage defenders
threedusg <- threed3[threed3$USG < 20,]
u <- ggplot(threedusg, aes(x=DRtg, y=DxRAPM, label=threedusg$Player))
u <- u + geom_text(aes(size=threedusg$CS3,hjust=0,vjust=0)) + xlab('BBall Reference Defensive Rating') + ylab('Defensive xRAPM') + ggtitle("Best Defenders Among '3 and D' Players")
u + theme(axis.text = element_text(colour = "black")) + scale_x_continuous(limits=c(94,115)) + annotate("text", label = "best defenders", x = 96, y = 4.5, size = 4.5, colour = "red") + annotate("text", label = "closest to this corner", x = 96, y = 4.4, size = 4.5, colour = "red") + labs(size = "Catch and Shoot 3PT%") + scale_size(label = percent)

#flipping the concept
i <- ggplot(threedusg, aes(x=DxRAPM, y=X3PAr, label=threedusg$Player))
i <- i + geom_text(aes(size=threedusg$CS3,hjust=0,vjust=0)) + xlab('Defensive xRAPM') + ylab('Three Point Rate') + ggtitle("Examining the Best '3 and D' Players") + scale_x_continuous(limits=c(0,6)) + labs(size = "Catch and Shoot 3PT%") + scale_size(label = percent)
i + annotate("text", label = "most desirable area", x = 5, y = .75, size = 4.5, colour = "red") + annotate("text", label = "least desirable area", x = .5, y = .22, size = 4.5, colour = "red") + scale_y_continuous(labels=c("20","40%","60%","80%")) + theme(axis.text = element_text(colour = "black"))
```