---
layout: post
title: Mandeep's Blog Post 1
description: Analyze Trends in Distribution of Household Income
tags: blogpost
---

The intent behind this blog post is to compare and contrast distribution of household incomes shown in [Visualizing Economics Blog](http://visualizingeconomics.com/blog?tag=Congressional+Budget+Office).

[Source: Congressional Budget Office](http://www.cbo.gov/publication/43373) 

Here is my critique on the chart show above:

<ol> 
	<li> The axes is not clear in terms of what the chart is showing</li>
	<li> The stark contrast in the distribution of income between the top 1% and bottom 20% is not clearly shown. </li>
	<li> It is not clear how these factors have changed over the course of last 30 years. </li> 
</ol>

Here's a breakdown of what I did for this blog post:

1\. I sliced the source data to highlight the concentration among the top one percent

2\. Plotted the data in R to see the trend for the various sources of Income 
```{r chunkLabel}
require(ggplot2)
df1 <- subset(df0, Percentile %in% c("1", "20"))

data1 <- tapply(df1$Labor, list(df1$Percentile,df1$year), sum)
barplot(data1,beside=T,col=c("#ee7700","#3333ff")
        ,main="Labor Income Concentration",xlab="Year",ylab="Labor Income (%)",
        legend.text = c("Top 1 Percentile", "Bottom 20 Percentile"),
        args.legend = list(x = "topleft"))
```
![Labor Income Distribution between top 1% and Bottom 20%]https://github.com/msingh4674/edav/tree/gh-pages/edav%20hw1/CapitalIncome.png?raw=true)

3\. [Source code](https://github.com/msingh4674/edav/tree/gh-pages/edav%20hw1/blog p1.R) to see the various sources of income across the different populations
![Capital Income Distribution between top 1% and Bottom 20%](https://github.com/msingh4674/edav/tree/gh-pages/edav%20hw1/CapitalIncome.png?raw=true)






