---
layout: post
title: Enkeboll - Assignment 0
description: Enkeboll - Assignment 0
tags: assignments
---

<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->

## Assignment 0: US Population Graphing

My progress on [this assignment](http://malecki.github.io/edav/2014/01/28/play-with-data/)

##### 1. Fix the buggy `projects/popgraph/get-data.py` (on the uspop branch) to retrieve `citydata.csv` for yourself
 - I fixed the problems with `get-data.py`.  There was some improper array indexing, and errors when looking for bs4 elements that weren't there.  These were cleaned up and the data pulled appropriately.
 - the complete, fixed code (and its output) are in /projects/enkeboll/popgraph_ae
    - `get-data.py`
    - `citypop_ae.csv`

##### 2. Rewrite the citydata scraper differently.
 - I rewrote the citydata scraper in R.  I also wrote a method to stored the original get-data.py information in json form. (a part of the same `get-data.py` file

```{r}
if (!require(XML)) install.packages('XML')
library(XML)

# Read in raw HTML
uspop <- "http://www.peakbagger.com/pbgeog/histmetropop.aspx"
# which picks the important tables, suppressWarnings prevents warning on
# 'NA' values from coersion, which will be dropped later
uspop.tables <- suppressWarnings(readHTMLTable(uspop, which = 5:33,
                colClasses = c("integer","character","numeric")))

nms <- c("Rank","Area","Population","Year")
# create empty master table to append smaller tables to
uspop.table <- data.frame()

# loop through each of the 29 tables and add them to master
for (t in uspop.tables) {
  # year is always in the first row, first column
  year <- as.vector(apply(t[1, ], 2, paste, collapse=''))
  year <- year[1]

  # remove rows 1 and 2 as they have header info
  t <- t[-(1:2), ]
  # add "year" column to keep track of the census year
  t[, "Year"] <- year

  # append this year's table to the master table
  uspop.table <- rbind(uspop.table, t)
}

# add columns to the master table
names(uspop.table) <- nms
# resets row numbers to incremental
row.names(uspop.table)<- NULL
```

 - file at `projects/enkeboll/popgraph_ae/get-data.R`


##### 3. Plot the data using matplotlib, or in R using base graphics, Lattice, ggplot2, ggvis, and shiny.
 - I recreated the graph as best I could, but I couldn't get the labels working appropriately.  The `directlabels` package was very helpful, but certain parts of it (like boxes and polygons) I coulndn't get to work because the lines didn't span the entire time period.
  - My code:
```r
if (!require(ggplot2)) install.packages('ggplot2')
library(ggplot2)

p <- ggplot(uspop.table, aes(x=Year, y=Rank, color=Area)) + geom_point() + geom_line(aes(group = Area))+ scale_y_reverse()
p <- p + theme(legend.position = "none")
p <- p + xlim(c(unique(uspop.table$Year),2020,2030,2040))

direct.label(p, "angled.endpoints")
```
<img src="http://i.imgur.com/AJ8Fasa.png" alt="R recreated population graph" width="900" />

##### 4. Do some of the explorations we've talked about: highlighting the most-changed max and min ranking; focusing on the middle or lower ranks; looking at length of time of declines.
 - I have not yet attempted this part, but will finish this week

##### 5. Plot the data using D3. Github pages (or Jekyll serving locally) should make it easy enough to read in the csv; though it is small enough you could parse it from a csv or json string within a script. Append a tooltip on mouseover of each line with the city name, year, and rank. Do an update with a transition, changing the y scale among various measures of interest.
 - I have not yet attempted this part, but will finish this week

##### 6. Find geocoördinates for the place names and plot them on a map programmatically using google maps, leaflet, or cartodb.
 - I have not yet attempted this part, but will finish this week