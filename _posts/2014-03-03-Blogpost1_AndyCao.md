---
layout: post
title: AndyCao’s Blog post #1
description: Visualizing market cap and price data
tags: Blogpost1
---


## Visualizing Stock Data

### Background:

Facebook recently turned 10 year old. Bloomberg BusinessWeek published a feature story with exclusive interview with Mark Zuckerberg on their February 3 issue. [Facebook Hits Puberty](http://www.businessweek.com/articles/2014-01-30/facebook-turns-10-the-mark-zuckerberg-interview#p4). It’s an interesting article, but for the purpose of this post, I want to focus on a graph they had toward the end of the article. The graph is titled “Racing to $150 billion”. It was meant to show that among all 26 public companies that ever reached the $150 billion market capitalization, Facebook is the fastest to achieve the milestone. 

I didn’t like the way that BusinessWeek grouped all the companies together in a line graph, I found it containing too much noise. And I think the printed version is actually worse than the web version. Some of the problems with the graph are: 

* Each company’s market cap fluctuated greatly over the years, with all the tech companies highlighted black, it’s hard to observe clearly the path of each of these companies.
* The black lines overlay on top of all the grey lines that represent the non tech companies, which makes the graph even more clutter and hard to read. 

[[](http://daylifeimages.newscred.com/imageserve/eee3899422df0397c7578b392bb1d155/630x418.jpg)](http://images.businessweek.com/slideshows/2014-01-29/facebook-growing-up#slide9)

Although the web version of the table solved some of the problem with d3, I believe there is a better representation out there. 

### Alternative Graph:

The alternative approach I came up with is using a motion chart. The motion chart is made famous by Professor Hans Rosling of Gapminder Foundation. Ever since I first watched one of his many TED talks a couple of years ago, I’ve been fascinated by Professor Rosling’s passion, knowledge and the incredible ability to explained complicated issues using easy to understand data visualization. [Click here](http://www.gapminder.org/videos/hans-rosling-ted-talk-2007-seemingly-impossible-is-possible/) to watch one of his talks.

My idea was to show the market cap information in bubbles of varies sizes. The current market cap leader in the US, Apple, would have the largest bubble; and other companies would have smaller bubbles. I also wanted to bring in stock price as another variable to map against the market cap data. And I decided to collect data on only the major tech companies in the original report, plus LinkedIn to make the graph cleaner. LinkedIn is included as a close comparison of social networks. Technically, Twitter might be a better comparison. But due to the short time that the company has been public, I feel there is not enough financial data about Twitter for a fair comparison. 

Because I’m only collecting yearly data for 9 companies from 2000 to 2014, I decided to manually scrap data from [quandl.com](www.quandl.com) and other popular finance news sources on the web (ex. [Google Finance](https://www.google.com/finance), [Yahoo! Fiance](http://finance.yahoo.com/)). I was only able to find BOTH market cap and stock price data dated back to 2000. The BusinessWeek report used data from 1980s to 2014, but without access to Bloomberg’s financial database, data from 2000 to 2014 is the best I can do at this point. 

Nathan Yau pointed out in his book that Google Spreadsheet has the motion chart builded in, which saved me A LOT of time. Gapminder also has a [quick guide](http://www.gapminder.org/upload-data/motion-chart/) to generating motion chart in Google Docs . I followed the instruction and came up with the graph below:

[motion chart](https://docs.google.com/spreadsheet/pub?key=0Avua6Uc6MQkTdFVEQVVCellQY2xoaFRUM3lDQVg3ZHc&output=html) (won't embed)


The X axis is stock price, the Y axis is market cap. The companies are represented by circles in the middle, with various size depend on market cap. The time line is at the bottom of the graph, so the reader can click on the play button to see the progression from 2000 to 2014, or can move the scroll to any specific year. I also arbitrarily separate the 9 companies into two groups: Hot Cakes vs Old Guards. Blue represents the more popular stocks now: Apple, Google, Amazon, LinkedIn and Facebook; and green represents more of the industry stewarts: IBM, Microsoft, Intel and Cisco.


In my opinion, the resulting graph is a lot cleaner compared to the line graph in the BusinessWeek article. But one major pitfall of using the Google Chart Tools is that the $150 billion threshold that the article emphasis is not very appearance in the new graph. So there is definitely trade off. I might consider recreating the graph using R or Python for Blog post #2, as well as bringing in the other non-tech companies and draw a line over market cap of $150 billion.






 