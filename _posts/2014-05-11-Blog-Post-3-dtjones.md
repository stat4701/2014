---
layout: post
title: "Blog Post 3: Clustering Actors"
description: 
tags: blogpost, dtjones
---

#Context
In working on my Machine Learning final project, Jed and I pulled data from IMDB and a dataset with budget and gross movie information. This data is very rich and I wanted to explore with visualization. 

For this blog post I wanted to group actors into clusters based on genre, movie budget size and earnings ratios. For example, with this analysis I hope to identify groups of actors that are featured in big budget thrillers and distinguish from actors in romances. 

#Data & Code
We found a dataset with budget info [here](http://www.the-numbers.com/movie/budgets/). Using this data set, we made an api wrapper to get IMDB info about all of the movies, including genre, actor and other metadeta. After munging that data, I used two csvs for this project [1]() and [2]()

The initial dataset had a row for every movie and a few actors delimited by commas in another field. I had to un-pivot the data so that I had a row for every actor, the count of appearancees in a genre, and the average budget and earnings ratio per movie.

From here I ran k-means to cluster the data, and created a function to subset the data based on a genre and chart it. I found a function to add subplots to one plot. This came in handy as I couldn't do a facet grid because more often than not, a movie is classified as more than one genre. 

After I had the code setup to plot the top 12 genre subets colored by cluster, I experimented with the features in the algorithm and the k-means parameter. 

[R code here](https://github.com/devintjones/edav/blob/djproject/assets/blogpost3_dtjones.R)

#Charts
I first tested 10 clusters with no transformations on the variables
![raw](https://raw.githubusercontent.com/devintjones/edav/djproject/assets/clusters_raw.jpeg)

Log transform of the average budget:
![log_budget](https://raw.githubuserconent.com/devintjones/edav/djproject/assets/clusters_log_budget.jpeg)

Without any money at all:
![nomoney](https://raw.githubusercontent.com/devintjones/edav/djproject/assets/clusters_no_money.jpeg)

No money 4 clusters:
![nomoney_4clusters](https://raw.githubusercontent.com/devintjones/edav/djproject/assets/clusters_4_nomoney.jpeg)

6 clusters, ER, log budget:
![6_logbudget](https://raw.githubusercontent.com/devintjones/edav/djproject/assets/clusters_6_logbudget.jpeg)

6 clusters, log er, log budget:
![6_log_log](https://raw.githubusercontent.com/devintjones/edav/djproject/assets/6_log_log.jpeg)

#Findings & Next Steps
Based on the above charts, it is apparent that the scale of budget and earnings ratio heavily influence the distance calculation in k-means. Additionally we can see that if the k parameter is set too high, groupings seem to become arbitrary. 

In the case with 6 clusters and log of ER and budget, we can identify a few cases where there is low budget and high ER opportunities in blue and low ER actors in yellow. Additonally, green appears to include high budget actors that appear in action, adventure, and fantasy movies predominantly. Red appears to be average. 

These clusters could potentially be used for casting or for movie earnings ratio predition based on the additional historical metadata we have. It could also be interesting to explore a network graph of co-starring actors. 

<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->