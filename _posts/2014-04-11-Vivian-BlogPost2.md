---
layout: post
title: Vivian's Blog Post 2
description: Remake of vaccine preventable outbreaks visualization
tags: blogpost
---

This blog post is a sequel to my Blog Post 1. In the first blog post, I scraped the data from CFR vaccination outbreaks, and merged it with CDC data in R. I did some exploratory graphs with ggplot 2.

For this blog, I attempted to learn some D3 and recreate some of the R graphs in D3, adding some interaction.

Here is a graph of the Whooping Cough outbreaks from the first blogpost:
![CDC Whooping Cough Cases](http://2.bp.blogspot.com/-xAugfawYQ8k/UzEPb7jt9FI/AAAAAAAABGk/LAFvlfH-Sww/s1600/Pert+graph.png)

Here is a screenshot of the graph recreated in D3. 
![D3](https://github.com/veeps/edav/assets/CDC_cases_d3.png)

When you hover over the graph at certain years, it shows important events that happened that year. This shows how certain events, like the documentary of the vaccine causing neural damage, may have swayed public opinion. 

To see it live, you can download the .html file and .csv file: [here](https://github.com/veeps/VAX/blob/master/barchart.html)


I also attempted to recreate this graph as a stacked barchart:
![CFRvCDC Cases](https://github.com/veeps/VAX/blob/master/CDCvsCFR_WCcases_nonLogscale.png?raw=true)

Here's a screenshot of the graph in D3
![D3 Stacked Chart](https://github.com/veeps/edav/assets/Veeps_StackedChart_D3.png)

It's not perfect. I'm still trying to figure out how to get my x axis to reflect the years, and not the index. Also, I'm learning how to do transitions, so that you can switch the view betwene grouped data and stacked data.

Code for the stacked graph can be found: [here](https://github.com/veeps/VAX/blob/master/stackedchart.html)