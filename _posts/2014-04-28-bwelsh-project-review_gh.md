---
layout: post
title: Project Review - Barbara
description: this is the post for my final project review
tags: project
---
## Project Overview ##

For this project, I chose to compare two international assessment tests - PISA and TIMSS. In 2003 both tests were given at the same time, which led to several studies comparing the assessments. I chose to focus on [one](http://www.oecd-ilibrary.org/education/comparing-the-similarities-and-differences-of-pisa-2003-and-timss_5km4psnm13nx-en) in particular, which found that in mathematics western countries tended to do better on the PISA assessment and eastern countries tended to do better on TIMSS. I used this as a starting point to compare scores on the two assessments for various factors on the 2003 and subsequent assessments. 

###Data Collection###

To collect data for this analysis, I started by trying to obtain raw scores for each student who underwent the assessment. Because of how the study was done, that was not feasible. Instead, I collected the country metrics from the reports produced and available from the organizations that administer the tests, OECD for PISA and ICS at Boston College for TIMSS. Each report was different, some in excel, some were PDFs of images, and some were PDFs of tables. Since I could not create a single script to parse all of the files, I took all of the results from their various sources and created a csv with all of the data I wanted to use. Also, as the tests are not given on the same cycle, I broke the exams into "Rounds" instead of years for comparison.

###Exporatory Analysis###

I chose to use R for the analysis phase of this project. I started a file containing functions to load in the data and analyze it. I wrote functions to standardize the scores from both tests in order to compare them, and to subset the data so that when comparing data from the tests for various rounds, I would make sure to only compare data between countries that took both exams, as the country lists change for each cycle of each exam. I really wanted to create some graphs to see the comparison for different combinations of features, and so I then wrote some helper functions to get the data in right form for plotting with ggplot2. Lastly, I wrote some functions to plot the data for different combinations of factors.

###Visualization###

Since one of the factors I was exploring was geographic, it seemed that a map might be useful for this visualization. My vision was to create a world map in D3 and color the countries based on their performance. I had data broken down by round, subject, statistic, gender, and in some cases content area, so I figured that I could make all of these factors available, to allow the user to select a combination of them and then see the results. Since this would not allow someone to necessarily see country-specific details, my plan was to add a feature to the map such that when a country is clicked, an additional graph or set of graphs appears below the map. This feature has not been implemented yet, though. I really needed the data in a multi-dimensional object for data binding, and I was not able to quickly do this within R, although I knew python could handle it easily, and so I wrote an R script to export the data into various csvs, and then a Python script that read in the csvs and then output a json file. The scripts, csvs and json file are located [here](http://github.com/bwelsh/edav/blob/gh-pages/assets/project/data_munge/). The scripts were rather hastily written, and so are not of great quality, but they do work. The map is a work in progress at this point.

## Demo ##

There are two parts to the project, the graphs created with ggplot2 in R and the map created in d3. The map is located [here](http://bwelsh.github.io/edav/assets/project/d3worldmap.html). The way it works is that based on the selections made for the menu items at the top, the map displays the normalized scores for the countries that participated in the selected tests. If neither test is selected, the scores are a comparison between the two (the amount the country did comparatively better on PISA), with a score of 0 indicating the country performed similarly on both. For each view, the scores are normalized against only the countries where data is available. If a test is selected, the scores for the countries are the normalized scores for just that test, with 0 again being an "average" score based on the countries participating. The round filter allows for a fair comparison between different rounds of testing. For example, if '1-2-3' is selected, the results shown will only be for countries that participated in the selected tests for all three rounds. To see results from one round to the next, select the round number in the Round menu. For some combinations of menu items, data is not available. In that case, no results will be shown.

A sample of the graphs produced by the R portion are located [here](http://github.com/bwelsh/edav/blob/gh-pages/assets/project/ggplot_graphs/). I made four different types of graphs, the first showing the correlation between two features. In this graph the countries are dots, colored by whether they are classfied as "Eastern" or "Western" countries. For example, the below graph shows the correlation between mean scores in Math on each test by round. Any country above the line performed relatively better on the TIMSS assessment.

<a href="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/cor_round123_Math_Mean.PISA_Mean.TIMSS.png"><img src="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/cor_round123_Math_Mean.PISA_Mean.TIMSS.png" alt="Correlation Plot" width="200" height="400"></a>

The second type of graph is a line graph showing relative performance over multiple rounds. For example, the below graph shows the relative performance in Science mean scores for all three rounds, among the countries that participated in both tests in all three rounds.

<a href="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/multi_round123_Science_Mean.png"><img src="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/multi_round123_Science_Mean.png" alt="Difference over Time Plot" width="500" height="300"></a>

The third type of graph is a series of line graphs, one for each country, showing scores over the various rounds. For example, the below graph shows the relative performance in the Math content areas for all three rounds.

<a href="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/content_round123_Math_by_country.png"><img src="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/content_round123_Math_by_country.png" alt="Math Content Plot" width="450" height="500"></a>

The fourth type of graph is another series of line graphs, showing for a particular country, the relative performance for different categories. For example, the below graph shows the relative performance of the males and females on the four different content areas of the TIMSS assessment, for Norway.

<a href="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/gender_content_round123_Math_Norway.png"><img src="http://bwelsh.github.io/edav/assets/project/ggplot_graphs/gender_content_round123_Math_Norway.png" alt="Gender Country Plot" width="500" height="400"></a>

## Implementation ##

###Graphs in R###
To implement the graphs in R, I created [this code](http://github.com/bwelsh/edav/blob/gh-pages/assets/project/r_scripts/countryData.R) and then created [this script](http://github.com/bwelsh/edav/blob/gh-pages/assets/project/r_scripts/sample_graphs.R) to run the sample graphs above. This was really my first R project, so many of the functions (especially the first ones I wrote) are not canonical R code. There is also a lot of potential for refactoring here, as I learned as I went along that several things could be parameterized to avoid code duplication. One big issue in this project is that I had a lot of variables. I needed to be able to answer questions like, "How have relative scores between the tests changed between rounds for subject x and statistic y?". In order for the comparison to be fair, I needed to look only at countries that participated in all of the assessments implied by the question, and normalize the scores for only those countries. To do that, I wrote a function that given the rounds passed in, will return a list of countries. This helped enormously as I was able to call this each time I wanted to make a plot, get the countries, and then subset the data to include only those countries before normalizing. 

###Binding Data for the Map###
To create the map using d3, I need to bind data from two sources - the coordinate data for each country, and the test scores I calculated for each country for each set of variables. Each was a multi-dimensional object. Using d3's json function, I first got the coordinate data, which included an attribute for the country id, then based on that country id, appended an additional object to the coordinate data for the test values, again using d3's json function. Since all of the data is now bound to each path element, I don't need to redraw anything whenever something changes, which is what I had done for previous blog posts.

##In Progress##

My work in progress currently is figuring out what graphical display to show below the map when a country is selected. My current thought is some sort of line plot showing scores for the country over time. 

##List of ToDos##
I obviously still have a number of to-dos. I've broken them down into tasks I plan to complete, and tasks I would like to complete, but are likely not realistic time-wise.

###Tasks Expected to Complete###
1. For the map, add graph(s) below the map for country details.
2. For the map, there are a number of small UI improvements I would like to make, mainly to better inform on how to use the map and what information is being displayed at a given time. These are all in a to do list at the bottom of the map file. 
3. For the R code, I need to create a final script that creates all (or at least as many as I would like to show in my final project) graphs.
4. In general, I need to complete the final write up for the project.

###Tasks For the Future###
1. For the R graphs, I would really like to refactor the R functions that normalize the data and produce the graphs. There are many opportunities for parameterization and use of canonical R code.
2. For the map, I would like to change the UI for the menus, to make it more user friendly, and especially to dynamically change the options based on the other options selected. 
3. An analysis of individual test items. I have the data and would love to see how scores on questions that were asked over multiple testing cycles compared. I did start on R code to do this for TIMSS questions, but in only works for some types of questions currently.


