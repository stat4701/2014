---
layout: post
title: Project Review -- Zijian Yi
description: Review of Project
tags: blog
---
<section>
  
### Real Time Ads User Data Stream Mining & Visualization

-------------------------------------------------------------------------------

#### My Backgroud

<li>[Real-Time Bidding (RTB)](http://en.wikipedia.org/wiki/Real-time_bidding)</li>
<li>[Retargeting](http://en.wikipedia.org/wiki/Behavioral_retargeting)</li>
<li>[Data Stream Mining](http://en.wikipedia.org/wiki/Data_stream_mining)</li>

#### My Objective

<li>To design an in-stream data analysis and visualization engine</li>

#### My Data

<li>Source: Piece of [RUN](www.runads.com)'s real-time user requests stream.</li>
<li>Volume: ~20K+ QPS (request per second)</li>
<li>Format: JSON stream from http requests</li>

#### My Tool Sets

<li>[D3.js](http://d3js.org/): The visualization tool I picked for this project, together with topojson.js, moment.js, planetary.js etc., shows impressive power in visualize data.</li>
<li>[Node.js](http://nodejs.org/): The backend server built in nodejs, it's non block event driven property together with the fast V8 compiler make it a very popular tool in building high I/O servers.</li>
<li>[Redis](http://redis.io/): The cache layer was built on redis, an in-memory key-value database with build-in data structure, perfect for caching.</li>

#### My Story

<li>[Data Engine V1]({{site.baseurl}}/2014/03/03/Zijian-Data-Engine-v1/) (Mar.3 2014)</li>
<li>Overall framework</li>
<li>Local Server & Monitor</li>
<li>In-stream Data Parser</li>
![Structure](https://raw.github.com/Arrowzeke/edav_project/master/images/engine.png)
<li>Lesson Learned: Push VS Pull: The Back Pressure Theory</li>

<li>[Data Engine V2]({{site.baseurl}}/2014/04/09/Zijian-Data-Engine-v2/) (Apr.09 2014)</li>
<li>Caching System</li>
<li>Client-Side Data Analysis</li>
![Structure](https://raw.github.com/Arrowzeke/edav_project/master/images/engineV2.png)
<li>Lesson Learned: Client Side VS Server Side</li>

<li>[Data Engine V3]({{site.baseurl}}/2014/04/30/Zijian-Data-Engine-v3/) (Apr.30 2014)</li>
<li>Server-Side Data Analysis</li>
<li>Visualize it!</li>
![Structure](https://raw.github.com/Arrowzeke/edav_project/master/images/engineV3.png)
<li>Lesson Learned: Data Binding is Painful but Powerful</li>

-------------------------------------------------------------------------------

#### My Demo

[Real Time Visualization of Ad Requests]({{ site.baseurl }}/assets/Zijian_Yi_posts_support_files/user_stats.html)

-------------------------------------------------------------------------------

#### My Future

<li>R&D on real-time clustering / classification algorithm.</li>
<li>More fun in D3.js !</li>

-------------------------------------------------------------------------------

#### My Code

[Github](https://github.com/Arrowzeke/edav_data_engine)

-------------------------------------------------------------------------------

#### MY

<li>Email: zy2194@columbia.edu</li>
<li>Linkedin: www.linkedin.com/in/zijianyi/</li>

-------------------------------------------------------------------------------

</section>
