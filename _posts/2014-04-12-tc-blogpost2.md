---
layout: post
title: Tommie's Blog Post 2
description: To Pie or Not To Pie
tags: edav blogpost 
---

## Intuition - It's All About Pie
I choose this topic because of Mike's suggestion in the class. Since I am not a fan of pie or donut chart, this blog post is set to be an interesting exercise from the beginning.

## Data Munging or?
After picking up a topic, the next step is to find out what data I want to present or find a bad chart for improvement. 

## The Story Came In The Right Time
[link-01]: http://www.slideshare.net/skysql/mariadb-100-skysql-paris-meetup-171220113
[link-02]: http://www.amazon.com/Visualize-This-FlowingData-Visualization-Statistics/dp/0470944889/ref=sr_1_1?ie=UTF8&qid=1397340185&sr=8-1&keywords=yau+visualization
[link-03]: http://db-engines.com/en/ranking
[link-04]: http://junkcharts.typepad.com/.a/6a00d8341e992c53ef01a51184b1f8970c-pi

Recently I received an assignment to research and compare usage of open source database engines. I did not have much experience in this area except few toy practices in MySQL database.
So I decided to look at MySQL first. After some initial searches, I came across a presentation about [Maria DB][link-01]. One of the slides shown below was trying to discuss future usage of MySQL. 
According to Nathan Yau, the author of [Visualize This][link-02], pie or donut chart should be simple, data needs to be organized, and don’t put too many wedges in one chart.
Before looking for data source, there are few things about the slide which are not clear to me:

* The chart is supposed to compare predicted DB usage between 2013 and 2018. So which side is for 2013, left or right?
* The original talk was about MariaDB. For comparison, I think percentage of usage should be added for not only MySQL but also MariaDB.
* There are hundreds of different databases. Can we extend the concept of usage to other type of database?
 
![Alt text](predicted_mysql_usage.jpg "Predicted MySQL Usage")
<img src="https://github.com/tc2680/assignment_0/predicted_mysql_usage.jpg" width ="100%">

## Revision 1
Here is my revised version using a motion library from Google Charts. Because there is no exact information about other type of database usage in the original slide, I measure angles and multiply them by the total sample size of 276 to estimate usage.
<img src="https://github.com/tc2680/assignment_0/mysql_comparison.png" width ="100%">

## Future Improvement
I am interested in not only one but multiple types of database models in the market. 
I found a db ranking data source from [here][link-03]. The website have various types of comparison matrix calculated from these parameters: Number of mentions of the system on websites, General interest in the system, Frequency of technical discussions about the system, Number of job offers in which the system is mentioned, Number of profiles in professional networks in which the system is mentioned, and Relevance in social networks.
For visualization, this [example][link-04] from Junkcharts provides a good direction for future work.