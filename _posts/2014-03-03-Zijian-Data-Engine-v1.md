---
layout: post
title: Data Engine v1 -- Zijian Yi -- Blog Post 1
description: My data engine version 1
tags: blog
---
<section>

Hi Everyone,

Today I want to introduce my tidy data engine.

#### Overview

Let's start with the structure of the engine as below

![Structure](https://raw.github.com/Arrowzeke/edav_data_engine/master/images/engine.png)

The Engine includes two main components, the "requester" and the "local server". The job of requester is fetch data from remote data source and parse the raw data to internal standard format and pass to local server. Then the local server will analyze formatted data and push the results to blogger to visualize them.

-------------------------------------------------------------------------------

#### Tech Details

Now let's take a look at the tech details of each part.

##### Requester
For V1, requester send http GET request to data source's REST api, fetch .json format data, and parse them to javascript object. This is implemented in Node.js, which is a backend javascript language that fit very well for event driven web applications.

##### Local_Server
For V1, local server pick random data from static list to front-end application periodically via WebSocket. Socket.io, which is a good tool to connect the front-end app and back-end server, is embedded into Node.js server to implement this feature. The code is deployed and running on AWS EC2 cloud server.

##### D3
The us map demo below uses topojson to draw a dynamic map, and update the city names every second based on data pushed by server via WebSocket.

-------------------------------------------------------------------------------

#### Tools used in V1

<li>[D3.js](http://d3js.org/)</li>
<li>[Node.js](http://nodejs.org/)</li>
<li>[Socket.io](http://socket.io/)</li>

-------------------------------------------------------------------------------

#### Demo

[Simple Dynamic Map for US Citys use Data Engine v1]({{ site.baseurl }}/assets/Zijian_Yi_posts_support_files/map.html)

-------------------------------------------------------------------------------

#### Future Work

<li>Connect requester and local server to implement stream data analysis</li>
<li>Introduce data analysis tool to local server</li>
<li>Nicer and Cleaner D3 graph to visualize real time data analysis results</li>

-------------------------------------------------------------------------------

#### Source Code

[Github](https://github.com/Arrowzeke/edav_data_engine)

-------------------------------------------------------------------------------

</section>
