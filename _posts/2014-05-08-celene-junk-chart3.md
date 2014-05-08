---
layout: post
title: Celene - Junk chart, part 3
description:
tags: blog
---
<section>
	<section>
### Goals
For my final junk chart blogpost, my main goal was to get more D3 practice and portray the data in a variety of different ways. In particular, I wanted to filter the data across different dimensions, practice different types of graphing, show trends, and make more refined visual tweaks than the default settings provided.


### What I did
During my project work I came across the dc.js and crossfilter libraries, both of which use d3.js. They are excellent for graphing and manipulating data, respectively, but dc.js particularly leaves one to desire more functionality in the graph parameters. Regardless, these tools saved me a lot of time and made a somewhat pleasing visualization, especially because of the transition effects from the filter-on-click feature of dc.js.<br/>
To get the most practice I sliced the data in all the ways I could think of that were meaningful, and used a variety of visualizations:<br/><br/>

* row chart of the number of matches by surface<br/>
* row chart of number of championships won by each player<br/>
* row chart and trend lines that show a 'score' summary overall, and over time<br/>
* stacked bar charts of number of Grand Slams played and won<br/>
* pie plots of number of Grand Slam championships by surface<br/>
* I also added filter buttons to the original grid visualization, so it's easier to look at a single player across all the years and slams <br/><br/>

Note that the 'score' is an unweighted sum of the rounds achieved, where the round codes are 1 for first round and 8 for champion (and 0 if the tournament wasn't played).<br/>

### Road blocks
I came across a number of road blocks and things I wanted to dig into deeper, if I had the time:<br/><br/>

* I really wanted to have the filter from dc.js graphs apply to the original chart viz I made, but it seems the .on("click") attribute for graphs doesn't work as expected (same code works for buttons). As a result, I made the visualizations separate, since there wasn't much gained besides clutter keeping them together <br/>
* The colors on the line chart were not obviously manipulatable, nor on the stacked bar charts. For the former, I adjusted the row chart colors to match <br/>
* Personally I think the default colors are ugly, and that's a little frustrating to have it stuck on those <br/>
* It took a long time to figure out how to control spacing, and I'm still not sure what the best approach is; I ended up using CSS to add margins <br/><br/>

I noticed that there are a number of features on the master branch version of the dc.js library that seemed useful, but I didn't end up playing around with them much because updating my local copy of the library had the immediate effect of messing up my coloring (all my row charts turned black). <br/><br/>

### Next steps
For my next steps, I'd like to work on each of the roadblocks, particularly the first issue. If I figure out how to do that it will be very broadly useful and make the dc.js library more widely applicale.<br/>
It would be a dream if I could have some real tennis data to work with, but from asking around (including people that work with private tennis data), it is not going to become public anytime soon. Such a shame!<br/><br/>

### Reflection
Overall, I'm really happy with what I've achieved with this simple data set. I think it was a good proof-of-concept exercise to show what one can do with d3.js, and of course everything is scalable for a larger set. I felt frustrated at many points because of the difficulty in finding answers to specific questions I had about d3.js and dc.js. However, I understand this is because the field is so new and still developing, which just means that there is plenty of space to make an impact (such as submitting pull requests). I'm looking forward to diving deeper into the source code and making some contributions, as well as doing more side (or work-related) visualization projects.



</section>
</section>
