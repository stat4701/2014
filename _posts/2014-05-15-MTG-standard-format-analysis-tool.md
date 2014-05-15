---
layout: post
title: Magic: The Gathering Standard Format Analysis Tool (Born of the Gods)
description: awcastleton final project
tags: project
---


Magic: The Gathering Standard Format Analysis Tool (Born of the Gods)
=========

View the live visualization [here](http://run.plnkr.co/plunks/KtxpXtw6JAB0D769QtG7/) hosted on Plunkr.

Note: it may take a few moments to load, please be patient.

# The files

* scraper.py: This is where all of the scraping and munging of data is done
* index.html: the visualization
* c3chart1.js and c3chart2.js: some simple c3 javascript for creating the charts of the viz
* imgTooltip.js: jQuery javascript for creating the tooltips for card images
* jQuery.js: jQuery
* tcgplayerDecksTOP8.html: a modified html document pulled directly from tcgplayer.com, used to scrape for deckIDs
* bestCards.csv: csv containing the top 25 most played cards in standard and the number of occurrences
* archetypeSuccess: csv containing information on the prevalence of each archetype in every two week period of the format

# A few notes

There is always going to be more that can be accomplished with this, however as it stands this tool is comprehensive and actually tells the story of the format on a whole.  I would like there to be a larger dataset, there are certainly more decklists to pull off of other websites, but there are also redundencies between websites that would be difficult to track down and I am not convinced that the story told by the data would be any different.

Card pricing and colors are other things that could be implemented if I had more time, but the most important information is relayed in a neat and organized manner.

All in all, I am happy with the way this product turned out and it was an incredibly valuable learning experience.

A link to my repo with all files can be found [here](https://github.com/awcastleton/MTG-BNG-Standard-Analysis-Tool)
