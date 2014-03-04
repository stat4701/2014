---
layout: post
title: MTG Draft Format Analysis
description: "A breakdown of winning cards in the current Magic: the Gathering limited draft format"
tags: blog
---
## MTG Draft Format Analysis

### Data

The card data I used for this came from www.mtggoldfish.com [here](http://www.mtggoldfish.com/limited/cards/draft/bng_ths_ths).  Mtggoldfish's information comes from the massively popular Magic: the Gathering Online game, which generates tons of data on a daily basis.  However the table at the linked page I found do be less than useful for a few reasons:

* There are simply too many cards on the list.  Yes, I can sort it how I like, but that doesn't give me any information on the general playing field that every magic player enters upon going to FNM (friday night magic)
* The key metric here, "Win Percentage" tells us the proportion of games that are won in which the given card is played.  At first this sounds like an excellent metric, except that it doesn't take into account all the times that a given card could be in a player's hand and actually cause them to lose the game (because they were unable to use it for some reason).
* I cannot sort it by cost.
* Many magic cards are harder to play than other cards, but have exceptionally more sway on the game once they are used.  Since the metric only takes into account the games in which the card is played, we need a way to balance out the bias away from harder to play cards.

### The solution

Rather than change the metric that mtggoldfish uses, I attempted to balance out that metric so that cards are grouped into classes that roughly separate them by how difficult it is to use them.  So I split the cards of the format into 8 different classes based on "converted mana cost" (CMC), which is a convenient measure of difficulty to use in Magic.

Another way to possibly discern difficulty of use is by rarity.  Each magic card has a certain level of rarity (literally how rare they are), the classes are as follows in order: common, uncommon, rare and mythic.  In general rarer cards have more powerful effects.

### First Attempt

The data was easily copied and pasted from the mtggoldfish website into a spreadsheet and then manipulated and saved into csv format once I had an idea what to create.  My first thought was to do a simple bar graph, splitting up the win percentage averages by CMC and rarity.  I was quickly able to output the following chart in excel:

![Win Percentage of Cards played by CMC and rarity](https://drive.google.com/file/d/0B3TAlfBGXsAdTE9vemlmcmhhUGs/edit?usp=sharing)

However I realized afterward that this was not at all what I was interested in showing, because this treats all cards of a given rarity and CMC as the same and any good magic player knows that that simply is not the case.  A representation of the given distribution among each class was necessary.

### A Second, More Serious Attempt

I needed to find a way to visualize what was missing in the excel barchart: distribution among the classes of CMC.  In my opinion the best possible way to display such data is through a good old-fashioned box-and-whisker plot (or several, as the case may be).

I will admit to being stonewalled for a long time by the finer points of coding in d3.js.  Creating an actual visualization was beyond me until I found an example posted online by Matthew Bostock [here](http://bl.ocks.org/mbostock/4061502) which allowed me to finally create a working visualization of what I needed.

This is clearly still a work-in-progress, but here are the distributions of Win Percentage by CMC from 1 to 8 going from left to right:

![Draft cards win percent distribution by CMC](https://drive.google.com/file/d/0B3TAlfBGXsAdbkZPSXRURnVld2c/edit?usp=sharing)

Needless-to-say this taught me a lot about visualizing in d3, but I still need to figure a few things out.  I do not believe that adding axes to this chart would make much of a difference, but I would like to figure out how to create just a single gridline to go across at 50% for instance.  I would also like to implement some interactivity into this, even if all it does is highlight whatever the mouse hovers over.

### Onward and upward

While the above boxplot is simple and sweet, I do believe that it requires a few finishing touches.  There is still plenty more about working with d3.js for me to learn, however next time I would also like to focus on learning how to build an R scraper that can pull data from multiple different webpages automatically and find a way to apply that.  Looking forward to it!
