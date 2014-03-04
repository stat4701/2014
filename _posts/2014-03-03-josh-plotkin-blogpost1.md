## Welcome to MarkdownPad 2 ##

**MarkdownPad** is a full-featured Markdown editor for Windows.

### Built exclusively for Markdown ###

Enjoy first-class Markdown support with easy access to  Markdown syntax and convenient keyboard shortcuts.
---
layout: post
title: Blog Post 1 - Josh (jsp2014)
description: blog post 1 on baseball financial data
tags: blogpost
---


##EDAVing Baseball Financial Data##

Last week, when doing my periodic perusing of fangraphs.com, I came across an article that was wildly different than what I'm used to reading on the site. Most posts on fangraphs drill into the advanced metrics that exist and try to accurately project and evaluate players. This article (which can be found [here](http://www.fangraphs.com/blogs/2014-payroll-allocation-by-position/)) focused more on team finances. The numbers intrigued me, but the only visuals on the page were the same unimaginative bar charts. The author acknowledged that she didn't even make them.

[![Wendy_graph](http://cdn.fangraphs.com/blogs/wp-content/uploads/2014/02/highestpaid2.png)](http://cdn.fangraphs.com/blogs/wp-content/uploads/2014/02/highestpaid2.png)


My initial plan was to use the author, Wendy Thurm's data, but I quickly realized that lots of other related data were available. My base table can be found [here](https://docs.google.com/file/d/0Bx-RPYT3zwKoeWdXa1JmbXliMU0/edit).

I aggregated the raw data from the following sources:

* Size of metropolitan area (http://en.wikipedia.org/wiki/User:Baseball_Bugs/population) 
* Attendance by year (http://espn.go.com/mlb/attendance/_/year/2013)
* Team wins by year (http://www.baseball-reference.com/leagues/MLB/)
* Team revenue, value, and operating profit (http://www.forbes.com/mlb-valuations/list/)
* Payroll by year (http://www.baseballprospectus.com/compensation/cots/)
* Player salaries by team by year (http://www.baseballprospectus.com/compensation/cots/)

Upon looking at and thinking about the data, I decided I would start with the bigger picture of aggregate team metrics, and then drill into player compensation, positions, and the type of analysis Wendy did in the original article. Due to the large amount of data I collected, and trying to explore the data as much as possible, I will save that analysis for my next blog post.

I admit it wasn't until this past week working on this post that I understood the meaning of "exploratory data analysis." I had all this data, and I started writing down questions in rapid-fire fashion. This isn't quite junkcharts since I've veered off into my own direction investigating relationships I find interesting. The first broad question that came to mind was "how strongly does a team's payroll correlate to its success on the field for that year?" I have several years worth of data so I wanted to plot them all together first. However, they need to be normalized, as MLB salaries have increased at a staggering rate relative to inflation:

[![01](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/01.jpeg?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/01.jpeg?raw=true)

[![02](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/02.jpeg?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/02.jpeg?raw=true)


I chose to calculate z-scores for each team's payroll for each season. That enabled me to adjust for the increasing cost of winning games, and get many data points on one plot to see the extent to which money buys wins. In addition, every time had over 50 wins during this time span, starting in 2004. Those 50 wins are essentially "free", so I like the idea of looking at wins over 50. First, the naive plot.

[![03](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/03.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/03.jpeg?raw=true)



Clearly, the line doesn't fit the data very well, and that's backed up by the 0.16 r^2. There seems to be very little trend among teams to the left end of the graph. One noticeable trend is that the biggest spenders are nearly guaranteed to be competitive. Of teams with 2 or more z-scores above the mean, there is only one team below 89 wins. Most teams would be very satisfied with 89 wins in a season. Let's drill down and see who these teams are.


[![04](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/04.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/04.jpeg?raw=true)

Unsurprisingly, the Yankees are all over the place. They've had the 11 highest payrolls by Z-scores, and the other season in this sample is there at #13 highest payroll. The new Dodgers ownership, with their massive television deal, are the only team keeping the Yankees from total domination of the payroll ranks. 

This is a good time to see which teams are in the most favorable situations, independent of their talent base. I collected data on metropolitan area size, revenue, attendance, and payroll. These are representative of a team's fan base, as well as its potential for growth. The metrics are converted to z-scores so they can share one scale. They are sorted left to right within the division by the sum of the z-scores.


[![12](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/12.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/12.jpeg?raw=true)


It's no surprise that the Yankees tower above the rest. Its bars are reminiscent of the NY skyline. The Dodgers stand out among the NL teams. The Mets have a tall bar, thanks to the NYC metropolitan population. They've had a rocky several years but that bar is hope on a screen. If the team can re-build the brand and put a good team on the field, the potential is there to be in the Red Sox and Angels territory. How about the divisions as a whole? We can use these same metrics, plus average wins over the last 5 years to get a sense for which divisions have the greatest resources.


[![13](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/13.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/13.jpeg?raw=true)

Thanks to the Yankees and Red Sox, the AL East stands significantly above the rest. This makes it even more incredible that the Rays have been so competitive recently (more on that later). Speaking of divisions, let's see which divisions are the strongest and weakest in recent years.


[![11b](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/11b.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/11b.jpeg?raw=true)


At first glance, it appears that there is significant fluctuation. It is essential to note that the Astros moved from the NL Central to the AL West in 2013. The Astros have been a disaster over this time period and so AL West's schedule has gotten easier and vice versa. Given the different schedules, it wouldn't be appropriate to calculate averages as if Houston was in the AL West all along.

Even factoring in Houston, this graph appears relatively unstable. The AL East is a powerhouse, the NL Central suddenly looks tough without Houston,  and the AL Central has never been above average. The other divisions have spent time both at the top and at the bottom.





Even the big-market, free-spending Yankees are not guaranteed to win over 90 games every single year. Let's see how different groups of spenders break down as far as their chances of winning certain amounts of games. 

[![05](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/05.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/05.jpeg?raw=true)

There is a much more obvious trend here. Teams with huge payrolls were 75% likely to be at least competitive. Conversely, teams with tiny payrolls only had an outside chance or better 25% of the time. What if we look at only data since 2008?

[![06](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/06.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/06.jpeg?raw=true)

It does appear that the ability to buy one's self into the playoffs has been diminished in recent years. This makes sense, as teams are building rosters more efficiently. Part of this is signing their young stars to team-friendly longterm deals. This means fewer legitimate superstars hit the open market, and if the Yankees et al want to spend big, they're going to have to do it on merely very good players, often on the wrong side of 30 years old.

This now begs an important question: who are these successful teams with smaller budgets? The obvious answer to any baseball fan is the A's and Rays, but who else is there? Let's start with an exploratory scatter plot of the teams who have had <-1.00 Z-scores in payroll since 2006.

[![07](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/07.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/07.jpeg?raw=true)

Teams with payrolls under -1.00 z-scores have only won more games than they've lost 5 times in the past 8 years. Interestingly, each of those has been right at 90 wins or more. The Rays and A's will undoubtedly make up most of the 5 over 90 wins, but let's see if there's anyone else in there.

[![08](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/08.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/08.png?raw=true)


The only mild surprise is that the Rays and A's weren't responsible for all 5 teams. The 2011 Diamondbacks had a very Rays/A's-esque year in '11. In 2012... not so much.

Let's drill deeper into the payroll vs. wins relationship. Which teams are best and worst at making the most of their dollars? The 2003 Tigers were responsible for the worst season since 2000, with 43 wins. Let's look at the cost of winning games beyond the first 43. For the same reason as before, we can't just divide wins over payroll since that will introduce time bias due to the increasing cost per win over time. The metric I'll use here is (Wins - 43)/(Payroll / League Average Payroll for Current Year). I'd prefer to use z-scores than this ratio of team payroll to average payroll, but negative z-scores would mess it up. Let's call it WPND for Wins per Normalized Dollar.

Let's introduce another dimension as well. Let's break teams down by the size of their metropolitan area, and pick out the best and worst WPND for each group. 

[![09](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/09.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/09.jpeg?raw=true)

Once again, the Rays and A's dominate the good part of the graph, which is the high end of the graph and the big dots that correspond to WPND. Of the big market teams, the White Sox had a couple of seasons getting a good bang for their buck, but tanked in 2013. The Cubs are just sad, as we'll see soon.

We know the Rays and A's are great at maximizing their meager budgets, but how do they stack up against the Yankees and Red Sox in terms of winning games? 

[![10](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/10.jpeg?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/10.jpeg?raw=true)

The big market Yankees and Red Sox have won an extra 5 games per season and made the playoffs a combined 1 extra time. There are a couple of other big-market, high-revenue teams that haven't had any success in recent years. Those are the lowly Cubs and my beloved sad sack Mets.

[![11](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/11.jpeg?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/11.jpeg?raw=true)

Let's recap what we've seen so far. One of the most clear takeaways is that while money doesn't always buy many wins, it significantly minimizes the chances of a terrible season. This makes sense, as baseball is a game with a high degree of uncertainty. Nothing is guaranteed. On a larger scale, a team's best player can get hurt. On a smaller scale, a ball can clear the fence for a homerun by inches to make the difference between a win or a loss. Here is a video I saw recently that has the many purposes of (1) illustrate this very point, (2) the incredible direction MLB is going in terms of data collection, and (3) show a heartbreaking Mets loss.


<iframe title="YouTube video player" width="800" height="800" src="http://m.mlb.com/video/topic/6479266/v31405521" frameborder="0" >< /iframe>

Next time: for my next blog post, I'd like to explore the fans more. Do wins bring people to the stadium? MLB revenues are way up, thanks to large television deals, but are more fans coming to the stadium as well? How much of the revenue comes from attendance? Which teams are most profitable? How are MLB payrolls allocated? Are pitchers or hitters taking up a larger percentage of payrolls than in the past? Which teams' payrolls are made up of the most high paid players? Which teams have the most dead weight? 
Other goals include finding inspiration for an animated d3 graph based on the data I've worked with so far (for post 3), and a foray into maps.

Here is a teaser graph for next post, showing that MLB attendance is not doing great.
[![14](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/14.png?raw=true)](https://github.com/joshplotkin/edav/blob/gh-pages/assets/jsp2014/14.jpeg?raw=true)




