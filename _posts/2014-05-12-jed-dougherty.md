---
layout: post
title: Movie Budget and Expense Data
description: Movie Data
tags: blog movies d3
---

I really enjoy the movies, as do many other people... shocker. Anyways I wanted to recreate
the feel of some of ![This guy's really cool](http://boxofficequant.com/)
charts, except make them interactive.

After all what is the fun of looking at a chart about movies if you can't see what movie it is.

I followed his lead and scraped numbers from this site:
![The Numbers](http://www.the-numbers.com/)

I also pulled actor, writer, director, and genre information off of some euro pseudo-anonymous imdb api,
which seemed only mildly sketchy and which I will not link here, but is very easily
found through a bit of google-fu.

Anyways after playing with the data for a bit I settled on showing the interaction between budget and earnings ratio:
worldwide earnings divided by production budget. I used all movies available since 1970, and did not normalize for 
inflation since I figured the ratio was more important anyways. You can see the interactive d3 visualization and my
code for it here:
![Earnings Ratio V. Budget](http://bl.ocks.org/jedDoughertyCC/raw/933a6c0983aeb8f19c5b/)

Pretty much my favorite thing about this graph is that Deep Throat has by far the highest ratio of any move released since
1970. Also Mars Needs Moms was an unmitigate disaster. A note about the chart: I decided to put the y axis in log form, 
since most movies cluster around 1 or 2, but some end up reaching into the hundreds. Thats all for now folks.
