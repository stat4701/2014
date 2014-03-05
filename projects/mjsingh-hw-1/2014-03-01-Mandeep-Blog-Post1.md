---
title: Mandeep's Blog Post 1
description: Analyze Trends in Distribution of Income Between Top 1% and Bottom 20%
tags: blogpost
---

The intent behind this blog post is to compare and contrast distribution of household incomes shown in [Visualizing Economics Blog](http://visualizingeconomics.com/blog?tag=Congressional+Budget+Office).

[Source: Congressional Budget Office](http://www.cbo.gov/publication/43373) 

Here is my critique on the chart show above:

<ol> 
	<li> The axes is not clear in terms of what the chart is showing. </li>
	<li> The stark contrast in the distribution of income between the top 1% and bottom 20% is not clearly shown. </li>
	<li> It is not clear how these factors have changed over the course of last 30 years. </li> 
</ol>

Here's a breakdown of what I did for this blog post:

1\. I sliced the source data to highlight the concentration of income among the top one percent and show the stark contrast from the bottom 20%.

Spent a lot of time on this step as I had to go from a column orientation to a row orientation for the years. This involved using the melt function of the reshape2 package.

2\. Plotted the combined chart to show the variation in income concentration between the top 1% and the bottom 40% of the population. Used facet_grid() to shown the split across income types.
```{r chunkLabel}
bp <- qplot(factor(year),data=df2,geom="bar",fill=as.factor(Percentile),
            weight=Percentage,position="dodge",main = "Income Concentration", 
            xlab="Year",ylab="Income (%)") + facet_grid(. ~ Type)
```
![Combined](https://www.dropbox.com/s/1iunkz3wx4kw326/combined.png)

3\. Used a combination of tapply and barplot function for individual barplots to highlight the stark contrast between top 1% and bottom 20%.
```{r chunkLabel}
data1 <- tapply(df1$Labor, list(df1$Percentile,df1$year), sum)
barplot(data1,beside=T,col=c("#ee7700","#3333ff")
        ,main="Labor Income Concentration",xlab="Year",ylab="Labor Income (%)",
        legend.text = c("Top 1 Percentile", "Bottom 20 Percentile"),
        args.legend = list(x = "topleft"))
```

4\. [Source code in R](https://github.com/msingh4674/edav/tree/gh-pages/edav%20hw1/blog p1.R)  Complete source code of the R script.

# Individual Barplots 

[Capital Income Distribution](https://www.dropbox.com/s/llvdbdrrb94qisb/CapitalIncome.png)

[Capital Gains Distribution](https://www.dropbox.com/s/hh94pne5l4iufkq/CapitalGain.png)

[Business Income Distribution](https://www.dropbox.com/s/ewv2i4kreawjj6l/Business.png)

[Labor Income Distribution](https://www.dropbox.com/s/97aod2juflby55y/Labor.png)







