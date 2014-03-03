---
layout: post
title: Blog Post 1 - Barbara
description: this is my first blogpost exploring jobs data from the Bureau of Labor Statistics
tags: blogpost
---
## Inspiration Graphic ##

I found the below graphic which claims to show every job in America "in one graph". 

[![graph1](http://bwelsh.github.io/edav/assets/alljobs.gif)](http://bwelsh.github.io/edav/assets/alljobs.gif)

[Source](http://npr.org/news/graphics/2014/01/alljobs.gif)

It was posted [here](http://www.scpr.org/news/2014/01/10/41514/every-job-in-america-in-one-graph/). As they indicate, they took the non-farm payroll data and created the treemap shown in their post. While I did like the look of it, a few things about its utility bothered me.

1. The graphic was too big to see enough of it on the screen. I found myself scrolling up and down a lot to try and look at it. If I made it smaller, I found I couldn't read the individual industries.
2. Some boxes were empty, and others had a name in them, but no value. Also, there are categories overlaid on other categories, all of which made it difficult to read and understand.
3. As they mention, this does not show change over time, it is only a static picture.

My goal with this post was to come up with a graphic that would address those concerns.

## New (Hopefully Improved) Graphic ##

[New Jobs Graphic](http://bwelsh.github.io/edav/assets/d3jobs.html)

I only tested this using Chrome. From a quick look, it seems to work in Firefox as well, but not in IE. I'm not sure about Safari.

## Process ##

###Gathering Data###

I started by going to the Bureau of Labor Statistics site linked to in the original post. I found the table that seemed to be used, Table B1, located [here](http://www.bls.gov/news.release/empsit.t17.htm). I looked around the site for a better way to get the data then scraping the table. I found a Public Data API [here](http://www.bls.gov/developers/) and poking around a little at it, I believe this would be the best way to get the data. I also found [this page](http://data.bls.gov/cgi-bin/dsrv?ce) that allowed me to pull the data I was looking for through their widget and output in csv format. I chose this method as it required a lesser upfront time investment. Given more time, I would love to play with the API. I also needed two additional tables that linked the series code in the data gathered from the widget to the job types and sectors. I found those [here](http://download.bls.gov/pub/time.series/ce/ce.industry) and [here](http://download.bls.gov/pub/time.series/ce/ce.supersector). 

I then wrote a small python script to ingest this information, link to the appropriate industries and sectors, and then output the subset of the data needed into json format, which would be used in the d3 graphic I was creating. The subsetting was necessary because the data output was hierarchical, there was an overall total, then a total for each sector, then a total for each subsector, etc. By manually inspecting the original chart, I was able to figure out how to get only the data at the level I was looking for, although as always, there were a few exceptions that had to be handled. All of the files used, including my python script are located in my assets directory:

-[Python script](http://github.com/bwelsh/edav/blob/gh-pages/assets/blog_post_1_data_munge.py)
-[Python output](http://github.com/bwelsh/edav/blob/gh-pages/assets/jobs_json_array.txt)
-[2013 data](http://github.com/bwelsh/edav/blob/gh-pages/assets/jobdata2013.csv)
-[2009 data](http://github.com/bwelsh/edav/blob/gh-pages/assets/jobdata2009.csv)
-[2005 data](http://github.com/bwelsh/edav/blob/gh-pages/assets/jobdata2005.csv)
-[2001 data](http://github.com/bwelsh/edav/blob/gh-pages/assets/jobdata2001.csv)
-[1997 data](http://github.com/bwelsh/edav/blob/gh-pages/assets/jobdata1997.csv)
-[1993 data](http://github.com/bwelsh/edav/blob/gh-pages/assets/jobdata1993.csv)
-[Category table](http://github.com/bwelsh/edav/blob/gh-pages/assets/categories.txt)
-[Sector table](http://github.com/bwelsh/edav/blob/gh-pages/assets/sector.txt)
-[Groups table](http://github.com/bwelsh/edav/blob/gh-pages/assets/groups.txt)

Separately, using fake data I had created, I started working on the d3 graphic. My idea was rather than a treemap, to try and use a horizontal stacked bar to show the number of jobs in each industry. I started with Mike Bostock's [example](http://bl.ocks.org/mbostock/3943967) of a stacked bar chart, then combined elements of the horzontal chart [here](http://tributary.io/inlet/4966973) to get the basic layout (along with a lot of googling as issues came up). I figured I could then create one for each year, to allow for comparisons over time. I knew I couldn't get all of the industry names and jobs numbers on the screen, so I decided a tooltip on hover might be the best way to show that. [This site](http://www.d3noob.org/2013/01/adding-tooltips-to-d3js-graph.html), again along with some googling, provided me the information for the tooltip.

I wanted to be able to see the data both in absolute terms as well as in normalized terms (as a percentage of the whole), so I repurposed the radio buttons to show the data in absolute vs normalized form, rather than stacked vs grouped bars. After doing this, I saw in the documentation that there was a pre-defined way in d3 to do this, so that would be an opportunity for refactoring. I also wanted to be able to see the same job type across multiple years, so along with the tooltip that shows up on hover, added a feature that highlights the job type across all years, to aid in comparisons.

I used [colorbrewer2](http://colorbrewer2.com) to pick color ranges that were somewhat similar to what was used on the original graph, then used d3 functions to interpolate between those ranges and choose colors for the subsectors.

Lastly, I created a group of the sector and subsector svg text elements to put on the left side. I then added functionality to be able to see categories and subcategories in more detail. Clicking on one of the categories on the left changes the graphic to filter by the selected element.

After I got the look and feel that I was looking for, I copied and pasted the actual data from the output of my python script. I tried several date ranges before deciding to go back 20 years at four year increments. Going back farther was problematic because there starts to be missing data, making the comparisons across years impossible. Once the data was in, I had just a few final adjustments to make on the size of the svg elements.

There are still several things more I could and would liked to have done with the data, including, but not limited to:

1. Having a "drill-down", starting at a top level, and then allowing the user to keep seeing the same data at more and more granular levels.

2. Allowing the user to better visualize the information for a single job type over time, perhaps in a line graph.

3. The data is available monthly, so perhaps allow users to see months instead of just years.

4. Allowing the user to change the years/date range shown.

Every time I look at it, there are more things I see that I could improve, but I guess that's just the nature of visualizations!
