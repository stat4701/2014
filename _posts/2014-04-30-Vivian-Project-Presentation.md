---
layout: post
title: Vivian - Project Presentation
description: Project Review
tags: project
---

# Project Overview

My goal for the project was to analyze housing and demographic data from the US Census in the San Francisco area. In recent years, SF housing has skyrocketed, averaging higher rental rates than New York City. As a result, low-income familes who have resided in SF for a long time are getting pushed out of the city. I was particularly interested in the Mission District, because the land value has appreciated rapidly, and the neighborhood is quickly losing its Latino + Hispanic flare.

## Data Collection

To collect the data, I searched the [US Census fact finder](http://factfinder2.census.gov/faces/nav/jsf/pages/searchresults.xhtml?refresh=t) for demographic and housing data on the Mission District - census tracts 208, 228.1, 228.2, 228.3, 209, 229.1, 229.2, and 229.3. The data were downloaded in 2 types of .csv files: One that coded the annotations, and one that contained all the data. I had to merge the annotations data to the meta data. 

Useful code, courtesy of Jared Lander's R for Everyone book:
``` {r chunkLabel}


theFiles <- dir(path="../2009-2012-RaceEthnicity/", pattern = "\\.csv")

for(a in theFiles)
{
  # build a good name to assign to the data
  nameToUse <- str_sub(string=a, start=5, end=26)
  # year <- str_sub(string=a, start=5, end=6)
  
  # read in the csv using read.table
  # file.path is a convenient way to specify a folder and file name
  temp <- read.table(file = file.path("../2009-2012-RaceEthnicity/", a), 
                     header = FALSE, 
                     sep = ",", 
                     stringsAsFactors=FALSE)
  
  # assign them into the workspace
  assign(x = nameToUse, value = temp)
  
  # assign metadata dataframe to dataframe
  search <- str_sub(string=nameToUse, start = 15, end = 22)
  if ( search == "metadata")
  {
    df.metadata <-  temp
  }
  
  # assign annotations dataframe to dataframe
  # transpose annotations df
  # merge metadata and transposed annotations
  if (search == "with_ann")
  {
    df.annotations <- temp
    df.annotations.transposed <- as.data.frame(t(df.annotations))
    names(df.annotations.transposed) <- c("key", "SFCounty","T208", "T209", "T228.01", "T228.02", "T228.03", "T229.01", 
                                          "T229.02", "T229.03")
    nameOfMerged <- str_sub(string=a, start=5, end=12)
    df.merged <- merge(x= df.metadata, y = df.annotations.transposed, by.x="V1", by.y="key", stringsAsFactors=FALSE)
    
    # assign them into the workspace
    assign(x = nameOfMerged, value = df.merged)
  }
}
```

## Exploratory Analysis

I couldn't think of anything clever to do for the housing and rental prices, that hasn't already been done before. [(Check out this awesome visualization on "Clusters of Affluence" in the Mission District)](http://www.visualizing.org/visualizations/clusters-affluence-san-francisco). So intead, I decided to look more into demographic data. There's been a lot of claims that the Hispanic and Latino community members are moving out of the Mission District. I wanted to see if the data actually supports that. I used R to parse out the data that I was interested in, and combine the data across all census tracts.

A small personal victory during this part, was successfully writing a for loop to change all columns into numerics. Previous to this, I was writing out each line and thought it was ridiculously inefficient.

``` {r chunkLabel}
for(i in c(2:ncol(Race2009))) {
  Race2009[,i] <- as.numeric(as.character(Race2009[,i]))
}
```

## Visualization
This was a mock-up of my hypothesis - created in AdobeIllustrator + Photoshop.
![Mock Up](https://24.media.tumblr.com/b57a3be2a7c1da55d3912caf58175bfb/tumblr_n30f4pomVj1qhy1dbo1_500.gif)


My next step was trying to replicate this in D3. My first attempt was to try a [circle-packing layout](http://bl.ocks.org/mbostock/7607535). Even though I cleaned my data in R, I was clueless how to structure the dataset to a readable JSON format. Since I had a small number of data points, I just hardcoded the data into JSON format for this visualization.

I started with the year 2009 to get familiar with the code. [Click here](http://vivianpeng.com/circlepack.html) for the visualization.

## Next Steps
I realize that this layout is kind of meaningless for demographic data. Circle packing is useful to see the hierarchy of your data. But since my data only has 2 levels in the hierarchy, it's not meaningful to visualize it in this format. Also, the human eye is really bad at recognizing area differences, so a bar graph would actually be more meaningful.

For the purposes of learning D3, I want to improve on this visualization by adding in the data points for the other years, and being able to filter according to the year. Ideally, I would also like to manually plot the census tracts so that they semi-reflect the geography of SF's mission district.

I'm curious if something like [this](http://bl.ocks.org/mbostock/1249681) would be more useful. Have each of the colors represent one ethnicity group, and instead of populating dots according to the mouse movement, find a way to populate the dots according to time. 


## 5-14-14 Update
Here is a link to my final visualization: [Click Here!](http://vivianpeng.com/circlepack_flatdynamic.html)

I was able to get the nodes to update dynamically from data in different JSON files. I also solved my issue of getting the year name from JSON. I had to use "root.name" to access the value for root nodes.

Here is a link to my final project repo: [Click Here!](https://github.com/veeps/MissionHousing/tree/master/FinalProject)


