---
layout: post
title: Gabi - Blog Post 1
description: The decline of the name 'Mary'
tags: blogpost
---

### Main Source of Data:
For my visualization I decided to try and work with the SSA files containing baby names [here](http://www.ssa.gov/oact/babynames/limits.html)
and improve the charts found [here](http://familyinequality.wordpress.com/2013/05/11/mary-free-fall-continues/)

### Thoughts on the original:

I found the two charts interesting and had a few questions:

* Would it make a difference if we counted the variations in the name spelling?
* How does the decline of the name Mary compare with that of Maria?
* How do Maria and Mary compare with the top 2 names?
* I can't quite figure out or understand why the rank of the y-axis goes from 140 to 0 for Mary and from 180 to 0 for Maria.

### Getting the data and some roadblocks:

Gathering the data was pretty straightforward - all I had to do was download and unzip. I noticed there were a lot of files to 
read, but loading them and creating data.frames wasn't much of a problem. I started having issues in manipulating the data as
I wanted to perform a function on more than one data.frame at a time. I am using R and was trying to familiarize myself with 
functions such as lapply and sapply but was not very successful and will continue to work on this. As an example,
the downloaded text files don't have a column for the year and I wanted to add this information for each data.frame based on the 
file name (since this was the only place to find the year number). It seems like it should be something pretty straightforward and 
easy to do, but I am still not sure how to do this recursively (assuming there is a way). So, I decided to focus only on files from
1990 to 2012 since that seemed more manageable.

Once I set out to work with a smaller dataset, I was able to add years to each file and start looking at some of the trends in
names. I looked for different variations of spellings in Mary and Maria and did not find that these add much value to the total
count of occurrences in the names Mary and Maria [here](https://github.com/Gabya06/datascience/blob/master/MariaDecline/assets/otherMarianames.png). 
I also looked at boys with names like Maria in case these were just incorrectly labelled as boys instead of girls but 
these also did not increase the count by much [here](https://github.com/Gabya06/datascience/blob/master/MariaDecline/assets/otherMariaboys.png). 
Side by side, Maria and Mary both seemed to have steep declines in popularity, matching the original charts[here](https://github.com/Gabya06/datascience/blob/master/MariaDecline/assets/sidebysideMaryMaria.png).

I found that the girl names with the most counts between 1990 and 2012 are Emily and Ashley. 
Plotting them [here](https://github.com/Gabya06/datascience/blob/master/MariaDecline/assets/top2names.png) shows that these names have been 
more popular for some time and are not increasing but rather decreasing. My next step was to compare the trends
for Emily and Ashley with those of Mary and Maria to see if the decline of Maria is really as steep as the original makes it seem.

Looking at the graphs side by side shows that the decline of the names Mary or Maria is not as steep as it looks in the original
and that these names have been trending below 10,000 counts since 1990 whereas both Emily and Ashley were above 20,000 counts. 

### My improved (junk) chart
* I made cleared that the trends for Maria and Mary are not declining as steep as in the original
* The chart is no longer representing ranks, but rather name counts
* Added clear comparison with the top 2 names showing that Maria and Mary were not that popular to begin with
[![top2Maria](https://github.com/Gabya06/datascience/blob/master/MariaDecline/assets/top2Maria.png)](https://github.com/Gabya06/datascience/blob/master/MariaDecline/assets/top2Maria.png)

### Next steps
* Use entire data set and see how the trends compare