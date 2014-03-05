---
layout: post
title: Jed Makes NFL Combine Graphs
description: Bad Graph Takedown Number 1
tags: blog badGraph
---

I decided to see if I could create alternate versions of some interesting graphics
describing the skill sets tested at the NFL Combine, which happened last week.
Sports Illustrated's [Extra Mustard Blog](http://extramustard.si.com/2014/02/26/nfl-combine-40-yard-dash/)
shows a series of bar charts depicting a correlation between 40-yard-dash times and whether
players got drafted. Since nearly all players who go to the combine get drafted,
I thought a more interesting question was what effect the 40 time had on players' rank in
the draft. Then I started to wonder what other interesting data was out there about the
combine.

I started at [NFL Combine Results](http://nflcombineresults.com/). This fantastic resource
has lots of available information on every player who participated in every combine going back
to 1999. That's a lot of data.

I wanted to track whether players who participated in the combine ended up getting drafted, so
I needed a list of all the players who were drafted. [Wikipedia](http://en.wikipedia.org/wiki/2013_NFL_Draft)
came through in the clutch with embedded lists of every draft pick going back decades.

After some schlepping around with beautiful soup and removing a lot of asterisks and crosses
from the wikipedia data, I finally ended up with a workable data set of 788 players who had been drafted.
My data set contains the following information.

* Name
* Year
* College
* Position
* Height
* Weight
* Wonderlic (usually Null)
* Forty-yard
* Bench Press
* Vert Leap
* Broad Jump
* Shuttle
* 3 Cone Drill (Someone explain this to me)
* Round Drafted
* Rank Selected in Draft
* Pro Team
* College Conference

![Is there some kind of weird six-foot-tall stigma?](http://i.imgur.com/tr7vY5m.png)
![Sprint speed is only important for a subpopulation](http://i.imgur.com/plTPkhc.png)
![Fat Boys Can't Jump](http://i.imgur.com/cxJQj81.png)
![The SEC is Really Good](http://i.imgur.com/9EuDUgJ.png)
![Only the 7th Round had a significant correlation](http://i.imgur.com/7JzlUFv.png)

Another is a machine learning algorithm that would predict short stayers in foster care from a cohort
of children entering the foster care program.

Finally, I would be interested in extending ggplot in some way to be better at showing visualizations of
data that has both categorical input and output.

+ [Jed's Trello](https://trello.com/b/6QtAObI6/edav-project)
