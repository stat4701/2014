---
layout: page
title: Iteration Plan
tagline: update
---
#[Bryan Kaufman](http://about.me/bkaufman)  

## NBA Draft Strategy and Analysis ##

Since the start of my first sprint, I’ve done a pivot after scraping data from [Basketball Reference](http://www.basketball-reference.com/).  I originally wanted to focus on play-by-play basketball data, but, recently, after attending a sports analytics conference, I realized that examining front office strategy in regards to the NBA Draft would be more useful and interesting.  The format of my input data would be a csv from basketball reference with the data mungling done in python and/or R.  I would also love to learn and develop skills in d3.  My goal is to ultimately provide visuals to examine the strategy for NBA teams in terms of the draft process.

##First Sprint:##

My first sprint involves collecting all necessary data from basketball reference (link) for the analysis and having it in .csv form.  I first wanted to do a visual to look at the historical records of teams to look visually if there was any advantage of ‘tanking’.  Tanking is essentially losing on purpose in order to get a high draft pick.  In the most simplistic way to think about it, a team is either competing for a championship or they are not; some feel strongly that this is the best way to approach managing a team that can’t compete for a championship.

##Summary of goals##

- Scrape team historical data from basketball reference

- Data mungling within python (some teams have changed names)

- Find the most effective visualization(s) to examine if there is an advantage to tanking

##Progress##

I have all team's historical performance and am mostly done with the data mungling.  Some parts have been tricky as I'm trying to create a function to rank performance in percentiles.  I've created some effective visualizations, but the one I want to create the most can only be created after I figure out the percentile rank.

##Second Sprint##

The second sprint is mainly about visualizing performance and draft position.  Another goal of mine is to gain some experience using d3.  I currently have 0 experience using d3.

Summary of goals

- Scrape performance data from basketball reference and other sites (try creating a web scraper)

- Gain experience using d3 to create the visualization

- Show clearly where performance can be found in the draft and what teams have drafted well

 

##Third Sprint##

The final step for me would be to examine the salary of players to find the value of draft picks.  Where is the sweet spot in the NBA draft?  This can be shown with visuals using ggplot.  I intend to try to use ggplot both in python and R.   I also, if I have time, would like to try to create a web scraper to scrape the college stats of draft picks