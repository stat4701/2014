---
layout: post
title: Celene - Project submission
description:
tags: blog
---
<section>
	<section>
### Update
From looking at my goals from my last Project Update, it looks like I diverged quite a bit from what I had planned to do. However, it was spurred by the discovery of our Intercom.io data, and I'm very glad I came across it. I was able to practice working with maps, filtering, and graphs in d3.js that were also really fun to visualize.

### What I did
Intercom.io tracks our (Datadog's) users, from the number of sessions logged in and the last known IP address, to location data and email address. They have an API where it's possible to pull all of the detailed information, where each entry has about 20 different fields. I worked in iPython Notebook to pull my data from the Intercom API using a very simple and effective Python package someone had written and made publicly available. Once I pulled the data, filtered out users that just signed in a few times and likely gave up (less than 10 sessions), I wrote the JSON-formatted list to a file where I declared the variable. (See code, my [edav_projects](https://github.com/celenechang/edav_projects).)<br/><br/>

My first idea was to use the location data to map our users' locations. I used examples I found online (mainly from Mike Bostock's bl.ocks page) as a template and adapted it to my data. I also wanted to make some distinction between users that logged in many times, as opposed to infrequent (or possibly now disabled) users, so I used color to distinguish users that have signed in more than 500 times. Lastly, I used tipsy.js that would show some more information upon mouseover of the points, such as city name and company ID.<br/><br/>

Next, I wanted to work with filtering the data along some of the many dimensions. My goal was to have different filters that are selectable above the map, and one could view the map points based on a variety of parameters. For instance, show the users that were created in 2014, logged in more than 600 times, and used Chrome. I got stuck during this operation, mainly because of the complexity in adding/clearing filters on select dimensions, and on getting the buttons to be dimensionalized themselves. I have an idea of how to work around this, but at this point I wasn't able to filter by more than one dimension (year user account created).<br/><br/>
![]({{ site.baseurl }}/assets/celene_assets/datadog-map.png)<br><br>
Lastly, I used crossfilter and dc.js to plot the data over different dimensions. One can see interesting trends such as the number of users signed up over time (on a weekly basis), number times a company (a collection of users) signed in to Datadog, and the proportion of users from different continents.<br/><br/>
![]({{ site.baseurl }}/assets/celene_assets/datadog-graphs.png)<br><br>

### Observations
I found it interesting that we have quite a significant userbase in Europe. Even though our founders are from France, they have been in the States for a long time and the entire operation was in the US until a few weeks ago (that is, one person is now working from Europe). It is apparent that the founders were able to leverage their European connections quite well.<br/><br/>
The user signups graph is also really neat to see. While we "knew" that trade shows were an effective way for us to reach customers, the plot shows how effective the Amazon Web Services annual week-long conference in Las Vegas is in producing signups - the large peak corresponds to that week. Likewise, the plot shows the impact of the Christmas/New Year's holidays in slowing down signups. What's also interesting to note is that there seems to be a roughly monthly or 6-week cyclic pattern to signups. I'm not sure the reason for this yet, but it'd be neat to see what those weeks correspond to.<br/><br/>


### Next steps
1. I'd really like to work on having multi-filtering on the map, that's probably the most interesting goal for me at the moment.<br/><br/>
2. Also, I have plans to incorporate Desk data (my original project idea) and other data such as revenue, company size, host count, and so on. With this other data I'd be looking for trends and possibly look into prediction algorithms. For instance, does size and number of support cases submitted increase the likelihood of a signup? This is quite ambitious, I think, but worth the while from a personal stance as well as my company's.



</section>
</section>
