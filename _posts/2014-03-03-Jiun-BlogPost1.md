---
layout: post
title: Jiun's Blogpost1 
description:
tags: blog, R, ggplot, d3, nvd3

---

* Tools used: nvd3, R, d3
* Theme: MultiBarChart using ggplot and nvd3

## Top Languages Other than English Spoken in 1980 and Changes in Relative Rank, 1990-2010 ##

### 1. Graph Critiques ###

US Census Bureau has a [Data Visualization Gallery](http://www.census.gov/dataviz/visualizations). Its initiative is great though I found this particular graph very confusing. 

<div align="left"><iframe src="http://www.census.gov/dataviz/visualizations/045/" allowfullscreen="allowfullscreen" frameborder="0" width="950" height="800"></iframe></div>

Too much information such as different sizes of square, lines connected between them, different colors were all squeezed in one graph. I actually expected a simple graph since this topic is fairly starightforward. 

### 2. Data munging ###

The website provides data [table](http://www.census.gov/dataviz/visualizations/045/508.php). Data munging was done in R and R code can be seen from [here](https://raw.githubusercontent.com/jiun0201/project/master/EDAV&VIZ/Blogpost/multibar.R).

### 3. First attempt with ggplot ###

<a href="https://raw.githubusercontent.com/jiun0201/project/master/EDAV&VIZ/Blogpost/blogpost1_multibar.png"><img src="https://raw.githubusercontent.com/jiun0201/project/master/EDAV&VIZ/Blogpost/blogpost1_multibar.png" alt="Top Language Spoken Other Than English" width="800" height="600"></a>

I am most comfortable with R and thought I would try making a graph with ggplot. I tried to plot a bar graph in one setting. However, it wasn't informative because Spanish has been spoken a lot more than other languages that other languages' bars were not visible. So I thought about separating them using ggplot facet function. The graph below is where I arrived. I felt that I should explore other options since the graph shows changes over time for each langugage very well but not comparsions between languages.

### 4. Second attempt with NVD3 ###

I found nvd3 while learning D3. I liked this because it's interative. Therefore users can select different options of the graph when viewing. Also, it was fairly easy to follow. The only thing was one has to have 'nvd3 css' and 'nvd3 src' installed in their local computer/server.

1) Grouped by language

<div align="left"><iframe src="https://raw.githubusercontent.com/jiun0201/project/master/EDAV&VIZ/Blogpost/novus-nvd3-6867ea6/multibar_lang.html" allowfullscreen="allowfullscreen" frameborder="0" width="1310" height="750"></iframe></div>

2) Grouped by time(year)

<div align="left"><iframe src="https://raw.githubusercontent.com/jiun0201/project/master/EDAV&VIZ/Blogpost/novus-nvd3-6867ea6/multibarhorizontal.html" allowfullscreen="allowfullscreen" frameborder="0" width="1310" height="750"></iframe></div>


