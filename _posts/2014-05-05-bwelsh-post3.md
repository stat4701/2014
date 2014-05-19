---
layout: post
title: Blog Post 3 - Barbara
description: this is my third blogpost, exploring baby name data
tags: blogpost
---
## Graphic Idea ##

For this post I decided to explore the baby name data. I had two ideas I wanted to explore:

1. That the popularity of names would shift geographically over time.
2. That some names changed over time from being more popular for one gender to the other (generally from a boy's name to a girl's name).

## Graphic ##

[Baby Name Graphic](http://bwelsh.github.io/edav/assets/d3babynames.html)

## Process ##

###Gathering Data###

I started with the baby name data by state that we saw in class, located [here](http://www.ssa.gov/OACT/babynames/limits.html). 

Thankfully the data was very clean. One note on the data though - it only includes name for which there were at leat 5 occurences in a given year. As the purpose of this graphic is to show trends over time, low density names are not valuable, so I don't think this is an issue.

###Initial Analysis###

I first wrote a few R functions, posted [here](http://github.com/bwelsh/edav/blob/gh-pages/assets/calcpopTotals.R), in order to explore the data and see if it would be worth creating a graphic for. Running this code requires the state files be in a subfolder of the directory with the R file in it titled 'namesbystate'. I didn't include them here due to their size. The code produces plots which give the popularity over time by state for a given name. The individual state lines are not discernable, but my main goal here was to just see the basic trends for various names. As an example, sourcing the file and running this line produces the below plot, showing the changes from male to female in the popularity of the name 'Sandy' over time. 

    source("calcpopTotals.R")
    plotName("both", "Sandy")

<a href="http://bwelsh.github.io/edav/assets/gender_balance_sandy.png"><img src="http://bwelsh.github.io/edav/assets/gender_balance_sandy.png" alt="Sandy Gender Balance" width="310" height="160"></a>

Similarly, running this line produces the below plot, showing the changes in popularity of the name Lauren for girls over time.

    source("calcpopTotals.R")
    plotName("F", "Lauren")

<a href="http://bwelsh.github.io/edav/assets/popularity_lauren.png"><img src="http://bwelsh.github.io/edav/assets/popularity_lauren.png" alt="Lauren Popularity" width="310" height="160"></a>

I decided there was enough interesting data to create a graphic at this point, but the way I had implemented the function in R made it very slow to get the data and produce the plots (I was calculating totals each time and running through each of the state files). Since I recognized that I would again want a multi-dimensional object, and that I would need to re-implement the functions anyway to make them faster and to produce smaller output, I decided to organize the data for the d3 plot using python.

My python script to munge the data and produce the output for d3 is located [here](http://github.com/bwelsh/edav/blob/gh-pages/assets/baby_name_munge_2.py). Like the R code, running this code requires the state files be in a subfolder of the directory with the python file in it titled 'namesbystate'. Realistically, I knew that including every name wouldn't be feasible (I did a quick calculation to determine there were over 12,000 boys names and 16,000 girls names in the files). I tested including only the most popular 1000 names for boys and girls. As the script prints out, this encompasses over 96% of the boys names and 91% of the girls names in the files. It still produced a file over 60Mb, which was a bit larger than I wanted, and the graphic is a little slow to load sometimes, but this is what I went with in the end. One could easily reduce the number of names the script outputs, re-run it, and use that file for the graphic in order to speed it up. The python file outputs an object with three sub-objects, an array of all of the names, an object with the counts by name and gender for each state, and an object with total counts by gender for each state by year.

###Creating the Graphic###

I started the graphic by creating the map, using [this](http://codepen.io/browniefed/pen/goDsG) as a template. I then added the radio buttons at the top to change the mode of the graph, using code from my first blog post. This allows the user to switch from the gender balance to the overall popularity view. I chose colors for each type of graph and used the hclInterpolater to create a scale for each one.

In order to display the correct data when the name is selected, I'm using the d3.json function to read in the data, select only the data for the name chosen, and bind it to the path elements. Because of the size of the data, I didn't want to bind all of it, but rather re-bind based on the name selected. It is a little slow to load when the name changes.

To show the changes in the name popularity over time, I found [this slider](http://bl.ocks.org/mbostock/6452972) that I was able to adapt and automate, so that when a name is selected, the graphic shows the changes over time. You can also manually change the slider to see a particular time. It would be nice to add a feature to allow the user to go to a particular year, as that is not easy to do with the current implementation. The slider is also jittery sometimes, I haven't been able to figure out what causes that. I'm using the event of the slider moving to trigger an update of the graph data/colors, and using the transition capability to match the timing of the slider moving and the colors changing. I'm also using the d3-tip library to show the percentages and counts for each name for each state on hover.

I wanted the user to be able to choose a name to view, so I initially started out with dropdowns (when I only had a few names I was testing with), but didn't like that user experience, especially when there are a lot of names. What I wanted was a box that would allow the user to type in a name, but offer suggestions for the available names. I found a library [here](http://complete-ly.appspot.com) that did what I wanted, after a bit of configuration. 

Lastly, I wanted to add a legend at the bottom, to give the colors a little context. I used the svg gradient to do that, based on [this example](http://bl.ocks.org/mbostock/1086421). There is some brittle code here that would benefit from refactoring.

###Discussion###

There are obviously a lot of names to explore, and many of them are not very interesting. Examples of some of the names that I did find interesting are below:

-  For the gender balance mode, Sandy, Casey, Kim, Dana and Lynn all provide an interesting map. For example, with Casey we can see that it is first seen as a boy's name in the south and upper midwest. Then in the 1970s becomes more popular as a boy's name and by the mid 1970s, starts to turn more towards a girl's name, first in the east. It remains popular into the 2000s, with it being more popular as a girl's name in the east and more popular as a boy's name in the west. By 2010, it's popularity has declined somewhat, but is still in use both as a boy's and girl's name.

-  For the overall popularity (boy) mode, Todd, Michael, Joseph, and Adam are all interesting. Todd, for instance, become more popular in the 1960s, and for some reason, is relatively more popular in the upper midwest. By the mid 1980s, it's popularity is waning again.

-  For the overall popularity (girl) mode, Jessica, Mary, Lauren, and Susan are all interesting. Looking at Jessica, we see that the popularity really starts to increase in the 1970s, first in the north, then spreading south in the late 1980s, and once again losing popularity in the late 1990s and 2000s.

###Improvements###
There are three main improvements I would like to make with this:

1. There is a wide range in the percentages of names (and therefore the colors). For names that are less popular, this causes the graph to not show the changes well, as all of the colors end up being very light. I wanted the scale to be the same for all names, though, for context. I'm not sure what to do about this, but would like to address it somehow.

2. I would like to add the ability to stop the animation and/or select a year manually.

3. Two features here are buggy - the name code, which if you type the name and hit enter too fast seems to not load the map, and the slider code, which gets jittery sometimes. I would like to fix those issues, although again, I'm not quite sure how, short of re-implementing them with other libraries/code.

