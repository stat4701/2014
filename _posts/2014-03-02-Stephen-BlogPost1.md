---
layout: post
title: Stephen's Blog Post 1
description: Visualizing "What's It Worth" Data
tags: blogpost
---

For my visualization, I decided to improve the display of the results from Georgetown University's Center on Education and the Workforce's "What's It Worth" study. In particular, I focused on the partial result set included in the three tables posted [here](http://cew.georgetown.edu/whatsitworth/tables).

## Weaknesses of Original Design

The data set contained in the original tables is one that I think might be of interest to a great deal of the general population. The data is not highly technical or specialized, so it should be easily consumed by a general audience. Unfortunately, the tables are not very user-friendly. Some of the shortcoming in the tables include:

- The three tables contain data for the same major groups. Yet, the tables are stacked vertically, making comparisons between all data points for a single major group difficult.
- The page's title described the tables as being "interactive summary tables," but the only interactive feature of the tables is the ability for users to sort the data by any column. 
- Each major group is highlighted in a different color. There is no apparent methodology to the color-coding. Edward Tuft might argue that the highlighting is "chart junk."
- The tables contain 225 numeric data points. Without some graphical display, it is extremely difficult for the human brain to easily digest and interpret these numbers quickly. I conjecture that this number-heavy display discourages viewers from taking time to explore and understand the data.
- In an attempt to help users digest the data, the highest value in each column was bolded and the lowest value was italicized. I found the italicized values to be difficult to spot at a glance.
- In the first table, which has columns for median, 25th percentile, and 75th percentile wages, the median column appears before the 25th percentile column. It seems a more natural flow would be 25th percentile -> median -> 75th percentile.
- All wage values are listed to the nearest thousand dollars, and yet the hundreds, tens, and ones places are shown. The result is 270 uninformative, anti-readability '0' characters being included in the tables.

## My Design Rationale

In my re-design of the data visualization, I have included all of the data points included in the original three tables, with the exception of "Percent Obtaining Graduate Degree" and "Earnings Boost from Graduate Degree" columns. These two columns are the only two which describe those with graduate degrees, so they may be appropriately displayed in their own table or chart to avoid confusion. In my visualization, I shrived to bring together all the data onto one surface, thus allowing for easy comparison and relationship discovery. 

Key elements of my design include:

- All of the data points pertaining to a single major group can be viewed at once.
- Graphical display of wages and popularity along continuous scales allows for quick comparisons between wages within a major group and between major groups.
- The colors in the visualization are not merely decorative; they are used to convey values.
- All the numeric values are available, so the user can get the same level of precision as provided by the tables. However, to avoid overloading the view and intimidating the viewer, not all the numeric values are not shown at once. All the major groups are plotted, but the underlying numbers are only displayed when triggered by a mouseover event.
- Interactivity is used to encourage exploration and discovery.
- Unnecessary '0's are not shown on wage values.
- Sorting is animated rather than instant, to  allow the user to observe which major groups move the most/least when the sort criteria changes. 

## The Finished Product

My visualization is embedded below. Alternatively, the full-page view on JsFiddle.net can be seen [here](http://jsfiddle.net/stephenkappel/bk854/embedded/result). The JavaScript and CSS files are posted to GitHub [here](https://github.com/StephenKappel/dataology/tree/master/WhatsItWorth).

<div align="left"><iframe src="http://jsfiddle.net/stephenkappel/bk854/embedded/result" allowfullscreen="allowfullscreen" frameborder="0" width="1230" height="675"></iframe></div>

## Observations

Here are some quick observations gleaned from my visualization. While the same insights could be gained from the tables, much more effort would have to be exerted.

- There is a correlation between the median wages and gender composition of the major groups. For instance, the top two major groups by median wages (Engineering and Computers & Mathematics) are dominated by males, while the bottom two majors by median wages (Psychology & Social Work and Education) are dominated by females.
- Median wages are skewed closer to the 25th percentile wages than to the 75th percentile wages.
- The popularity of the Business major group dwarfs the popularity of all other major groups. It is approximately as popular as the seven smaller groups combined.)
- Male median wages are always above the overall median wages, and female median wages are always below the overall median wages (with the lone exception of the Health major group, where female median wages are equal to the overall median wages).

## Browser Compatibility

In building this D3 visualization, I that it is important to design with all major browsers in mind, and to remember that not everyone's screen is the same size as your own.

I designed the visualization using IE 11 on a 3200 x 1800 monitor. In these conditions, the visualization fit comfortably in the browser, the fonts rendered appropriately, and the animation was smooth. However, after completion, I tested in other environments and found that not everything worked as well as it did in my initial setup. Here are some of the issues I came across:

- Only the top left corner of the visualization appeared in FireFox. It turns out that FireFox has a small default size for svg elements and does not dynamically scale them based on their contents. While not having width and height attributes set on the svg element was find in other browser, I had to explicitly set these attributes for FireFox.
- The bottom of the visualization was getting cut off on lower resolution monitors, prompting me to decrease the height of my design.
- Lucida Sans, which I use for the vast majority of the text on my visualization, is not supported in iOS. In the future, I will look into something like Google Font, which will allow a single font to work on all browser. Plus, Google Fonts provides options for fonts that are more interesting than the usual "web safe" font set.
- Vertical text (for the y-axis) label is support (or not supported) differently in every browser. In IE, I could get the text to rotate 90 degrees. In Chrome and Safari, I could get the text to be vertically oriented. In Safari, the spacing between the letters is large, so the last letter in the label doesn't fit in the svg element. In FireFox, I could not get the text to go anyway but horizontal, so currently there is no y-axis label when viewed in FireFox.
- Animations are choppy in iOS. Unfortunately, I think this one is just a fact of life.
- The rendering does not appear as sharp in Chrome as is does in IE. Lesson: don't rely on high resolution in your visualization design.
