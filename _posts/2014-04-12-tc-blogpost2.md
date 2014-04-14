---
layout: post
title: Tommie's Blog Post 2
description: To Pie or Not To Pie
tags: edav blogpost 
---

### Intuition - It's All About Pie
I choose this topic because of Mike's suggestion in the class. Since I am not a fan of pie or donut chart, this blog post is set to be an interesting exercise from the beginning.

### Data Munging or?
After picking up a topic, the next step is to find out what data I want to present or find a bad chart for improvement. 

### The Story Came In The Right Time
[link-01]: http://image.slidesharecdn.com/mariadb-10-131217154438-phpapp02/95/slide-45-1024.jpg?cb=1387317230
[link-02]: http://flowingdata.com/visualize-this/
[link-03]: http://db-engines.com/en/ranking
[link-04]: http://junkcharts.typepad.com/.a/6a00d8341e992c53ef01a51184b1f8970c-pi
[link-demo]: http://tc2680.github.io/assignment_0/blogpost2_rev1.html

Recently I received a request to research and compare usage of open source database engines. I did not have much experience in this area except few toy practices in MySQL database. So I decided to look at MySQL first. After some initial studies, I came across a presentation about [Maria DB][link-01]. One of the slides from the presentation was trying to discuss future usage of MySQL. 

<img src="http://tc2680.github.io/assignment_0/predicted_mysql_usage.jpg" width ="600">

According to Nathan Yau, the author of [Visualize This][link-02], pie or donut chart should be simple, data needs to be organized, and don’t put too many wedges in one chart. Before looking for the data source, there are few things about the donut chart which are not clear to me:
* The chart is supposed to compare predicted DB usage between 2013 and 2018. So which side is for 2013, left or right?
* The original talk was about MariaDB. For comparison, I think percentage of usage should be presented for not only MySQL but also MariaDB.
* There are hundreds of different databases. Can we extend the concept of DB usage to other type of database?
 
### Revision 1
Here is my revised version using the motion library from Google Charts. Because there is no exact information about other type of database usage in the original slide, I measure angles and multiply them by the total sample size of 276 to estimate database ranking. You can see the [motion chart][link-demo] here.
<img src="http://tc2680.github.io/assignment_0/mysql_comparison.png" width ="600">

### Future Improvement
I am interested in not only one but multiple types of database models in the market. I found a database ranking information from [here][link-03]. The website have various types of comparison matrix calculated from these parameters: number of mentions of the system on websites, general interest in the system, frequency of technical discussions about the system, number of job offers in which the system is mentioned, number of profiles in professional networks in which the system is mentioned, and relevance in social networks. For visualization, this [example][link-04] from Junkcharts provides a good direction for future work.