---
layout: post
title: Jiun's Blogpost 3: Scatterplot Matrix using rCharts
description:
tags: blog, d3, R, rCharts
---

* Tools used: rCharts
* Theme: Scatterplot Matrix

## Wholesale Customers' Spending Behavior by Channel and Region##

### 1. Graph Critiques: ###

I couldn't resist to work on this plot below. It's quite amazing to see how one put continuous variables ('Height' and 'Weight') and a categorical variable ('Sex') in the same Scatterplot Matrix. 

<a href="http://www.jmp.com/support/help/images/students.gif"><img src="http://www.jmp.com/support/help/images/students.gif" alt="Scatterplot Matrix" width="450" height="450"></a>

The web link for the plot is [here](http://www.jmp.com/support/help/Example_of_a_Scatterplot_Matrix.shtml). Scatterplot Matrix is mainly used to represent the relationships among multiple variables. Though I admit visualizing high dimensonal data is not an easy task, putting 'Sex' variable together with continuous variables in one scatterplot matrix wasn't a smart choice, in my opinion. 

### 2. Data source: ###

Since there was no way that I could identify the source of the original data, I used a different set of data which has similar properties and hoped to represent it in a more effective way. I extracted data from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Wholesale+customers). Beside this particular dataset, the repository actually holds various types of dataset. 

### 3. Thought process and Actions: ###

I thought of making a plot like [this](http://hci.stanford.edu/jheer/files/zoo/ex/stats/splom.html). There were two things that I wanted to improve upon this plot though. First, I wanted to see different scenarios of "US" and "EU" and "Japan" by adding an interactive selection option. Second, I wanted to use the space of diagonal cells/parts of matrices where the name of variables are written, by adding box-plot which could be more informative. Then, I discovered a new world 'rCharts'. Volia! rCharts is an R package to create, customize and publish interactive javascript visualizations from R using a familiar lattice style plotting interface. Here is my embedded visualization below. The R code and the plot can be seen [here](http://bl.ocks.org/jiun0201/6c1cfef66c61c7bd8952). 

<div align="left"><iframe src="http://bl.ocks.org/jiun0201/6c1cfef66c61c7bd8952/" allowfullscreen="allowfullscreen" frameborder="0" width="1200" height="850"></iframe></div>

Now, One could view the matrix by 'Region' and 'Channel' and not much of confusion going on, I hope at least. :-)

I became a fan of rCharts. It's reusble code and fancy and slick looking. Implementing it was fairly straightforward. All I had to do was wrangling dataset to pulg it into rChart package and publish my end product visualization to my Githubgist.   



