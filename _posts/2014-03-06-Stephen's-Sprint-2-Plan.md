---
layout: post
title: Sprint 2 Iteration Plan
description: plan for second 3 weeks of forums project
tags: project iter2
--- 

## Sprint 1 Retrospective

My main push in sprint 1 was data collection and organization. This was mostly successful. I wrote and executed Python code to scrape data from all threads created during 2013 on any of MSDN's English Language forums for SQL Server or SharePoint. I chose these forums because I have personally posted to some of these forums and have good deal of familiarity with the products.  This data set includes 73,843 threads with contributions from 34,387 distinct users, yielding a database of 175 MB.

With this data in the database, I created two views to assist in pulling data into R for further visualization and analysis. (By "views" I am referring to database view/virtual tables - not any sort of visualization of the data.) The two views and a sampling of their columns are below:

Forum_Summary

- Forum ID
- Forum name
- Number of threads
- Number of unique contributors
- Average contributors per thread
- Average contributor points (reputation)
- Number of answered threads
- Average answers per thread
- Average time to first response
- Average time to first answer
- Average number of thread subscribers
- Average question length
- Average title length
- Number of threads with MSFT employee involved
- Number of threads with MSFT partner involved
- Number of questions containing code

Thread_Summary

- Thread ID
- Forum ID
- Title
- Title Length
- Number of subscribers
- Number of views
- Answered?
- Time of original post
- Time of first answer
- Time to first reply
- Time to first answer
- Number of posts
- Number of posts with code
- Number of posts by MSFT employee
- Number of votes
- Number of votes for MSFT employee contributions
- Average points (reputation) of contributors

I did gain access to CA's Communities reporting database, but have not yet pulled the data from it. I have concentrated on the Microsoft data, and figure that I can easily adapt the same analysis for CA data once I have make progress with Microsoft's data.

## Looking Forward to Sprint 2

In this coming sprint, I will be loading data into R and creating simple visualizations to begin understanding the data better. My first cuts will be to compare characteristics between forums (perhaps with small multiples), look for trending over time (perhaps cyclical/seasonal trends), and determine whether or not having a MSFT employee on a thread or code snippets being included in the thread make any notable difference in the thread's metrics. The specific areas I dive into deeper will likely depend on what I do or don't see in my initial graphs.

Also, I will work on putting together metrics and visualizations to understand dynamics between community members. Can key influencers be picked out from the crowd? Do certain members seem to often get involved in the same discussions? How many users span several forums and to what extent? Other than contribution volume, are there any characteristics that make 4 and 5 star contributors stand out from 1 and 2 star contributors? 

## My Source Code

My work (with the exception of the database itself) is saved to [GitHub](https://github.com/StephenKappel/dataology/tree/master/Forums_Project). Comments/questions are welcome!