---
layout: post
title: Stephen's Blog Post 3
description: Visualizing MSDN Forums Data
tags: blogpost
---

As mentioned during my project presentation, for the 3rd blog post, I am working on creating an interactive d3/crossfilter visualization of the MSDN Forums data that I collected and explored for my project. The visualization is still a work in progress, but the concept is this:

- In my dataset, I have data describing each of some 74,000+ threads. I would like to allow the visualization's users to be able to drill down to view the details about any of these threads, and there should be a link for each thread from the visualization to the actual thread in MSDN. To efficiently deal with data of this size in the browser, I will be using crossfilter.js.
- Because the data is split between two distinct product -- SQL Server and SharePoint --  and comparison between the two may be insightful, the visualization will show the metrics for both products side-by-side (rather than forcing the user to choose between one or the other).
- Features of the dataset to be exposed by the visualization will include time to first response, time to first answer, answered (yes/no), thread creation timing (month, day of week, and time of day), title length, question length, and # of reputation points of the question's asker.
- Inspired by the crossfilter example [here](http://square.github.io/crossfilter/), I will show most of the features in histogram-like charts at the top of the screen and show the specific thread details underneath.

Once the visualization is completed, I will update this blog post with the details, and I will publish my work to my project's GitHub repo.