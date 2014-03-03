---
layout: post
title: Stephen's Blog Post 1
description: Visualizing "What's It Worth" Data
tags: blogpost
---

For my visualization, I decided to improve the display of the partial results of Georgetown University's Center on Education and the Workforce's "What's It Worth" study. My started with the three html data tables posted [here](http://cew.georgetown.edu/whatsitworth/tables).

# Weaknesses of Original Design

These tables are labeled "interactive summary tables," but the extent of the interactivity is the ability of users to sort the tables by any column. I have the following objections to the original presentation of the data:

- The three tables contain related data, but are shown in three vertically stacked making comparisons between the datapoints difficult.
- Each major group is highlighted in a different color. There is no apparent methodology to the color-coding. Edward Tuft might argue that the highlighting is "chart junk."
- The tables contain 225 numbers. Without some graphical display, it is extremely difficult for the human brain to easily digest and interpret this many numbers. Further, this intimidating layout, likely intimidates viewers and discourages them from taking time to explore and understand the data.
- In an attempt to help users digest the data, the highest value in each column was bolded and the lowest value was italicized. I found the italicized values are difficult to spot at a glance.
- In the first table, which has columns for median, 25th percentile, and 75th percentile wages, the median column appears before the 25th percentile column. It seems a more natural flow would be 25th percentile -> median -> 75th percentile.
- All wage values are listed to the nearest thousand dollars, and yet the hundreds, tens, and ones places are shown. The result is 270 uninformative zeros being included in the tables, making the wage values more difficult to read.

# My Design Rationale

In my re-design of the data visualization, I have included all of the values included in the original three tables, with the exception of "Percent Obtaining Graduate Degree" and "Earnings Boost from Graduate Degree." These two data points are the only two which deal with graduate data, so they may be appropriately displayed in their own table or chart. In my visualization, I shrived to bring together the many values onto one surface, thus allowing for easy comparison and relationship discovery. 

Key elements of my design that address issues with the original design are:

- All of the data points pertaining to a single major group can be viewed at once.
- Graphical display of wages and popularity along continuous scales allows for quick comparisons between wages within a major group and between major groups.
- The colors used in the visualization are used to convey values.
- To not overwhelm the view, all the values are not shown at once, but a mouse hover over any major group reveals the full level of detail.
- Interactivity is used to encourage exploration and discovery.
- Unnecessary 0s are not shown on wage values.
- Sorting is animated rather than instant, to  allow the user to observe which major groups move the most/least when the sort criteria changes. 

# The Finished Product

My visualization is embedded below. Alternatively, the full page view on JsFiddle can be seen [here](http://jsfiddle.net/stephenkappel/bk854/embedded/result). The JavaScript on CSS files are posted to GitHub [here](https://github.com/StephenKappel/dataology/tree/master/WhatsItWorth).

<div align="left"><iframe width="1225" height="655" src="http://jsfiddle.net/stephenkappel/bk854/embedded/result" allowfullscreen="allowfullscreen" frameborder="0"></iframe></div>

# Observations

Here are some quick observations that I observed from my visualization (but would be harder to spot only looking at the original tables):

- There is a correlation between the median wages and gender composition of the majors. For instance, the top two majors by median wages - Engineering and Computers & Mathematics - are dominated by males, while the bottom two majors by median wages - Psychology & Social Work and Education - are dominated by females.
- Median wages are skewed closer to the lower quartile wages than to the upper quartile wages.
- The popularity of the Business major group dwarfs the popularity of all other major groups.
- Male median wages are always above the overall median wages, and female median wages are always below the overall median wages (except for in Health, where female median wages are equal to the overall median wages).

# Compatibility Troubles

I designed the visualization using IE 11 on a 3200 x 1800 monitor. In these conditions, the visualization fits comfortably in the browser, the fonts render appropriately, and the animation is smooth. However, as I've tested in other environments, I've found that it doesn't appear the same in all conditions. In particular:

- Only the top left corner of the visualization appears in FireFox. 
- Lucida Sans is not supported in iOS.
- Animations are choppy in iOS.
- The rendering does not appear as sharp in Chrome.
- The bottom of the visualization was getting cut off on lower resolution monitors, prompting me to decrease its height.