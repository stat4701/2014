---
layout: post
title: Assignment 0
description: An assignment with several optional parts for people to get their feet wet at various stages of the game playing with a small but (hopefully) somewhat interesting dataset
tags: emails assignments
---

In the next few days, do whatever combination of the following you can manage, and post about it either to your fork of the site/blog (and notify the class of the link), the Piazza site, or by submitting it as a separate pull request to the main course blog:

1. Fix the buggy `projects/popgraph/get-data.py` (on the `uspop` branch) to retrieve `citydata.csv` for yourself. The working script is at commit 48e8131 .
2. Rewrite the citydata scraper differently -- try doing it in R, or change the output from csv to  json, or call python from R or vice versa to skip writing-and-rereading the csv, and be sure to join the separate total population by year.
3. Plot the data using matplotlib, or in R using base graphics, Lattice, ggplot2, ggvis, and shiny. Some of you have mentioned Excel or Tableau. Go for it. I'll see what I can do in Statwing and Datahero.
4. Do some of the explorations we've talked about: highlighting the most-changed max and min ranking; focusing on the middle or lower ranks; looking at length of time of declines.
5. Plot the data using D3. Github pages (or Jekyll serving locally) should make it easy enough to read in the csv; though it is small enough you could parse it from a csv or json string within a script. Append a tooltip on mouseover of each line with the city name, year, and rank. Do an update with a transition, changing the y scale among various measures of interest.
6. Find geocoördinates for the place names and plot them on a map programmatically using google maps, leaflet, or cartodb.

If you want to work with social science and something more model-driven, my go-to suggestions would be the American National Election Study, the Comprehensive Congressional Election Study, or the General Social Survey. 
