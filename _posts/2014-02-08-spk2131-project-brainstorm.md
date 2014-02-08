---
layout: post
title: Project Brainstorm - Software Forums/Communities
description: My initial thoughts on exploring the effectiveness of forums for my EDAV project
--- 

## Objective

Working in the support organization of a software firm, I see the significance of "deflecting" issues through the use of self-help  tools, one of which is forums/communities. Having customers use forums is preferable to having customers open support tickets, because:


- Customers are more satisfied if they can solve a problem without having to open up a support ticket with the vendor.
- Solutions become documented in a place accessible to all customers, unlike support tickets, which are only accessible to the software vendor and a single customer.
- By exposing the question to more minds, the likelihood that someone having seen the same problem before and being able to produce a quick answer is greatly increased.
- The software vendor saves time and money by allowing engineers to focus on the tougher issues (software bugs, complex configurations, etc.) and new development, rather than time being spent on answering the easier questions that can be solved with a search of forums or a post on the same.

Through my project, I hope to gain better insight into (a) general patterns of behavior in how users interact with forums, (b) what makes a forum (in general) or a particular post on a forum successful or unsuccessful, and (c) where may there be room for improvement in general forum design or in the management of particular forums.

## The Data Points

I would like to collect forum data from at least two different vendors. As a start, I'd like to look at [Microsoft's MSDN forums](http://social.msdn.microsoft.com/Forums/en-US/home) and [CA's communities]( https://communities.ca.com/web/guest/community-directory). It should be possible to collect the necessary data by screen-scraping these sites.

Here is an initial list of data and metrics that can be collected from the sites and which might be able to provide useful insight:


- First post timing:
 
 - Day of week
  
 - Time of day
 
 - Month
- Quantity of Participants
 - Total
 - Employees
 - Moderators
- Participant reputations
 - Asker
 - Average of all respondents
 - Answerer(s)
- Forum
 - Name/Product
 - # of members
 - Creation date
- Keywords in:
 - Thread title
 - Question
 - Responses
- Time between posts
 - Average
 - Time to first response
- Length (in chars or words) of:
 - Thread title
 - Initial question
 - Responses
- Ranking/reputation of: 
 - Asker
 - Other participants
- Speed of response
 - First response
 - Average time between all messages
- Success Status
 - Success = marked completed
 - Failure = no post for 1 month and not marked solved
 - Active = not marked completed, but  last post  in less than one month
- # of up votes
- # of thread views
- # of links to:
 - other threads or documentation
 - this thread from other threads
 - # of comments/responses on the thread

## Project Tasks

The main tasks in completing this project will be:

1. Collect the data by screen scraping the web pages (most likely with Python) and write it to some data store (possibly a SQL database, noSQL database, or a flat csv or json file).
2.  Process the data to aggregate it and find desired metrics. I am most comfortable with SQL and C#, so I may use these tools too complete this task.
3.  Export the aggregated data and metrics to a CSV.
4.  Import the CSV into R and do some exploratory analysis to find correlation and interesting relationships.
5.  Create a visualization showcasing and allowing further exploration of the most interesting data points and relationships using D3.js and possibly Crossfilter.