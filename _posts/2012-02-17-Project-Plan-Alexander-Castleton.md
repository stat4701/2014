---
layout: post
title: Project Plan - Alexander Castleton (awc2134)
description: Magic The Gathering Format Analysis Tool
tags: blog project_plan
---

## Project: Magic: the Gathering Format Analysis Tool

### Intro

Magic: the Gathering (MTG) is a collectible trading card game that has outlived all others of its kind, and has developed into a worldwide, massively competitive “sport” that requires skill, dedication and luck.  Every 3 months Wizards of the Coast (WotC) introduces a new set of cards to the game.  MTG has existed since 1993 and has produced roughly 13,000 different cards to collect.

Due to the overwhelming size and reception of the game, different formats were created in which only certain cards are allowed.  This project is meant to deal with the most restricted of these formats called “standard,” in which there are currently only 6 different sets available for deck construction comprising 1278 cards in total.  The most recent set, “Born of the Gods,” came out only on Feb. 7th and this is meant to be an analysis of the keywords printed on cards, the cards themselves and the deck archetypes as the format develops.

### Goal

To build an online tool that aggregates deck and card information in the standard format over the next three months, and displays d3-generated analysis of prevalence.

It will pull the lists of cards used in top 8 finishing decks in tournament results posted on Starcitygames.com, tcgplayer.com, mtgsalvation.com, and others.  It will cross-reference those card names with a Json data set for the specific text on the cards, then output a breakdown of its changing relevance in the format over time.  It will also have overall analysis of trends in deck archetypes.

### Objectives

* To create a reliable metric for evaluating keyword, card and deck archetype prevalence in the format.
* Analyze the important characteristics of the most successful decks.
* Visualize the analysis through the use of d3 to provide interactivity.

### Project Plan - Next 3 weeks

* Learn how to scrape deck lists from relevant websites using R or Python, begin scraping data
* Get comfortable enough with d3 to begin building interactive visualizations of data
* If I can, get a draft version running, so that I have as much time as possible to refine my metrics

### Future Plans

* Refine the model to include statistical analysis on deck archetypes
* Compare my product with existing resources and make it unique
* Make it pretty :D
* Widen the scope to encompass other MTG formats (modern, legacy or commander).
