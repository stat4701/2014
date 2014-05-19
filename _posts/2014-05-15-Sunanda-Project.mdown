---
layout: post
title: Wrapping up the project
description: A post to direct to the various elements of the Project
tags: project
---
## Final visualization:

Did a combination of Bubble chart and bar chart on the same html page using d3. Was trying to use crossfilter to make the relevant bar charts appear when one clicks on the bubble corresponding to a school but there were some bugs that I couldn't fix. I am going to start from barebones javascript after this course to actually understand what's going on. Given our time-frame this is what I could come up with:

[Here](https://raw.githubusercontent.com/sunandakp/edav/gh-pages/assets/Sunanda_assets/bubble-bar.html)

##Problems in this code##

* I am ashamed to say that I manually changed the original csv output by my python script so as to make my data nested to fit into the code for multiple bar code part. The source for that is [here](http://bl.ocks.org/officeofjane/7315455)

* I originally rewrote that code to use my original csv and it didn't work. I clearly need more work on understanding d3's document binding. 

* I want a way to display d3 visualizations on the web on a personal or blog site (Not on bl.ocks is what I mean). Any suggestions? 

##Other stuff##

My code snippets in python for data-munging can be found at https://github.com/sunandakp/edav/tree/gh-pages/assets/Sunanda_assets/Code\ snippets. Definitely not the best code I have written in life ( Please don't look at the plotting part of the code which clearly should've been done using a for-loop). But it's what it is now :).

And I did do the analysis for the sharedreivews thing but it didn't give me more insight than what I already expected (MIT and Harvard dominated in terms of shared reviews) so didn't bother building a graph for it!
