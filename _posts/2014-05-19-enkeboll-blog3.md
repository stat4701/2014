---
layout: post
title: Blog Post 3
description: Male vs. Female Wage Gap v2
tags: blogpost, blogpost3
---

<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->

(Continued from [Blogpost 2](http://malecki.github.io/edav/2014/05/13/enkeboll-blog2/)) I wanted to show, a little clearer, the data I found at http://www.nwlc.org/sites/default/files/pdfs/nov2013_state_by_state_women_overall.pdf.  

This revised attempt is interactive, and shows information about the wage gap subset by different standards of living state by state.  The idea here was to highglight the discrepancy, but also show how that impacts a woman's day to day life in any given state.

### Initial View
![Initial View](https://raw.githubusercontent.com/enkeboll/edav/gh-pages/projects/enkeboll/blog2/initial.png)

Changed from the original view, I removed the overlays on each state so that the map is cleaner (espeically in the Northeast).  There's a scale in the top left corner, and the right side shows a reverse-sorted bar graph visually comparing states to the selected metric.  There's also a selection box at the bottom of the screen that allows you to choose between the different metrics.

### Mouseovers
![On Mouseover](https://raw.githubusercontent.com/enkeboll/edav/gh-pages/projects/enkeboll/blog2/mouseover.png)

On mouseover, the state brigtens and shows the state's abbreviation.

### Standard of Living Subsets
![New Subest of Information](https://raw.githubusercontent.com/enkeboll/edav/gh-pages/projects/enkeboll/blog2/new_subset.png)

The drop-down menu at the bottom will update the colors on the map as well as the sorted bar graph on the right side.  The bars do not enter/exit but instead update their Y position and their width to adjust for the updated subselection.

### Clicking In
![Clicked](https://raw.githubusercontent.com/enkeboll/edav/gh-pages/projects/enkeboll/blog2/clicked.png)

You are now able to click in to each state, showing all of the calculated "Purchasing Power"s for each category. Clicking on the same state or outside of the US will zoom back out; clicking another state will focus on that state.

### Problems
In running the demo, you'll notice several problems:
+ If you try to change the category after clicking in/out of a state, it will throw an error
+ Once you start changing categories, the "mouseOver" text and focus is off (eg. your mouse will be on Texas but Michigan might be highlighted, and clicking Texas will show information about Michigan)
+ Range is off on the bar graph, not allowing for small enough values on certain categories

### To Do
+ Category explanations
+ Fix problems
+ Link mouseOver between states and bar graph
+ Similarly, allow you to click into a state's bar graph
+ Add labels to bar graph
+ Highlight selected value on the "clicked in" screen

### To run
```
cd /projects/enkeboll/blog2
> python -m SimpleHTTPServer 8888
```

In your browser, visit `localhost:8888` to view the map interactively.
