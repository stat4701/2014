---
layout: post
title: Blog post #1: GDP with Political Influence
description: 
tags: blogpost1, dtjones
---

#Original chart

I googled 'bad charts' and searched for a few examples before I came across [this excel chart of GDP over time organized by president](http://www.coyoteblog.com/coyote_blog/2013/12/explaining-the-flaw-in-kevin-drums-and-apparently-science-magazines-climate-chart.html] . I decided to re-do this chart because it isn't accurate/complete, its not pretty , its very simple, and the data is readily available. Lots of room for improvement. 
[bad chart](http://www.coyoteblog.com/wp-content/uploads/2013/12/bad-chart-example-500x340.gif)
The chart shows GDP growth with respect to the previous year averaged over the president's tenure. The author of the blog post states that Obama has one observation in 2009. 

#Data

GDP data is available publicly [here](http://www.bea.gov/iTable/iTable.cfm?ReqID=9&step=1#reqid=9&step=1&isuri=1) . I downloaded the data in csv format and appended two date ranges together in excel. Separately, I found president's political affiliation and term tenure [here](http://www.infoplease.com/encyclopedia/history/presidents-united-states-table.html) . Embarrassingly, I created a year-to-president lookup table in excel to append president and political afflication to the GDP growth rate time series.  

The good thing is that I have a larger time window than the original chart, and I also have more granularity by including the year and specific GDP growth, as well as the political party of the president. 

#Chart

I took a first stab at the visualization by plotting yearly GDP by time through ggplot2 as a simple line. Immediately you can see that there are peaks and valleys associated with economic events, notably the economic crisis of 2008. To add some insight into whether the fiscal decisions of republicans or democrats positively influence GDP growth, named the political party field as a color of the line. A color legend does not automatically populate with the method I used, so I had to annotate a text legend. Also, I tried to add president names via geom_text, but this added a label to every data point - very cluttered. I annotated and colored each presedent name manually. 

[GDPPlot](https://www.dropbox.com/s/tkk4gy9amepv632/GDPPlot.jpeg)

#Improvement
For blog post 2 I hope to do something similar in d3 but with floating detail boxes upon hover. I could perhaps add average growth rates of each president or political part as reference lines. 

<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->