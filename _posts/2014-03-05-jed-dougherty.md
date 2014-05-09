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
from the wikipedia data, I finally ended up with a workable data set of 788 players who had been drafted
and participated in the NFL Combine between 2010 and 2013.
My data set contains the following information:

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

To start, I did some simple Exploratory analysis. I plotted weight versus height
for all players, and colored the points based on each player's position.
An interesting trend quickly emerged. For some reason no players want to list themselves
as six-foot. I am not sure why this would be, but there are only 5 players since 2010 who
have listed themselves as six feet tall. A very strange gap is clearly visible on the below graph.
Also visible are the clusterings of the various positions. Offensive linemen are massive and in the upper
right, while defensive backs are light and shorter, down in the bottom left. Quarterbacks are skinny,
but tall (because they have to see over their offensive linemen!). Linebackers consistently clustered
tighter together than other groups, no matter the metric.

![Is there some kind of weird six-foot-tall stigma?](http://i.imgur.com/98FxPBh.png)

After looking at the data of all the players together, I knew that they were so different that it only
made sense to look at correlations at specific positions, or at least skill strengths. To start, I split
the really fast guys off into their own group which i defined as "Speedsters".
Speedsters were defined as:

* Wide Recievers
* Tight Ends (I wavered about this group, but the new batch of hybrid gnarly TEs entering the league in the last few years pushed me into including them)
* Running Backs
* Corner Backs
* Free Safety
* Strong Safety

We can see how much more important speed is to these dudes than to the rest of the players based on this
density plot:

![Sprint speed is only important for a subpopulation](http://i.imgur.com/plTPkhc.png)

The next group I broke out was offensive linemen. These lumbering beasts are almost comically worse than
their sportier brethren at jumping and [running](http://prod.images.chargers.clubs.nflcdn.com/image-web/NFL/CDA/data/deployed/prod/CHARGERS/assets/images/imported/SD/photos/clubimages/2014/02-February/tempOL2014_06Swanson--nfl_mezz_1280_1024.jpg?width=960&height=720).
For example, as the graph below shows, their broad jump density function looks completely different from the rest of
the members of the combine. These big boys just can't jump.

![Fat Boys Can't Jump](http://i.imgur.com/cxJQj81.png)

While poking fun of the big folks on the offensive line is lots of fun, sometimes it is more interesting to
step back and take a larger view. All of these athletes had to finish a minimum of 2 years at a university
before they could become eligible for the NFL draft. These universities are broken into conferences, which
compete against eachother. Over the last decade the Southeastern Conference has maintained
an especially dominant reputation. I wanted to see if that dominance extended to getting players
drafted into the NFL. It really did. As you can see below, the SEC completely outclasses other
conferences at getting players drafted into the NFL. It has more first rounders drafted over the past
4 years than most other conferences have total. Perhaps unsurprisingly, SEC teams won the college
national championship in each of the four years that I collected my data.

![The SEC is Really Good](http://i.imgur.com/9EuDUgJ.png)

Exploratory analysis only goes so far. The Sports Illustrated column already showed that faster 40 yard dash times positively correlate with a higher probability of being drafted - especially for positions where speed is very important. I wanted to explore whether forty yard dash times correlate with a higher draft value, given that a player was drafted.

To analyse this effect I broke down players into their position types and then grouped the position types by their average skill in the forty. I then specifically focused on the fastest group of players: my earlier mentioned "Speedster" group.

For this group, forty yard dash times only strongly correlate with a higher draft rank when we isolate by round and position. Even then they only appear signifigant in the final round. In the seventh round, among players hanging on the periphery of entering the NFL or returning to lives watching the NFL like the rest of us, 40 times matter greatly.
Indeed, every tenth of a second decrease in 40 time correlated with jumping 5 ranks in the draft for speedsters
in the seventh round. This makes logical sense. The combine comes at the end of many years of playing football for all the players there. Most have been reviewed thoroughly enough by scouts and coaches that a single day of goofy excersizes will make no difference. But those on the edge have only the one chance to make a splash.

Here we can see the by-round breakdown of forty times v draft position for wide recievers, running backs, tight ends, cornerbacks and safties who were drafted between 2010 and 2013:

![Only the 7th Round had a significant correlation](http://i.imgur.com/7JzlUFv.png)

I leave those who made it this far with an awesome video of Marshawn Lynch explaining Beast Mode: [Beast Mode](http://www.nfl.com/videos/nfl-films-presents/09000d5d82217331/NFL-Films-Presents-Beast-mode)
