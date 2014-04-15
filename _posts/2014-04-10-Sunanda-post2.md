---
layout: post
title: Blog Post 2 - Sunanda
description: My second blogpost : One less pie
tags: blogpost
---
## Motivation ##

I was motivated by the 'one less pie' initiative discussed in class and found [here](http://junkcharts.typepad.com/junk_charts/2014/03/pi-day-special-onelesspie-initiative-to-clean-up-wikipedia.html).

After looking around a bit, I found [this](http://en.wikipedia.org/wiki/File:Pie_chart_of_lung_cancers.svg) particular pie chart on incidence of lung cancer. 

Surely, anything other than a pie chart would look better than this?

##Critique##

Apart from the fact that Adenocarcinoma is the most prevelant and that Small-cell and Squamous-cell probably are equally likely to occur, there was not much to be gleaned from this graphic.

Showing the fraction of non-smokers/smokers as a fraction of the type of cancer was a bit confusing for me. 

## New Graphics ##

### R ggplot ###

I decided to go with the next best thing to a pie chart - bar chart - to plot this information. The data was simple and present in a table in a paper pointed to in the original graph. So I just manually scraped it into a dataframe and proceeded to manipulate it in R and plot a grouped bar chart.

The whole process can be found [here](http://rpubs.com/sunandakp/15807). This was published using a r-markdown file and the Rpubs option in RStudio.

#### Critique of the R plot ####

It seems slightly better(?) than the pie chart. We can see that Adenocarcinoma is the most prevelant type of cancer among non-smokers.

Splitting the non-smokers and smokers into separate bars makes it easy to read their percentages.

The varying scales for the non-smokers and smokers make it harder to read off hte exact numbers, especially for non-smokers.

### d3 plot ###

I wanted to create a d3 plot where I could interactively change the scale for the smokers and non-smokers. 

Here's a screenshot of the grouped bar chart I created:
<img src = "https://github.com/sunandakp/edav/blob/gh-pages/assets/Sunanda_assets/Lungcancer.png" width = "100%">

#### Critique of the d3 plot ####

Apart from an overall cleaner look, this graph isn't much different from the r-barplot.

But doing this exercise, for me, was more about breaking the ice with d3. I have a better handle on the rough structure a d3 code takes. It took me a while to go from a white screen to this simple bar plot. So pardon my enthusiasm :)

What follows was actually my original plan for the blogpost that never happened.
I am yet to implement the interactivity that brings out the true power of d3. Examples of things I want to do:

1. I debated for a while between grouped vs stacked bar chart for this data. So I want to do something like [this](http://bl.ocks.org/mbostock/3943967)

2. A tool tip that would pop out the percentage number if anyone wanted to know the exact percentage, like [so](http://bl.ocks.org/Caged/6476579)

3. A dual scale bar plot which will very simply solve the multi-scale problem for a small dataset like this one.
