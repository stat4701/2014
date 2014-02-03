---
layout: pres
title: prototyping sanely
description: and quickly
tags: slides
---
<section>
	<section>
# Graphs of the day	
</section>
	<section>
## This sport must be interesting
[![](http://i.imgur.com/WI818TU.png)](http://imgur.com/gallery/WI818TU)
</section>
	<section>
## LanguageLog
[![](http://languagelog.ldc.upenn.edu/myl/SOTU2014Compare.png)](http://languagelog.ldc.upenn.edu/nll/?p=10092)
</section>
	<section>
## Falling down
[![](http://www.npr.org/news/graphics/2013/10/pm-what-624.gif)](http://www.npr.org/blogs/money/2013/10/15/234881198/when-will-the-government-run-short-of-money)
</section>
	<section>
## Wealthy suburbs
[![](http://images.bwbx.io/cms/2014-01-28/cities3ch.png)](http://www.businessweek.com/articles/2014-01-29/where-americas-wealthiest-suburbanites-live-and-where-they-dont)		
</section>
</section>

<section>
	<section>
# Standup iteration 1
</section>
	<section>
# Assignment 0 redux

1. Fix the buggy `projects/popgraph/get-data.py` 
2. Rewrite the citydata scraper differently.
3. Plot the data using different tools.
4. Do some of the explorations we've talked about: highlighting the most-changed max and min ranking; focusing on the middle or lower ranks; looking at length of time of declines.
5. Plot the data using D3 or a D3 wrapper library.
6. Find geocoördinates for the place names and plot them on a map programmatically using google maps, leaflet, or cartodb.

</section>
	<section>
# Standup iteration 1
- Making a post? 
  - Who made things in their own repo/gh-pages but forking is confusing?
- Tools woes? (installation, &c.)
- Data woes? (resolved)

</section>
</section>

<section>
	<section>
# Prototyping quickly
</section>
	<section>
## Rmd

[For citydata graphs](https://github.com/malecki/edav/tree/gh-pages/projects/popgraph)
</section>
	<section>
## Rules of thumb

- do the x,y (location, width, height) mapping first
- then do subsequent ones (color, size, animation)

</section>
</section>

<section>
	<section>
# Where to go from here?
</section>
	<section>
## Option 1: Starting out

Get the source code house in order. Re-clone the repo and add upstream; or `git reset --hard`; and use the now abundant data in the tool of your choice.
</section>
	<section>
## Option 2: Keep up what you were doing

If you want to keep working with this data or find some more, keep working on an aspect of this assignment.

1. scraper
2. Plotting libraries
4. Transformations and exploring relationships within
5. D3/wrapper library
6. Map libraries

</section>
	<section>
## Option 3: Start on blogpost 1

Bored of the city ranking data? Work on blogpost 1. You'll have to get data and do all of the above for that.
</section>