---
layout: post
title: Stephen's Blog Post 1
description: Visualizing "What's It Worth" Data
tags: blogpost
---

For my visualization, I decided to improve the display of the partial results of Georgetown University's Center on Education and the Workforce's "What's It Worth" study. My started with the three html data tables posted [here](http://cew.georgetown.edu/whatsitworth/tables).

These tables are labeled "interactive summary tables," but the extent of the interactivity is the ability of users to sort the tables by any column. I have the following objections to the original presentation of the data:

- The three tables contain related data, but are shown in three vertically stacked making comparisons between the datapoints difficult.
- Each major group is highlighted in a different color. There is no apparent methodology to the color-coding. Edward Tuft might argue that the highlighting is "chart junk."
- The tables contain 225 numbers. Without some graphical display, it is extremely difficult for the human brain to easily digest and interpret this many numbers. Further, this intimidating layout, likely intimidates viewers and discourages them from taking time to explore and understand the data.
- In an attempt to help users digest the data, the highest value in each column was bolded and the lowest value was italicized. I found the italicized values are difficult to spot at a glance.
- In the first table, which has columns for median, 25th percentile, and 75th percentile wages, the median column appears before the 25th percentile column. It seems a more natural flow would be 25th percentile -> median -> 75th percentile.
- All wage values are listed to the nearest thousand dollars, and yet the hundreds, tens, and ones places are shown. The result is 270 uninformative zeros being included in the tables, making the wage values more difficult to read.

In my re-design of the data visualization, I have include all of the values included in the original three tables, with the exception of "Percent Obtaining Graduate Degree" and "Earnings Boost from Graduate Degree." These two data points are the only two which deal with graduate data, so they may be appropriately displayed in their own table or chart. In my visualization, I shrived to bring together the many values onto one surface, thus allowing for easy comparison and relationship discovery. 



<iframe width="1225" height="665" src="http://jsfiddle.net/stephenkappel/bk854/embedded/result" allowfullscreen="allowfullscreen" frameborder="0"></iframe>