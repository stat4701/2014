---
layout: post
title: Mingyun Guan's Blog Post
description: Currency Packs for Mobile Free-To-Play Games
tags: blogpost
---

Blog Post by Mingyun Guan(mg3419)

I found an interesting article entitled ["5 Premium Currency Pricing Trends and Tricks used by Mobile Free-To-Play Games"](http://www.allworkallplay.org/blog/5-premium-currency-pricing-trends-and-tricks-used-by-mobile-free-to-play-games/) published in April 29,2014. This blog post collected data from 32 games on the App Store and analyzed how they sell their premium currency and found some trends. Although the method for selecting games was pretty unscientific and the sample size is small, we can still find something interesting from it.

The plot that I'm interested in is here:

![Price Point Distribution](https://github.com/guangoku/Data-Visualization/blob/master/BlogPost1/plot1.PNG?raw=true)

I think this is a nice chart, but I want to generate a chart that tells more detail information.

#Data


- The author offered a link to download all of his data and charts in a xlsx file.
-  I used R to clean the data and generated two types of data sets for different use, one for generate bar chart by ggplot in R and another for stream graph by D3.
- The code is not clean and a little bit messy, so I decided to only show some essential ones here. 

#Plots
 

- At first, I generated a bar chart using ggplot2. The x axis denotes the prices (EURO) of a pack of gems or diamonds offered by Mobile Free-To-Play Games. The y axis is the frequency of each price. it is grouped by different currency packs of the games. We can see some popular currency packs here.
![bar chart](https://github.com/guangoku/Data-Visualization/blob/master/BlogPost1/plot2.jpeg?raw=true)


- But in this chart, I treated price as a factor, and we can't see the distance between prices. So I try to generate stacked plot or stream plot as the next step. Lucky enough, I found a [blog](http://menugget.blogspot.com/2013/12/data-mountains-and-streams-stacked-area.html) about it. Using the basic function the blog provided, I generate the following two plots.
![stacked & stream plot](https://github.com/guangoku/Data-Visualization/blob/master/BlogPost1/plot3.png?raw=true)

-I don't think this chart looks nice, and it does not show the exact value of the prices. So I made an interactive stream graph using D3, based on the [sample](http://bl.ocks.org/WillTurman/4631136) by Will Turman. We can what's the game is through this one.
[The third plot is here](http://guangoku.github.io/streamtry1.html)



#Some Code
See all the R and D3 files [here](https://github.com/guangoku/Data-Visualization/tree/master/BlogPost1)

      
    newdata<-read.csv("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/data.csv")
    require(reshape2)
    datacast <-dcast(newdata, date ~ key, value.var="value")
    barcleanmelt <- melt(bardataclean, value.name="Value",variable.name="Metric")
    colnames(barcleanmelt)<-c("PricePack", "Value", "frequency")
    bardataclean<-as.matrix(bardataclean)
    barplot(bardataclean)
    require(ggplot2)
    ggplot(barcleanmelt, aes(factor(Value),frequency))+geom_bar(aes(fill = factor(PricePack)))

    pal <- colorRampPalette(c(rgb(0.85,0.85,1), rgb(0.2,0.2,0.7)))
    BREAKS <- pretty(apply(ggdata2,2,max),8)
    LEVS <- levels(cut(1, breaks=BREAKS))
    COLS <- pal(length(BREAKS )-1)
    z <- val2col(apply(ggdata2,2,max), col=COLS)

    png("C:/study/columbia study/Exploratory Data Analys/Blog Post1/stream graph/try3.png", width=7, height=5, units="in", res=400)
    layout(matrix(1:2, nrow=2, ncol=1), widths=7, heights=c(2.5,2.5), respect=TRUE)
    par(mar=c(2,4,2,1), cex=0.75)
    plot.stacked(cc,ggdata1, xlim=c(0, 100), ylim=c(0, 1.2*max(apply(ggdata1,1,sum), na.rm=TRUE)), yaxs="i", col=z, border=1, lwd=0.25)
    mtext("Stacked plot", line=0.25, side=3)
    box()
    plot.stream(cc,ggdata1, xlim=c(0, 100), center=FALSE, order.method="max", spar=0.1, frac.rand=0.05, col=z, border=1, lwd=0.25)
    mtext("Stream plot", line=0.25, side=3)
    box()
    dev.off()
    



