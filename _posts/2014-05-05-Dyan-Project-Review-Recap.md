---
layout: post
title: Dyan Ganepola's Project Review - Written Part
description: Recap of How to decide on an Interactive Data Visualization Solution?   
tags: project 
---
<section>


## Project: How to decide on an Interactive Data Visualization Solution?
 
-------------------------------------------------------------------------

#### Overview/Orientation:

 In my project I evaluated two commercially available off-the shelf (COTS) products for Interactive Data Visualization. I tried to make use of software solutions that are already available to improve services to my Organization. I developed a challenging criteria based upon a hypothetical What? When? Where? Who? Why? question against the data.  My goal is to compare the results with a second generation tool and see which product will answer my question in the most effective way quickly, efficiently and provide me the information I need from a lot of data. Finally I will develop a frame work for Buying, Building and Outsourcing Data Science Solutions.

#### Demo - Fast Forward:

1. Established a baseline using reports with only numbers without any visualization. 

2. Add on to the above with some Visualization introduced using charts (many). Demonstrated use of color to answer Why? question and side by side Bar Charts to answer When? question. 

Following 5 charts were developed while experimenting with one of the Visualization tools and the data to implement five (5) specific features. However in all these cases it couldn't fully answer all the five questions on one screen but with easy navigation, one can find the answers to the missing questions. This is still a great improvement over the third generation tool that was in use. 

1. Horizontal bar chart with colors and tabs.  

2. 3-D visualization chart (shape of a cube) with colors.

3. Heat map. If the actual OT hours is under budget it showed green boxes. Otherwise it showed red to mean over budget.   
4. Histogram. Two (2) histograms, one with the differences and one with the ratios were selected for OT on the X-Axis.

5. Trend Analysis. This represented a snap shot of all the YTD actual OT consumed. Sharp peak in November of 2012 was due to Over Time during Sandy disaster.  


#### Blockers:

Results using the other tool are still pending due to an error in loading the file. The file which was causing the overflow error has approximately 2.6 million rows. When trouble shooting the error I found out that it was due to a known bug with the .NET Oracle driver. There is a limit to the total number of digits that can be handled, so a repeating decimal like 2/3 needs to be rounded to some fairly small number of digits. To solve the issue I applied ROUND()function to my field in the SELECT statement. After that I was able to load the data. I will be posting the results in my Blog #3. 

#### To-dos in Blog Post #3: 

1. Try to use the other remaining tool to demo the Visualization techniques to answer the 5-W questions. 

2. If this can't be done visually in one screen, then conceptually design a chart that can provide the answers to my hypothetical 5-W questions. 

3. Finally develop a framework for Buying, Building and Outsourcing Data Science Solutions.


</section>