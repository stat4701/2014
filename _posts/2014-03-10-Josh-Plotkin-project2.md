---
layout: post
title: Cleaning up the original "Big Picture Plan" and updating progress (Josh Plotkin)
description: Getting more focused
tags: project iter1
---

**Background:** I like the image below (credit: Joel Grus), which is a parody on a more famous Drew Conway Venn diagram. I think the IDSE is doing a good job of covering us with the hacking skills and math/statistics skills. A big reason I hope to gain admission to the MS program is so I can take electives to build substantive or domain expertise. When brainstorming for this project I asked myself "where do I have domain expertise" and the obvious answer is with poker. My project will involve slicing and dicing a database of around 10 million poker hands. I like this idea because I think there are many directions I can go in, and it will require many different stages of work.


[![Data Scientist](https://raw.github.com/joshplotkin/edav/gh-pages/assets/jsp2014/venn2.png)](https://raw.github.com/joshplotkin/edav/gh-pages/assets/jsp2014/venn2.png)


**Structure:** 

0. Project management - I ended up going with Asana.com, which I like due to its simplicity. 

1. Data gathering

	* Database of hands moved from HoldemManager2 to Pokertracker4, as PT4's database schema is open, whereas HEM2's is not.

	* I have crowdsourced about 2 million hands so far, though I am going back and forth on how fruitful this approach will be, for various reasons, mostly related to bias. I'm learning toward not using it.

	* I have learned SQL and have made some basic queries. The queries have been slow (blocker). Per Mike's suggestion, I have found a Python interface for PostgreSQL called psycopg.

	* I have begun to generate some data via the simulation software used last time. In the event the slowness of the SQL queries becomes prohibitive, the project will move on to using these instead. Ideally, I'd like to use both.

	* Goal: Try to tie in the models from each of the 3 sources (database and 2 simulation programs)

2. Data munging/wrangling

	* Python is still my tool of choice. I have improved my competency significantly since the last update (I had minimal exposure to it prior to this class)

	* I spent a lot of time with ggplot2 in blog post 1, and feel very comfortable with it. It will be my default visualization tool.

	* Goal: for my favorite 1-2 findings, plot them interactively with d3 or possibly something less complex (Bokeh?).

4. Statistical analysis

	* Regression and clustering will be the most useful approaches for this.

	* Build prediction models. I have left out 20% of the data for validation. I don't anticipate going too far down this rabbit hole, given time restriction though I hope to get some experience in doing this (I have a bad habit of getting over-excited and biting off more than I can chew).

3. Exploratory data analysis and basic plots

	* Since my last update, I have thought about how I want to approach this, and decided a good idea is to break the game down into dimensions:
		* Street
			* e.g. best cards that can come for one player, given a certain board classification, in a given situation (do I have enough data?)
		* Board texture/classification
			* For classifying these, run a clustering algorithm for profit by position
			* Compare these clusters across different dimensions
		* Stack/Pot Ratio
			* vs. positional dimension
			* types of strategies that seem to be profitable (i.e., given an identical situation, how does something like raise% (or went to showdown%, etc.) compare to winrate.)
			* try to find successful deep stack strategies
		* Action leading up to this point
			* In which situations is being the last aggressor not as profitable?
		* Equity vs. Potential
			* only possible with crowdsourced data
		* Positions
			* can I generate a method for finding out which strategies are successful from some seats, e.g. the blinds? (danger of introducing too much selection bias)
			* which are the best situations to get into? worst?
		* Player types
			* can I classify players and find their weaknesses? 
		* Bet sizing
			* preflop raise sizing
			* effectiveness of large postflop bets. vs small ones
			
	* On measurement: winrate is really the only measure that makes sense to me for most of these analyses, measured in big blinds (easily converted to $) per 100 hands. This is a very large amount of uncertainty in the game, and the purpose of the large database is so I can drill down deep enough into situations without winding up with samples that are far too small.

	* Previous ideas:
		* Exploitive strategies - in which situations does the average (mean) player make large errors? Start general, and drill down into specific situations to do with position and board. Example: test my running theory that coordinated board textures benefit the in position player more than dry boards.

		* Hole Card data - if I am able to crowdsource a large enough sample, I can test for certain hands in certain situations and determine the profitability.

		* Simulated game theory strategies - I will have to explain more later in the project, but I would like to investigate the 4-bet pot CardrunnersEV simulation and visualize with error bars. This is a project I started over the winter but haven't finished. I generated a lot of raw data that I haven't analyzed. I can test this against my theory that flatting 4-bets (I will take some time to explain the situation more) is more profitable than the majority of people realize.

		* Odds Oracle data - test my theory about the correlation between equity and profit. Test a number of range vs. range scenarios based on different board textures, using the 12 classes I've created.

		* Plot each of these attempts, even if they lead to nothing. These will be scatter plots and histograms. Draw regression lines if appropriate.

		* Removing/modeling bias will be critical. When comparing groups of players, I must try to make sure the relative skill level (overall winrates) of the players are similar.

		* Running List of Analysis Ideas:

			- profitability of calling 4-bets

			- minraise vs. 2.5x vs. 3x opens

			- plot board texture vs. position using empirical data

			- plot board texture against range vs. range using Odds Oracle data


5. Presentation
	* It is going to be a challenge to describe the data without spending much time on the game and the rules. 
	* Per Mike's suggestion, I think a good approach to this is explaining the biggest challenge: the bias caused by hidden information and this post hoc analysis. How will I choose my groups so that the data are meaningful.




Blockers: the SQL queries have been exceedingly slow (the database is 39.7 GB). Fortunately, I have some other things I can work on if this falls through, however I will be disappointed if I can't take this approach.


Review of TODO Iteration 1:

	* Extract data using Holdemmanager2. Figure out of SQL is necessary and extract some data this way if it is.
		* I have moved the data to PT4 and determined that for most things, SQL will be necessary.

	* Push through Python book
		* When I was progressing through the book, I realized my lack of Python experience was prohibitive. Now that I'm more comfortable with the language, I'll pick this backup.

	* Keep a running list of ideas for data analysis
		* These have been included within this post.

TODO Iteration 2:

	* Run the necessary queries and simulations and generate the data so I can start the fun parts.
	* Continue to develop ideas.
	* Do a better job of keeping up with the project management.




