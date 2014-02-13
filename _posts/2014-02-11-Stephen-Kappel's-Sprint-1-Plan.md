---
layout: post
title: Sprint 1 Iteration Plan
description: plan for first 3 weeks of forums project
--- 

## Sprint 1 Goals

For the first three weeks, I plan to focus on data collection and cleaning. I want to get all my required data points into an SQL database to allow future sprints to focus on data exploration and visualization. I am very comfortable with working with data in SQL Server and SQL plays nicely with other data tools, so I believe getting the data into the platform will minimize the number of blockers I face going forward. 

In particular, the items which I want to accomplish in the next three weeks are:

1. Scrape data about the following objects from the MSDN website into SQL Server: forum categories, forums, threads, comments.
2. Attain similar data to above about CA Communities forums. I may be able to attain this directly from an internal reporting database, or may have to screen scrape it from the web site.
3. Create views that help aggregate the attained data in a meaningful way.
4. Decide how much data to pull based on size of data. Perhaps limit scope to a particular subset of forums on each site. Perhaps pull data for a random sampling of threads over the past year, or perhaps pull data for all threads in the past n months.

## Progress

I have created a Python project in PyCharm to start with MSDN scraping. I have attained a list of all (over 1000) MSDN forums and their categories. I'm beginning to work on scraping a list of threads.

My work (with the exception of the database itself) is saved to [GitHub](https://github.com/StephenKappel/dataology/tree/master/Forums_Project).