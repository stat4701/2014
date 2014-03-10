---
layout: post
title: MTG Project Update
description: A progress update on MTG competitive analysis tool
tags: iter2
---

### Objective Progress: the good, the bad and the ugly

I have been able to collect a Magic: The Gathering card database in JSON format and edited it to remove objects that are not applicable to the project such as border color, artist name as well as sets of cards that are not allowed in competitive play such as the unglued and unhinged “joke” sets.

In addition I have been familiarizing myself with d3 data visualization and the functionality of Python data scrapers, which is a slow and arduous process.  

Thus far in d3 I have been able to generate simple, non-interactive visualizations of data (see my output of several box plots in my [blog post #1](http://malecki.github.io/edav/2014/03/03/awcastleton-patch-3/)) with the help of sample code found at various online resources.  I am still not as comfortable with d3 as I would like since embedding interactivity into my charts is still something that confounds me.

My Python progress is even more frustrating.  Thus far I have been able to build a simple scraper that pulls data out of a table on a dummy webpage, but the data I need is distributed across many different pages (more than could simply be listed) and the pages are much more complex.  This is a problem I have not yet had the time to solve.

Besides the road blocks from teaching myself several new programming languages at once, I also found that one of my primary data sources, starcitygames.com, states on their legal page [here](http://sales.starcitygames.com/FAQ.php?ID=91) that they will not allow information on their site to be scraped for any reason.  Luckily, I have found alternative data sources that, when pooled, will still provide plenty of data.

### Moving Forward - Next 3 weeks

* Find a way to scrape multiple webpages with a single scraper so that I may scan an entire site for deck information
* I would like learn more about and get more comfortable with applying interactivity to d3 generated visualizations
* Get a simplistic version up and running

All three of these objectives are left over from the previous 3 weeks’ iteration plan, but they all proved much more difficult to overcome than I had initially anticipated.  That being said, I look forward to the next three weeks being much more productive (I will also have much more time available in the coming weeks to devote to my endeavors due to spring break).

