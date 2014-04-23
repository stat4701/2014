---
layout: post
title: Jiun's INITIAL Blog Post 1 + 1
description: 1. Updating a chart from Data Visualization Gallery in US Census Bureau website
tags: blogpost 
2. Updating a table of GDELT Trend Report 
---

### Top Languages Other than English Spoken in 1980 and Changes in Relative Rank, 1990-2010
[Data Visualization Gallery in US Census Bureau](http://www.census.gov/dataviz/visualizations/045/)

## Reason I chose this graph ##
Too much information (different sizes of square, lines connected with them, different colors) on one graph for a simple descriptive topic - Top languages spoken other than English over three decades. So I was tempted to play with this data with much hope that I would make a more slef- explantory graph.

1. Data Collection and Munging
The website actually provides data table.[View Data Table](http://www.census.gov/dataviz/visualizations/045/508.php) I just read a table in R. 

2. Visualization

![Plot1](https://github.com/jiun0201/project/blob/master/EDAV/plot1.jpeg)


### GDELT Global Materal Conflict 48-Hour Trend Reprot 3/25/2014
GDELT is Global Database of Events, Langugage, and Tone Event Database. It produces daily reports reflect major trends in global Material Conflict over the last 48 hours compared with the preceding 48 hours. I worked with the report of 3/24/2014.[View the report](https://docs.google.com/viewer?a=v&pid=forums&srcid=MDc3NjUxNjA1Nzg5MTQ1MTA5NTEBMDExNzA1NjE5NzEzODkwODQ5NDYBQ2dxMHNiWVVnejRKATIBAXYy). As seen, the report consists of 1) top 10 emerging countries with detailed briefings and 2) Complete Country Ranking. 

## Complete Country Ranking table
The table of Country Ranking was particularly caught my eyes. Table could have been replaced definitely by one simple graph. so I tried.

1. Scrapping and cleaning data
Scap pdf data into CSV and read it into R.

2. Plot
I ploted based on Coverage Volume. According to the report, Coverage Rank column ranks country based on the total raw volume of articles, with 1 being the country with the most articles. While cleaning, I found several '0' as a rank which I think that it was because its respective Volume is '0'. 

![Plot1](https://github.com/jiun0201/project/blob/master/EDAV/Vol21.22.jpeg)
![Plot2](https://github.com/jiun0201/project/blob/master/EDAV/Vol23.24.jpeg)
![Plot3](https://github.com/jiun0201/project/blob/c929ee6a485ec046b6ec39f88b9683edf63bd681/EDAV/Volboth.jpeg)
![Plot4](https://github.com/jiun0201/project/blob/master/EDAV/VolC.jpeg)
![Plot5](https://github.com/jiun0201/project/blob/master/EDAV/MapVolC.jpeg)

I think Data could be visually more effective if use D3. I am learning D3 now and plan to do next blog post using D3.
