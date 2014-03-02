---
layout: posts
title: Visualizing data - A contrarian view
description: Assignment 1 - Reimagining City Population data
Tags: assignment KISS minimalistic visualization not chartoons
---

#### The Premise
* This post continues from assignment0 and visualizing the city population data differently and in the bargain derive some 'points to ponder' for future visualization exercises.  Its reasonable to question the choice of the data set.  After all its been 'revisualized' by the class many times over.  My choice of the data set was deliberate.  
* My objective in this post is not to find new insights into the data but to use it to make some salient on the use and abuse of feature rich (read code heavy and visually complex) graphs in general. 
As this may be a little controversial, I wanted to choose data that was familiar to all us to facilitate an understanding of my point of view on visualization.

#### The purpose of data visualization
Purpose of graph and data visualization, as per Tukey (1993), is to describe, compare, make an impact and report the results of data analysis. 

Its different from information graphics

Strength and Weaknesses of the current trend

A balanced approach

High priesthood of data scientists and analysts
A come not to praise Ceaser but to burry him

#### Methodology
For Exploratory Data Analysis and Visualization (EDAV), Philip Guo's work on [Data Science Workflow: Overview and Challenges](http://cacm.acm.org/blogs/blog-cacm/169199-data-science-workflow-overview-and-challenges/fulltext) is very helpful.  
It not only lays down the steps but also gives a preview of the potential challenges and rela world options to overcome them.  In a nutshell, the workflow is visualized as follows:
## Workflow
[![](http://cacm.acm.org/system/assets/0001/3678/rp-overview.jpg)](http://cacm.acm.org/blogs/blog-cacm/169199-data-science-workflow-overview-and-challenges/fulltext) (note the redirect!)



Visualization Goals
1. Graphics are for the qualitative/descriptive—conceivably the semiquantitative—never 
for the carefully quantitative (tables do that better). 
2. Graphics are for comparison—comparison of one kind or another—not for access to 
individual amounts. 
3. Graphics are for impact—interocular impact if possible, swinging-finger impact if that 
is the best one can do, or impact for the unexpected as a minimum—but almost never for 
something that has to be worked at hard to be perceived. 
4. Finally, graphics should report the results of careful data analysis—rather than be an 
attempt to replace it. (Exploration—to guide data analysis—can make essential interim 
use of graphics, but unless we are describing the exploration process rather than its 
results, the final graphic should build on the data analysis rather than the reverse.) 

Exploratory Data Analysis goals: 
- Giving an overview—a qualitative sense of what is in a dataset, checking assumptions, 
confirming known results, looking for distinct patterns. 
- Conveying the sense of the scale and complexity of a dataset. For example, graphs of 
networks notoriously reveal very little about underlying structure but, if constructed well, 
can give an impression of interconnectedness and of central and peripheral nodes. And 
maybe that is the point. The picture tells the story as well as, and in less space than, the 
equivalent thousand words. 
- Exploration: flexible displays to discover unexpected aspects of the data; small multiples 
or, even better, interactive graphics to support making comparisons.

Communication goals: 
- Communication to self and others: displaying information from the dataset in a readily 
understandable way. Information density is great, but only if this information can be 
visually extracted from the graph! (cf. Tukey’s third point) 
Telling a story. This is really another form of communication. If we communicate well, 
we call it storytelling. Consider, for example, Minard’s Napoleon-in-Russia graph 
popularized by Tufte (1983). 
- Attracting attention and stimulating interest. Graphs are grabby. Not so much in 
submitted journal manuscripts (where, by convention, they may be placed in a pile at the 
end of the article) but in newspaper articles, blogs, and so forth. The flip side of this is 
that graphs are often viewed as intimidating; for example, Barabasi (2010) writes, 
echoing Hawking (1988), “There is a theorem in publishing that each graph halves a 
book's audience.” This may be one reason that no graphs appear in data-rich books such 
as Freakonomics (Levitt and Dubner, 2005) that one might expect to be full of visual data 
displays. 

(1) Statistical data visualization, which is focused not on visual appeal but on facilitating an 
understanding of patterns in an applied problem (recall the Discovery goals listed above), both in 
directing readers to specific information and allowing the readers to see for themselves. 
 
(2) Infographics, which ideally should be attractive, grab one’s attention, tell a story and 
encourage the viewer to think about a particular dataset, both as individual measurements and as 
a representation of larger patterns (as in our Communication goals). 
