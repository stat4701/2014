---
layout: post
title: Gabi - Blog Post 3
description: Top Chocolate Consumption 
tags: blogpost
---

### Main Source of Data:
For the final blogpost I came across this map [here](http://www.confectionerynews.com/Markets/Interactive-Map-Top-20-chocolate-consuming-nations-of-2012) discussing chocolate consumption per capita. After looking around a bit I found a pdf report [here](http://caobisco.eu/public/images/page/caobisco-10072013170141-Ranking_of_consumption_FBW.pdf) with more data on chocolate consumption. 

### Thoughts on the original:
When I first saw the map of chocolate consumption I was immediately interested in finding more data because I thought the map was a bit lacking. I was wondering if there was more data available and wanted to explore other types of graphs.

### Data and Visualization Process:
I didnt have too much trouble finding the data; I just googled for top chocolate consumption and found a few reports online. The trouble I had was finding a table with enough information in it. While there are many reports, information seems to be missing for many countries, and some tables do not include all chocolate products. I looked through most of the report and settled on using a table with consumption per capita in kg/head (on page 45) which includes all chocolate products which refers to: Unfilled chocolate, Filled tablets and bars, "Bonbons", pralines and other chocolate confectionery, Sugar confectionery containing cocoa, white chocolate, Spreads containing cocoa, Sweetened cocoa powder (preparations), ready for retail use. The data is just a table of totals detailed by countries/regions, which I copied to excel and read in R. Since the dataset is pretty small there wasnt much processing to do besides sorting, subsetting or renaming columns. After sorting the data, I noticed that the countries at the top were Ireland, Germany, Switzerland and UK, so I started putting together some visualization for these countries only.

### Chocolate Consumption in Top Countries
I started out by plotting a bar graph of the chocolate consumption per capita facetted by country:
[![topchoco_barPlot](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_barPlot.png)](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_barPlot.png).


Problem: The bar graph shows consumption by country by year, but since most countries had steady consumptions the bars overlap each other which does not make the chart very informative. 

Next I looked at line plot of consumption by country from 2006 to 2011:
[![topchoco_lines](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_lines.png)](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_lines.png)

I thought this graph was a little bit better because it shows Germany and Switzerland zig-zagging while Ireland is rapidly decreasing its chocolate consumption.

After seeing the decline in Ireland, I was interested in seeing density plots facetted by Country:
[![topchoco_density](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_density.png)](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_density.png)

After plotting the top countries, I was interested in the same graphs for Eastern European countries:
[![eastchoco_density](http://Gabya06.github.io/edav/assets/gaby_assets/eastchoco_density.png)](http://Gabya06.github.io/edav/assets/gaby_assets/eastchoco_density.png)

While I was looking at density plots, I came across violin density plot which I had not seen before, so I plotted the following:
[![topchoco_violin](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_violin.png)](http://Gabya06.github.io/edav/assets/gaby_assets/topchoco_violin.png)
[![eastchoco_violin](http://Gabya06.github.io/edav/assets/gaby_assets/eastchoco_violin.png)](http://Gabya06.github.io/edav/assets/gaby_assets/eastchoco_violin.png)







