---
layout: post
title: Stephen's Blog Post 3
description: Visualizing MSDN Forums Data
tags: blogpost
---

As mentioned during my project presentation, for the 3rd blog post, I chose to create an interactive d3/crossfilter visualization of the MSDN Forums data that I collected and explored for my project.

## My Visualization ##

Here are a couple screen shots of my visualization:

<img src="https://raw.githubusercontent.com/StephenKappel/dataology/master/MsdnForums/ForumExplorer/ForumExplorerSS1.PNG" width ="100%">

<img src="https://raw.githubusercontent.com/StephenKappel/dataology/master/MsdnForums/ForumExplorer/ForumExplorerSS2.PNG" width ="100%">

<img src="https://raw.githubusercontent.com/StephenKappel/dataology/master/MsdnForums/ForumExplorer/ForumExplorerSS3.PNG" width ="100%">

My work is saved to my GitHub repo [here](https://github.com/StephenKappel/dataology/tree/master/MsdnForums/ForumExplorer). To see the visualization in action, please fork my repo and launch ForumsExplorer.html locally. All the data/code is contained in ThreadsData.csv and ForumsExplorer.html. I should spend some time getting comfortable with bl.ocks.org and getting this posted there, but that is still on the to-do list.

## Bypassing dc.js ##

While it was tempting to go straight to a library like dc.js, which handles a lot of the tricky crossfilter charting stuff out-of-the-box, I decided to instead recreate the wheel. Why? I (a) wanted get a better understanding of how crossfilter works and (b) did not want to be confined to the feature set of dc.js or have to dig through somebody else's source code to make my customizations. So, using just plain vanilla d3.js and crossfilter.js, I put together a visualization that is dc.js-esque, but with some notable differences:

- My charts (all histograms) have two series: SharePoint and SQL Server. Behind the scenes, each of these is a separate crossfilter.
- My charts can dynamically change display type. That is, they can be toggled from stacked bar chart, to grouped bar chart, to top-and-bottom small multiple bar charts. This allows the viewer to decide which view makes the most sense for their viewing purpose. The stacked option is better for looking at aggregate totals of threads across SQL and SharePoint. The other options are better when comparing SQL to SharePoint.
- Instead of the drag-and-drop filter ranges that are seen with dc.js histograms, all the bars in my charts toggle independently. For example, a user can pick three non-sequential days of the week - such as Sunday, Tuesday, and Friday. Realizing that toggling more than a few bars can become tedious, I added in double-click and right-click shortcuts to make filter selection quick and easy.
- My x-axis labels can be either numeric or categorical. And, depending on the specific attribute being shown, the ticks will either appear in-between the bars (when the labels are upper and lower boundaries for the values shown in the bar) or at the bar's center (when the label represents a bucket wholly encompassed by the bar).
- My minimalist design preferences show through with no axes lines and no axes labels (as it should already be fairly obvious what each axis is showing).

## Room for Improvement ##

I'm pretty happy with the visualization, but there are certainly some things that could be better:

- The forums listed down the right side of the screen run off the side of the screen. I didn't want to cut off names and didn't have any more real estate. My temporary solution was to allow the name to exceed past what fits on a normal screen. If you want to see a full name, just scroll over... I think this could probably be handled more elegantly, but I need to figure out how.
- I want to allow the user to change the two series in the histograms from SharePoint/SQL to MSFT-engaged/MSFT-not-engaged.
- Instead of only showing counts on the y-axis of the histograms, it might be useful to toggle to another metric, such as success rate.

## Final Thoughts ##

My visualization makes it 100x faster and easier to explore my dataset than it would be using R. I sort of regret not doing this first as a tool to use in my data exploration. Then again, I wouldn't have had as much intuition around which fields to include in this visualization if I first hadn't gone through the exploration exercise in R.

In case you were wondering where my color selections come from, the color scheme is based on Microsoft's logo and the styling on MSDN Forums.

