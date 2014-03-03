---
layout: posts
title: Visualizing data - A contrarian view
description: Assignment 1 - Reimagining City Population data
Tags: assignment KISS minimalistic visualization not chartoons
---

#### The Premise
* This post continues from the visualization exercise of assignment0 and in the bargain derive some 'points to ponder' for future visualization exercises.  Its reasonable to question the choice of the data set.  After all its been 'revisualized' by the class many times over.  My choice of the data set was deliberate.  
* My objective in this post is not to find new insights from the data but to use it to investigate the process of data exploration, analysis visual communication and 

 the use and abuse of feature rich (read code heavy and visually complex) graphs in general. 
I wanted to choose data that was familiar to all us to facilitate an understanding of my point of view on visualization.

#### The purpose of data visualization
Purpose of graph and data visualization, as per Tukey (1993), is to describe, compare, make an impact and report the results of data analysis. 


A network graph I created of [my Facebook connections](http://t.co/TNgVXpwBcy)
[![](https://pbs.twimg.com/media/Bhw6GIeIAAAAGWd.jpg:large)](https://twitter.com/MayankMisra/status/440290740791689217/photo/1/large)


A similar one for [my professional connections on LinkedIn](https://pbs.twimg.com/media/Bhw7p_DIcAA9ce4.jpg:large) created using the [LinkedIn Labs graph app](http://bit.ly/1kKpr1G) 
[![](https://pbs.twimg.com/media/Bhw7p_DIcAA9ce4.jpg:large)](https://twitter.com/MayankMisra/status/440292456224276480/photo/1/large)

A [checklist for creating data products](http://www.juiceanalytics.com/writing/a-checklist-for-creating-data-products/)

[![](http://www.juiceanalytics.com/writing/a-checklist-for-creating-data-products/)](http://juiceanalytics.com/wp-content/uploads/2013/10/JuiceChecklist-ProductManager.png)

>> Expand on :
Its different from information graphics
Strength and Weaknesses of the current trend
A balanced approach
High priesthood of data scientists and analysts
A come not to praise Caesar but to burry him

#### Methodology
For Exploratory Data Analysis and Visualization (EDAV), Philip Guo's work on [Data Science Workflow: Overview and Challenges](http://cacm.acm.org/blogs/blog-cacm/169199-data-science-workflow-overview-and-challenges/fulltext) is very helpful.  
It not only lays down the steps but also gives a preview of the potential challenges and rela world options to overcome them.  In a nutshell, the workflow is visualized as follows:

#### Workflow
[![](http://cacm.acm.org/system/assets/0001/3678/rp-overview.jpg)](http://cacm.acm.org/blogs/blog-cacm/169199-data-science-workflow-overview-and-challenges/fulltext) 
(note the redirect!)


#### Approach

##### Prepare

Main data set: 

-[US Population data source](https://github.com/malecki/edav/blob/uspop/projects/popgraph/get-data.py)

Ancillary data sets: 

-[DMA Regions and their associated cities](http://goo.gl/itBaJE)

-[DMA Geographical Targeting](http://goo.gl/zYf1gK)

Wrangled Data

-[Finally the cleaned data set](http://public.tableausoftware.com/views/City_Population_Trend/Data?:embed=y&:display_count=no)

-[A lookup for future visualizations US State to City look up]({{ site.baseurl}}/assets/mm3557-cp-city-state-lkup.csv)

[![]({{ site.baseurl}}/assets/incomeladder.png)](http://www.nytimes.com/2013/07/22/business/in-climbing-income-ladder-location-matters.html?_r=0)

[![]({{ site.baseurl}}/assets/mm3557-cp-hw1-data.png)](http://public.tableausoftware.com/views/City_Population_Trend/Data?:embed=y&:display_count=no)

##### Analysis

[Trend Summary - Geo Hierarchy](http://public.tableausoftware.com/views/City_Population_Trend/TrendSummary-GeoHierarchy?:embed=y&:display_count=no)

[Population Migration](http://public.tableausoftware.com/views/City_Population_Trend/PopulationMigration?:embed=y&:display_count=no)

[Population Size - Census Region/Division](http://public.tableausoftware.com/views/City_Population_Trend/PopulationSize-CensusRegionDivision?:embed=y&:display_count=no)



##### Reflection

##### Dissemination

#### Observations

#### Hypothesis



