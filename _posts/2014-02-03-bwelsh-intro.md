---
layout: post
title: Introduction and first post
description: this is my introductory post and first attempt at exploring the population data
tags: post
---
## Introduction - Barbara Welsh ##

I work at a small IT consulting firm and am taking classes through the IDSE program part-time. While I don't currently deal with much large-scale data in my job, I am hoping to in the future. My background is in math, but over the years I have picked up some light programming, and expect to pick up even more through this program. 

## Assignment 0 ##

For this assignment, I chose to focus on the raw population numbers, rather than the city ranks, when looking at the historical top 20 metro area data. I read the data into R (both the city and total population data) and used the ggplot2 package in order to create the below graphs. This first graph shows the percentage of population that lived in one of the top 20 cities over the years.

[![graph1](http://bwelsh.github.io/edav/assets/PercentPopofTotal.png)](http://bwelsh.github.io/edav/assets/PercentPopofTotal.png)

The percentage of the population living in one of the top 20 metro areas has steadily increased over the last 200 years, with the exception of a decline between 1930 and 1940, coinciding with the Great Depression.


This second graph breaks down the percentage of population by region. The region specifications came from the US Census Bureau [here](http://www.census.gov/geo/maps-data/maps/pdfs/reference/us_regdiv.pdf). I took each city and associated the appropriate region with it, then totaled up the population in each decade according to which region the city was located in.

[![graph2](http://bwelsh.github.io/edav/assets/PercentPopRegion.png)](http://bwelsh.github.io/edav/assets/PercentPopRegion.png)

By comparing this graph to the one above it, we can see that the decline in population living in the top 20 metro areas from 1930 to 1940 actually only occurred in the Northeast and Midwest, while the population in the Western cities stayed stable and the population in the Southern cities actually increased slightly during that decade. 

## Next Steps ##

I would like to see if I could reproduce this, or something like this, using D3.
