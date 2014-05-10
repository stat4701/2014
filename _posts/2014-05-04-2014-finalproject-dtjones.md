---
layout: post
title: Final Poject: Social Listening Software
description: 
tags: finalproject, dtjones
---

#Context
I laid out my ideas & goals for the project in detail in [my first blog post](http://malecki.github.io/edav/2014/02/18/project-plan-1-dtjones/) but in summary, the goal of my project is to glean insight into social conversations around a brand. There are a handful of firms that provide a similar service currently, such as Radian6 who was acquired by Salesforce. Most of the methods sold today are based on sentiment analysis.

Based on my goals and guidance from Professor Malecki, I worked with Python to pull data from the Twitter API and processed this data with Latent Dirichelet Allocation. LDA is a machine learning NLP technique that models the posterior probability of a word occurring in a topic, given an input corpus and a specified number of topics. LDA stands out for this use case because it organizes an overwhelming amount of data and is still interpretable by a business user or decision maker.  

#Data
There is an overwhelming amount of documentation and libraries to access any of Twitter's APIs (they have 3 that I know of). For the purposes of my project, the Search API seemed like the best choice. It took a few tries to successfully call the API because of OAuth, and I'm still experiencing some rate limit issues that I need to investigate. Fortunately I was able to I write a [Python script](https://raw.githubusercontent.com/devintjones/twits/master/scripts/twits4.py) with the library Tweepy to call the API and write the data to a csv. I experimented with a search on the twitter handle @Tide, the flagship brand of the world's largest advertiser Procter & Gamble. 

After, I formatted the data so that I could pass it through LDA via the Python library gensim. This included removing commonly used words and characters that added noise to the model, as well as 'tokenizing' via nltk (not entirely sure what this does) and creating an ID to word mapping dictionary. From there I had to process the output of the model into a format I could visualize - I first went to csv and poked around R to see if I could do anything, but these csvs weren't very engaging for an R visual. [Here is the second Python script](https://raw.githubusercontent.com/devintjones/twits/master/scripts/lda2.py)

I found a D3.js [example](http://bl.ocks.org/mbostock/4063530) that I thought could suit my data well. The example uses a json file that seemed to be nested with the d3 nesting function. I dumped my data to a json in Python but it wasn't the right format for the circles template - I ended up building a string by looping through the data to create the [json file](https://raw.githubusercontent.com/devintjones/twits/master/scripts/topicsfinal.json) in the same format as the example. 

#Chart

[Here is a link to a demo of the chart](http://bl.ocks.org/devintjones/raw/ef5f6b4d6711da2c7022/)

Each big circle is a topic, and the size of the orange circle corresponds to the posterior probability that the word will occur in the topic. I added some transitions and would like to make it more interactive. 

#Interpretation
In looking at the visualization, we can see that Tide occurs in every topic. This is expected becasue it was the search term. There are also a number of topics that include the word "tiderelascate" which is a hashtag that corresponds to a new oxy clean type of detergent. We can also see a celebrity endorsement from Monica Benavidez occuring in 2 topics, a few that mention spring cleaning & coldwater, a twitter chat, and one topic that includes Nascar and Dale Jr. 

The information above is valuable to a brand manager, communications planning, public relations, social media management, or creative agency. Any of the groups could potentially change their strategy or investment based on the information. Keep in mind that richer topic information could be gleaned if I searched near the time of a sponsored event such as the Super Bowl or the Grammys. 

#Next steps
LDA does not provide a size or importance measure for topics. I would like to manipulate a word frequency count for the words in the topics to include as parameters for the size of the topic level bubbles. 

Additionally it would be great to include an interactive search bar to create these results in real time. The software I built runs in under 20 seconds without any distributed computing, which is a reasonable time to wait for this type of analysis. 

I would also like to explore a competitive analysis tool using this data - I could compare the usage of words when people talk about Arm & Hammer versus Tide detergent for example. 

[Here is a link to my project repository](https://github.com/devintjones/twits) 


<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->