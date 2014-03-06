---
layout: post
title: FWC Project - sprint 2
description: Project status
tags: iter2
---

**Team Members:** Shiya Wang (sw2876) and Andrew Yuan (agy2108)

###Abstract
With the kickoff of the 2014 Brazil World Cup fast approaching, soccer fans Shiya and Andrew are obsessed with question to which every soccer fan on the planet is dying to find out the answer: Who will capture the coveted trophy? What makes the waiting less unbearable for us is our grand scheme to use the tools that we are learning in the data sciences program at Columbia to tackle the million-dollar question before the games even start. We are going to build a mathematical model that predicts each team’s likelihood of advancing into the next phase and eventually capturing the championship. Sounds ambitious? Yes, and below is how we break down this daunting task into manageable bits and pieces. 

###Method
We will extract the rankings of all FIFA teams and the scores of all the past games from the official FIFA website. There are a number of ways that we will experiment with and analyze the data. For instance, we will investigate the relationship between two teams’ rankings and the likelihood of one team eliminating or being eliminated by the other. We will take each team’s historical score into consideration as well, with more weight placed on the games that took place closer to 2014. We are also interested in learning and visualizing the relationship between a team’s score and its ranking with respect to another team. 

###Timeline
Our project is divided into 4 sprints. The dates, duration, and responsibilities for each sprint are indicated in the following graph.


###Sprint 1
* Scrapped 41.444 Fifa official matches scores from 408 pages of data from the fifa.com since 1930.
* Scrapped 46.842 Fifa ranking positions for 215 different countries since 1993 (ranking is updated on a monthly basis roughly).

###Sprint 2
* Analyze correlation between the data (wins/losses, opponent ranking position, game location, etc)
* Define potential predictive model

![Project Timeline]({{ site.baseurl }}/assets/FWC/EDAV-FWC-Timeline2.png)



