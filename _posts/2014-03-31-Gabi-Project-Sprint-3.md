---
layout: posts
title: Gabi - Project Iteration 3
description: Project update
Tags: project
---

### Sprint 2 - Recap:
> I wanted to continue working on cleaning the datasets and I worked on better clearing the data of missing information. Many row values are set to -1111 due to missing data and I initially set these to zero. Once I started making maps of the data I realized these zero values were skewing the data since they weren't real and that I should completely eliminate these. This helped me understand the maps better and the correlation heat maps. 
> I spent a lot of time exploring the Risk Factors data and still need to continue exploring the Demographics and Leading Causes of Death datasets.
> I still would like to figure out how to make interactive data visualizations 
[![](http://Gabya06.github.io/edav/assets/gaby_assets/risk_dat_relationships.png)](http://Gabya06.github.io/edav/assets/gaby_assets/risk_dat_relationships.png)
[![]({{ site.baseurl }}/assets/gaby_assets/risk_dat_relationships.png)](https://Gabya06.github.io/edav/assets/gaby_assets/risk_dat_relationships.png)

[![risk_dat_relationships](http://Gabya06.github.io/edav/assets/gaby_assets/risk_dat_relationships.png)](http://Gabya06.github.io/edav/assets/gaby_assets/risk_dat_relationships.png)


### Progress Made:
* I started exploring the Risk Factors dataset, in particular looking at obesity:
* I looked at correlations between different variables by looking at heat maps, scatter plots and maps. 

### Correlations - Heat Maps, Clustering graphs and Histograms
> I found a function called 'ggpairs' which shows the correlation values and some clusters, thought it was an interesting start to exploring correlations:

[![risk_dat_relationships](http://Gabya06.github.io/edav/assets/gaby_assets/risk_dat_relationships.png)](http://Gabya06.github.io/edav/assets/gaby_assets/risk_dat_relationships.png)

> Plotted a few heat maps using various colors which all showed the highest correlation between obesity and no exercise as well as high blood pressure and diabetes. 

[![risk_heat_bl](http://Gabya06.github.io/edav/assets/gaby_assets/risk_heat_bl.png?raw=true)](http://Gabya06.github.io/edav/assets/gaby_assets/risk_heat_bl.png?raw=true)

[![risk_heat_org](http://Gabya06.github.io/edav/assets/gaby_assets/risk_heat_org.png?raw=true)](http://Gabya06.github.io/edav/assets/gaby_assets/risk_heat_org.png?raw=true)


> I then subsetted risk data to explore correlations for which the percentages of obesity was greater than 20%. After removing the less than 20 % obesity data, I found that the top 3 correlations between risk factors are:
1) Percent of people with diabetes and percent of people with high blood pressure
2) Percent of people who reported not exercising and the percent of people who are obese
3) Percent of people who reported not exercising and the percent of people who with high blood pressure

[![risk_heat_obesity20](http://Gabya06.github.io/edav/assets/gaby_assets/risk_heat_obesity20.png)](http://Gabya06.github.io/edav/assets/gaby_assets/risk_heat_obesity20.png)
> I explored scatter plots for obesity and other variables to visualize the clustering between variables
[![risk_obesityNoEx_scatter](http://Gabya06.github.io/edav/assets/gaby_assets/risk_obesityNoEx_scatter.png)](http://Gabya06.github.io/edav/assets/gaby_assets/risk_obesityNoEx_scatter.png)
> I looked at histogram of obesity percentage, where I found that the bulk of the obesity percentages are between 20 and 30%.
[![obesity_hist](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_hist.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_hist.png)

### Progress I made on using ggplot for Maps - State Level:

To create a map of obesity at the state level in the United States I had to do the following: 
> I merged risk data with state data available through the function map_data('states') by state name. The 'map_data' function allowed me to access the state longitudes and latitudes which are needed to create a map. 
> To add the state borders to the map in ggplot, I added 'geom_polygon, and to add county borders I had to access the 'county' longitudes and latitudes through the 'map_data' function and then add another 'geom_polygon'.
> In order to use Colorbrewer I had to create a column of intervals from the obesity percentages. I used the 'cut_interval' function and cut the obesity percentages into 8 intervals. 
> I made two different variations of the map, one with the sequential palette and one with diverging palette to highlight where obesity is the highest in the states and to see which percentages are most common in the states:
- I think the pink map allows you to see that there are actually quite a few states with obesity between 27 and 31 % since these are colored darker than in the other map where they are light blue and could possibly be misleading. I also think the orange map makes it easier to see that most states reported obesity between 23 and 27 percent.
[![obesity_map_states_Purd](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_states_Purd.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_states_Purd.png)

[![obesity_map_states_org](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_states_org.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_states_org.png)

> Next, I subsetted risk data only to look at states with obesity over 10% at first then 20% and put it on the map using State data:
I used the "Paired" palette from colorbewer which shows different colors paired, which I think nicely shows how some states relate to others:
[![obesity10_map_states_paired](http://Gabya06.github.io/edav/assets/gaby_assets/obesity10_map_states_paired.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity10_map_states_paired.png)

[![obesity20_map_states_paired](http://Gabya06.github.io/edav/assets/gaby_assets/obesity20_map_states_paired.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity20_map_states_paired.png)



### Progress I made on using ggplot for Maps - County Level:

> Next I wanted to plot obesity at the county level and created a few maps. To do this, I created a dataframe by merging risk data and county data (obtained through the 'map_data' function mentioned above) by county and state name. When looking at the maps, I was surprised to see so many white areas due to the lack of data. For example, in the map where obesity is colored by state in Texas, it looks as though the entire state is between 23-28 percent obese, but when looking at the map where counties are used Texas is very white. Looking back at the original risk dataset, 190 of 254 total records from Texas did not have data (rows values were -1111) which explains the large number of white areas. 
[![obesity_map_counties_paired](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_counties_paired.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_counties_paired.png)

[![obesity_map_counties_Purd](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_counties_Purd.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity_map_counties_Purd.png)

> To be consistent, I also created maps to show obesity greater than 10% and 20%:
[![obesity10_map_counties_org](http://Gabya06.github.io/edav/assets/gaby_assets/obesity10_map_counties_org.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity10_map_counties_org.png)

[![obesity20_map_counties_org](http://Gabya06.github.io/edav/assets/gaby_assets/obesity20_map_counties_org.png)](http://Gabya06.github.io/edav/assets/gaby_assets/obesity20_map_counties_org.png)

#### Project plan – Next 3 weeks:
* I will start exploring the other datasets
* Figure out how to work with the data in a meaningful way and what conclusions can be drawn from the different datasets.
* Continue to explore data and try to visualize results in meaningful ways
* Figure out how to make interactive data visualization 
* Work toward creating documentation for this package in R




