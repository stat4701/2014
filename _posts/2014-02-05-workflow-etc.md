---
layout: pres
title: workflow and projects
description: continuation from 2014-02-03
tags: slides
---
<section>
![Train schedule is not]({{ site.baseurl }}/assets/train-schedule-is-not.jpg)
</section>
<section>
	<section>
# Graphs of the day (Mon)
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
# Graphs of the day (Wed)
</section>
	<section>
## Sigh

[![](http://m.chronicle.com/img/photos/biz/05-Delta-Cost-daily.gif)](http://m.chronicle.com/article/Administrator-Hiring-Drove-28-/144519/)
</section>
	<section>
## Split it up
[![](http://graphics8.nytimes.com//images/2013/05/25/sunday-review/wide-thumb.png)](http://www.nytimes.com/interactive/2013/05/25/sunday-review/corporate-taxes.html?ref=sunday&_r=0)

Very pretty source. Inline.
</section>
	<section>
## Several views
[![treemap](http://graphics8.nytimes.com//images/2011/02/14/us/politics/graphic-190.jpg)](http://www.nytimes.com/packages/html/newsgraphics/2011/0119-budget/)
[![packed circles](http://datavisualization.ch/wp-content/uploads/2012/02/four_ways_02-710x409.png)](http://www.nytimes.com/interactive/2012/02/13/us/politics/2013-budget-proposal-graphic.html?_r=0)
</section>
	<section>
[![]({{ site.baseurl}}/assets/incomeladder.png)](http://www.nytimes.com/2013/07/22/business/in-climbing-income-ladder-location-matters.html?_r=0)

[Less pretty source](http://graphics8.nytimes.com/newsgraphics/2013/07/02/inequality/assets/charts.min.js?01) | [JSBeautifier](http://jsbeautifier.org)
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
</section>


<section>
	<section>
# Some project workflow
</section>
	<section>
## Suggestion 1, for R

- Make a package. Use the vignette (Rmd or Rnw) as a notebook.

- Let knitr run (and cache) results as you go

- Stash data as RData in `pkg/data/` or as anything else in `pkg/inst/`

</section>
	<section>
## Suggestion 1, continued

- begin your vignette with codechunks calling functions you haven't written yet: 

```
Acquire data from [some place.](link)
<<delimiters>>{r setup, eval=TRUE}
library(mypacakge)
<<delimiters>>
<<delimiters>>{r get-data, eval=FALSE}
getData()
<<delimiters>>
```

- Then write functions in the package to fulfill that promise.
- As you go, you can switch the *eval* arg, if you acquire data and stash it somewhere for example; or load saved runs of models.
</section>	
	<section>

## Suggestion 2, also for R

### (but not necessarily)

@johnmyleswhite's [ProjectTemplate](http://projecttemplate.net)
</section>
	<section>
## Suggestion 3: General
- Make a repo
- Start with a list of what to do
- Open issues?
- Invite collaborators
</section>
	<section>

## Suggestion 4: Trello

[![](https://d2k1ftgv7pobq7.cloudfront.net/images/bd87ee916375920ae72dffadbb10d412/logo-blue-lg.png)](https://trello.com)
</section>
</section>
