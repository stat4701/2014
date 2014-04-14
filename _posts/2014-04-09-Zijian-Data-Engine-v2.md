---
layout: post
title: Data Engine v2 -- Zijian Yi -- Blog Post 2
description: My data engine version 2
tags: blog
---
<section>
  
Data Engine version 2 released ! 

#### Release Log

[Data Engine V1]({{site.baseurl}}/2014/03/03/Zijian-Data-Engine-v1/) (Mar.3 2014)
<li>Overall framework</li>
<li>Local Server & Monitor</li>
<li>In-stream Data Parser</li>

Data Engine V2 (Apr.09 2014)
<li>Caching System</li>
<li>Client-Side Data Analysis</li>

#### What's new in this version

Seeing is believing

![Structure](https://raw.github.com/Arrowzeke/edav_project/master/images/engineV2.png)

This version added two more components to Data Engine, "caching system" and "client side data analysis". There are two reasons that we need a caching system. First of all, the traffic may be too much, especially in peak time, for the server to handle in real time. Instead of flooding the server and turning out slow response time, we store real-time requests temporarily in a fast caching layer, and let server to pull from this pool when needed. The other reason for the caching layer is that usually we don't want to process every single request, but a simple statistical result of the data. In my case, I stored the aggregation of same user requests into the caching layer to reduce the work load. While the data analysis piece is between the formatted data and the dynamic graph, in version 2, it's in client-side and counts the number of users in each category. There are some concerns about client-side VS server-side data analysis. Client-side analysis is easy and flexible, by send raw data to client and push the work on clients' machine, the work load in central server reduced and the client side applications can grab any information they need, however, client-side analysis cannot be computation intensive and need more network bandwidth to send the full set of raw data; on the other hand, server-side analysis could be complex and powerful, and only send final result out to the network. 

-------------------------------------------------------------------------------

#### Tech Details for the new add-ons

##### Caching System

Use redis, which is an crazy fast in-memory database, to store requests and counts as key-value. 

##### Data Analysis

Script to accumulate number of users in different categories and store into an object.

##### D3

Dynamic pie chart with legend.

-------------------------------------------------------------------------------

#### New Tools used in V2

<li>[Redis](http://redis.io/)</li>

-------------------------------------------------------------------------------

#### Demo

[Ads user info visualization demo using Data Engine v2]({{ site.baseurl }}/assets/Zijian_Yi_posts_support_files/user_info.html)

-------------------------------------------------------------------------------

#### Future Work

<li>Working on server side data analysis using more powerful algorithm</li>
<li>Learning different types of graphs in d3.js</li>

-------------------------------------------------------------------------------

#### Source Code

[Github](https://github.com/Arrowzeke/edav_data_engine)

-------------------------------------------------------------------------------

</section>
