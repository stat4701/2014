---
layout: post
title: Sprint 2 Iteration Plan
description: plan for second 3 weeks of Online Review Aggregator project
--- 

## Sprint 1 Re-evaluation

I had started off wanting to build a review aggregator for restaurants. After reading the Terms of Service of various online sources, I quickly realized I won't be able to build an 'aggregator' in its literal sense. (For example, the Yelp dataset terms categorically state that "you may not average Yelp business ratings with other providers to show an overall score.")
Nevertheless, I will still be working with the restaurant dataset. While I still don't know the exact 'title' that my visualization will take, I do know that one part of my visualization will depict the result from my Machine Learning project : "Yelp business rating prediction" (An old kaggle competition that can be found [here](https://www.kaggle.com/c/yelp-recsys-2013).). So here's my re-evaluated goal:

## Re-evaluated Goal (Not necessarily in sequential order):

* For a given zipcode visualize the most frequently used restaurant review services
* Build a visualization to predict the business rating for a given user and business.
* Visualize the 'trends' in local businesses around Columbia University using the Yelp academic dataset 

## Things I did in Sprint-1

* Spent an inordinate amount of time reviewing the various online restaurnt review sources available. Here's a partial list and what I learnt about them(I will be upadating this list as I go to better answer Goal point 1:

### Online review sources : 

| Service      	| File type or request type to get data                                         	| Other elements about the data                                                                                                                    	|
|--------------	|-------------------------------------------------------------------------------	|--------------------------------------------------------------------------------------------------------------------------------------------------	|
| Yelp         	| MapReduce, JSON zip file                                                      	| APIs, Academic Dataset for Phoenix area, Academic dataset for areas around 30 universities                                                       	|
| Factual      	| Tab separated data files, API calls using HTTP get requests                   	|                                                                                                                                                  	|
| Foursquare   	| Streaming check-in data from gnip for a price, Scrape twitter for check-ins   	| Venues in an area, check-ins                                                                                                                     	|
| OpenTable    	| No clear way to get data, Unofficial API here: http://opentable.herokuapp.com 	|                                                                                                                                                  	|
| GooglePlaces 	| HTTP requests from API                                                        	| Review summaries as part of enterprise license, Includes Zagat reviews                                                                           	|
| Tripadvisor  	| API content not publically available                                          	|                                                                                                                                                  	|
| Citygrid     	| API is the main way to communicate                                            	| Aggregates reviews from Demandforce, RatePoint, Service Magic, Judy's Book, Insider Pages and Citysearch. Used to have Urbanspoon, not any more? 	|

* From the table it is quite obvious that Yelp would be the cleanest and most straightforward way to get the kind of data I want. I won't be messing with MR just yet and have opted to go the JSON route. I went ahead and downloaded their Phoenix dataset available from the kaggle site. I have sent a request for their academic set that would be more useful for Goal 3


## Things planned for Sprint-2 : March 9th-April 5th

* Finish up code that extracts basic information from the Phoenix dataset : For example, Business_id vs check-ins, reviewer_id vs avg stars given to businesses, performance of a restaurant vs time as indicated by reviews etc. Visualize these results
* Simulate data for the business rating prediction so I can start working on how to visualize it (Modeling an actual rating predictor is going to take some time and I would like to know what exactly I want to do with it once I have that data. The simulated data should help me play around with those thoughts.)
* Either assimilate the JSON data from Yelp for Columbia or simulate some to attack Goal 3.

