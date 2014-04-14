---
layout: post
title: Blog Post 2 - Barbara
description: this is my second blogpost, exploring obesity data from the CDC
tags: blogpost
---
## Inspiration Graphic ##

For this post I initially went on a search for a pie chart that I could improve upon, and during the search, found [this article](http://www.theatlantic.com/magazine/archive/2014/04/why-rich-women-dont-get-fat/358643). Their fourth graph is a pie chart and my plan was to try and improve upon that, but I settled on improving the third graph instead, comparing obesity by income. Here were my main issues:

1. They are comparing obesity by income, but don't define their income scale at all, simply labeling it "richer" and "poorer". 
2. I thought the scales they provided and layout of the graph made it very difficult to compare men vs. women, which was their stated purpose for creating the graph in the first place.
3. Once I took a look at the raw data, I realized that they seemed to remove certain data that didn't quite fit their narrative (given the lack of numbers, it was impossible to tell what they did for sure). It also seemed to mask a more interesting trend.

My goal with this post was to come up with a graphic that would address those concerns and show the pattern that I saw when I explored the data.

## New (Hopefully Improved) Graphics ##

-  [New Obesity Graphic](http://bwelsh.github.io/edav/assets/d3obesity.html)
-  [Parallel Sets Version](http://bwelsh.github.io/edav/assets/d3obesity_parsets.html)

## Process ##

###Gathering Data###

I started by going to the CDC site to get the raw data, as indicated by the article. After poking around a bit, I found the pdf report that appeared to be the source of their graph, located [here](http://www.cdc.gov/nchs/data/databriefs/db50.pdf). 

I realized that I only needed 36 numbers from the pdf (from figures 1 and 2 of the pdf), so I just manually put the data in the appropriate form for d3. What I noticed when I was gathering this data, was that the initial article seemed to leave out an entire income class (the middle one) in their graph. This is problematic because the overall pattern described, that women become thinner as their income rises and men become heavier, doesn't hold for all sexes and ethnicities. 

###Creating the Graphics###

I started by finding a way to visualize this multi-level categorical data. I found [this site](http://www.jasondavies.com/parallel-sets), which offered two interesting ways to view the data. The first is the parallel sets chart displayed on the page, and the other is the [mosaic chart](http://www.theusrus.de/blog/understanding-mosaic-plots) linked to in the "Alternatives" section at the bottom of the page. I decided to start with the mosaic plot, and used this [marimekko chart](http://bl.ocks.org/mbostock/1005090) as my template.

I built the normalized version (on the left) first, found the colors through the [color picker](http://tristen.ca/hcl-picker), and added the legend in the middle. I had to play with the template a little, as I was actually creating six of those charts. I also needed to mess with the axis ticks a bit and add axis labels to get the look I was going for. To me, the most interesting thing about this view of the data is that the pattern described in the initial article is very dependent on ethnicity. It holds much better for the non-hispanic black population then for the non-hispanic white population. In addition, for the Mexican-American population, we do see the opposite relationship between income and obseity for men and women, but it only seems to take effect for the highest income levels.

I then wanted to visualize obesity in absolute terms, so created the graph on the right. I struggled a bit with whether this graphic was useful or just confusing, because the bars are all different widths and so it's difficult to compare them. Also, creating the axis labels turned out to be trouble. The most interesting thing I found here, which was completely missing from the initial article, is that even among women, who have higher obesity rates at lower incomes, many more obese individuals are mid or high income, and not at the lowest income levels. 

Since I wasn't happy with the second mosaic plot, I decided to try and use the parallel sets code to create one of those graphs, as it seemed like a potentially clearer way of visualizing the data in absolute terms. I struggled with it a bit (I couldn't get anything to show up on the page at all, then found [this site](http://www.theage.com.au/national/parsets)) and was able to figure out what I needed to do from there in order to get it to work. I created [this csv](http://bwelsh.github.io/edav/assets/obesity.csv) to hold the raw data. I then used the same color picker listed above to change the colors of the paths and played with the formatting of the tooltip a little so the numbers were formatted without 15 decimal places after them. Since the parsets library was already written, once I figured out how to get it to work at all, it was very easy and just a little code to get quite a lot of functionality.

One thing I really like about this visualization is that by changing the order of the dimensions, you can see the data broken out different ways. To explore it, I was manually changing the code at first to see all of the different breakdowns, then decided it would be much better if there was a way on the front end to do this. This turned out to be the most time consuming part of this visualization. 

Drag and drop seemed like the most user-friendly way to go, so I looked around for anything implemented already. I found [this](http://jsfiddle.net/xnjGD/6/), which got me started, but then I had to figure out how to reorder the menu items with each move. I created the menu items in a separate svg and then I used the dropHandler provided to implement that functionality. So now if you drag an item above or below other items it will reorder the graph and reset the positions of the moved menu items. 

If you reorder so that income is the first level and weight is the second, I feel like you can really see the point made above, that when looking in absolute terms, many more obese individuals are at mid or high income levels, something that is not readily apparent from looking at the percentages alone. I'm sure there is much more to be explored in this data, and would love to hear other insights!
