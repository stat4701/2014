---
layout: post
title: Mingyun Guan's Blog Post
description: video game console sales
tags: blogpost
---

Blog Post by Mingyun Guan(mg3419)
## Source Data and Ideas##

I have been interested in the information of video game consoles for a long time. So after I found the data sets from [VGCharts](http://www.vgchartz.com/), I am really eager to find a method to visualize it. The website have its own tools to do some of the basic visualization. 

As we know, there is a two-sided market in video game industry. For console producers like Sony and Microsoft, they might sell their consoles at a lower price to increase its hardware and software sales, and get the money back by charging the console owner Fee to software publishers.I want to generate a plot that can say something about the relationship between the launch price and sales of video game consoles. 

The data from VGCharts is pretty clean, and I didn't do much with it. 
The launch prices of consoles adjusted for inflation are found [here](http://kotaku.com/36-years-of-console-prices-adjusted-for-inflation-1485353267). The organized data can be reached [here](https://github.com/guangoku/Data-Visualization/tree/master/Blog%20Post2). 

## Plots ##

- Echarts: This is an interesting tool recommended by my friend and classmate Yi. This one is easier to use but has less flexibility.

- I create a bubble chart with pie charts instead of bubbles. xAxis represents the launch price of a video game console, adjusted by Inflation. yAxis denotes the number of games of each console. The radius of each pie chart is determined by either the sales of consoles(plot 1) or the sales of software on a certain console(plot 2). Pie charts are divided by regions: North America, Europe, Japan and rest of world.

- Plots links: [Plot 1(hardware sales)](http://guangoku.github.io/scatter-pie-hardware.html)     
[Plot 2(software sales)](http://guangoku.github.io/scatter-pie-software.html)


- One main problem is that I can't find a way to present which console it is on the plot. I spent lots of time trying to solve it. Maybe it is because that Echarts is quite immature right now , or I just didn't try hard enough.[Source Code](https://github.com/guangoku/guangoku.github.io)




