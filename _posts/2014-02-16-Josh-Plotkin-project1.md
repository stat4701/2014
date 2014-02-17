---
layout: post
title: Big Picture Plan (Josh Plotkin)
description: First crack at structuring project
tags: project
---

**Background:** I like the image below (credit: Joel Grus), which is a parody on a more famous Drew Conway Venn diagram. I think the IDSE is doing a good job of covering us with the hacking skills and math/statistics skills. A big reason I hope to gain admission to the MS program is so I can take electives to build substantive or domain expertise. When brainstorming for this project I asked myself "where do I have domain expertise" and the obvious answer is with poker. My project will involve slicing and dicing a database of around 10 million poker hands. I like this idea because I think there are many directions I can go in, and it will require many different stages of work.


![Data Scientist]({{ site.baseurl }}/assets/jsp2014/venn.png)

**Structure:** 

0. Project management - I was involved in an early stage startup last year and we used a project management tool called Kanbanery. I liked that quite a bit and will use that to manage the many pieces of this project.

1. Data gathering

* I currently have a database of around 10 million hands. The vast majority of these hands are data mined and we don't know the cards any of the players had. 

* I am considering crowdsourcing a second database to analyze the profit for certain cards in certain situations.

* The hands sit in a database created by a program called Holdemmanager2. It is possible to export to csv, however it is slow. I might have to use SQL to gather all the data that way.

* Data using strategy simulation software, CardrunnersEV.

* Data using probability simulation software, Odds Oracle.

* Goal: Try to tie in the models from each of the 3 sources.

2. Data munging/wrangling

* I have been reading the book Python for Data Analysis. Python will be my tool of choice for this part of the project.

* There is no question R is an essential tool for an aspiring data scientist. I want to use this project to gain competence with R as well. This might have to happen in a later stage (either ggplot2 or for regression/clustering stage)

* Put data in form to be plotted quickly using matplotlib

3. Exploratory data analysis and basic plots

* Exploitive strategies - in which situations does the average (mean) player make large errors? Start general, and drill down into specific situations to do with position and board. Example: test my running theory that coordinated board textures benefit the in position player more than dry boards.

* Hole Card data - if I am able to crowdsource a large enough sample, I can test for certain hands in certain situations and determine the profitability.

* Simulated game theory strategies - I will have to explain more later in the project, but I would like to investigate the 4-bet pot CardrunnersEV simulation and visualize with error bars. This is a project I started over the winter but haven't finished. I generated a lot of raw data that I haven't analyzed. I can test this against my theory that flatting 4-bets (I will take some time to explain the situation more) is more profitable than the majority of people realize.

* Odds Oracle data - test my theory about the correlation between equity and profit. Test a number of range vs. range scenarios based on different board textures, using the 12 classes I've created.

* Plot each of these attempts, even if they lead to nothing. These will be scatter plots and histograms. Draw regression lines if appropriate.

* Removing bias will be critical. When comparing groups of players, I must try to make sure the relative skill level (overall winrates) of the players are similar.

* Running Lit of Analysis Ideas:

- profability of calling 4-bets

- minraise vs. 2.5x vs. 3x opens

- plot board texture vs. position using empirical data

- plot board texture against range vs. range using Odds Oracle data

4. Data Visualization

* First draft of graphs will be in my default language, python.

* Goal/Challenge: take some of the best findings and put them into d3 to enable interactivity.


5. Statistical analysis

* Apply regression, clustering, and modeling histograms according to a normal distribution.

* Build prediction models. Potentially leave out 10-20% of the database and use it as a test set.


6. Rinse and repeat

* This is not a linear path. I might need to go back to the well for more data, test new ideas, and keep digging for interesting information. I have never taken this approach before, it is wide open, and it's important that I don't restrict myself early on.


TODO Iteration 1:

* Extract data using Holdemmanager2. Figure out of SQL is necessary and extract some data this way if it is.

* Push through Python book

* Keep a running list of ideas for data analysis




