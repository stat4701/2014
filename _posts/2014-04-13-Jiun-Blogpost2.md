---
layout: post
title: Jiun - Learning d3.js by doing!
description:
tags: blog, d3, R
---

* Tools used: d3, R
* Theme: Visualizing Time-series data

## World's Top Five Countries by CO2 emissions ##

### 1. Graph Critiques: ###

[Here](http://blogs.shell.com/climatechange/category/copenhagen/page/2/) is the website that I found the below chart of 'Global Emission CO2 to 2050' that tempted me to work on for my second blogpost. 

<a href="http://blogs.shell.com/climatechange/wp-content/uploads/2010/01/Global-Emissions-Case-2.jpg"><img src="http://blogs.shell.com/climatechange/wp-content/uploads/2010/01/Global-Emissions-Case-2.jpg" alt="Global-Emissions-Case" width="500" height="400"></a>

For one, this was visually hideous that gained my attention. (It did its job attrating people that way!) For two, it failed to be informative as too many values of different categories were stacked on each other. It's hard to see what's going on at first glance. While learning d3.js through this semester, I have seen beautiful and informative d3.js stacked charts. I wanted to give it a try and thoguht the area chart was a good place to start D3.

### 2. Data source: ###

Instead of original data, I wanted to see something more intriguing. So I came up with an idea of looking into top major 5 countries emitting CO2 the most. Data was derived from [here](http://tonto.eia.doe.gov/cfapps/ipdbproject/IEDIndex3.cfm?tid=90&pid=44&aid=8). 

### 3. First attempt: Stacked area charts with click and drag option

I ploted the data in R to explore data. I noticed that China and USA have values in a wider range. Instead of stacking, I thought of plotting multiple time-series with the same axes like [this](http://bl.ocks.org/mbostock/1157787). However, placing multiple series in the same scope may reduce legibility of series with relatively smaller values. An alternative approach is to use different scales for each series: showing each series in its own chart. This could mislead people's perception and interpretation of each chart though. For remedy, I found 'click and drag to zoom' feature in d3!! D3 is GREAT! 

Here is my first visualization embedded below. The d3.js code and data can be seen [here](http://bl.ocks.org/jiun0201/d98c874281f02fdd086e). 

<div align="left"><iframe src="http://bl.ocks.org/jiun0201/raw/d98c874281f02fdd086e/" allowfullscreen="allowfullscreen" frameborder="0" width="1000" height="550"></iframe></div>

I liked the 'click and drage to zoom' option for zooming in to look for certain period. Adding mouse-over could provide information about Y-axis values for each year. 

### 4. Initial challenges & thoughts:
* Javascript was like a foreign language to me; interesting but hard to grasp! 
* Setting up d3 on local server was a long and confusing process. Loading external data in d3 wasn't simple after all. 
* Getting around with 'dates', especially parsing dates in d3 were painful. 
* Selecting color scheme is FUN! 

### 5. Second attempt: Stream graph with mouseover option

[Stream graph](http://bl.ocks.org/mbostock/4060954) is alternative for mulitple level time-series data. Also I wanted to try mouseover option. Followed is my visualization with same data. The d3.js code and data can be seen [here](http://bl.ocks.org/jiun0201/e914be44df65640f8533). 

<div align="left"><iframe src="http://bl.ocks.org/jiun0201/e914be44df65640f8533/" allowfullscreen="allowfullscreen" frameborder="0" width="1000" height="550"></iframe></div>

I am happy how it turned out and glad I gave a second shot. While working on these, I found [nvd3](http://nvd3.org/) which provides reusable charts and components. The codes are simpler than d3.js and generate great visualizations. I might try it for my third blogpost.

### D3 learning materials:
Prolific materals about d3 are available online but that made me confused about where to start. Just like learning Github and Git! So I thought I would refer some materials that helped me landed in d3 world!!

1) [Scott Murray website](http://alignedleft.com/tutorials/d3/) and his tutorial definitely helped. <br>
2) [D3 tips and Tricks](http://thedata.co/sites/thedata.co/files/u1/D3-Tips-and-Tricks_Book_v4.pdf) is my favorite as it walks you through more thoroughly. <br>
3) Youtube video of [D3 Vienno](https://www.youtube.com/user/d3vienno) covers diverse examples. <br>
4) [Dashing D3.js](https://www.dashingd3js.com/) is a well-organized website. <br>
5) Stackoverflow is a great learning platform. It is my best friend!



