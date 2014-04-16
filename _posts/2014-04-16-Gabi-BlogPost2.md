---
layout: post
title: Gabi - Blog Post 2
description: The 10 Most Common Jobs in America
tags: blogpost
---

### Main Source of Data:
For this 2nd blogpost I came across this chart [here](http://www.businessinsider.com/most-popular-jobs-in-america-2014-4). After looking around a bit I found a pdf report [here](http://www.bls.gov/news.release/pdf/ocwage.pdf) with a little more detail on the occupations. I found the data here 
[here](http://www.bls.gov/oes/#news)

### Thoughts on the original government chart:

I decided to focus solely on the first chart and honestly thought it was a little dull and at least lacking color. My initial thought was that the least I could do was make the chart look prettier. I also wondered if I looked at the data if I would come up with the same numbers and how these figures were summarized, and if there was a better way to represent the data.

### Getting the data and some initial troubles:

Getting the data was not too difficult - all I had to do was download a pretty massive excel file. The excel file contains all the information I need with alot of uneeded information - there are over 400,000 rows and about 30 columns. Here are a couple challenges I came accross:
* Loading the data in R: I tried different ways to load the file such as read.csv, read.cvs2, read.table but not matter what I did it looks like the file I just big and I stuck with read.csv. 
* Understanding the different characters I had to remove: As I started looking through the data I noticed that numbers were formatted as characters and that there were empty spaces, commas, symbols such as '*', '**', '#', and not to mention empty useless rows in the data. In order to really understand what other irrelevant information there was in the file I had to unfortunately go back and look at the excel file. So, there was quite a bit of cleaning up to do which took a while and was not as straightforward as I would have liked. 
* Understanding how the data was being summarized: I still dont think I have this correct. In the data there are different groups such as: detail, broad, major, minor and total. No matter which way I summarized the data using R and Excel, I still did not come up with the same numbers as the originial chart! I got the numbers a little bit close using the detail group, but not quite, so my chart will not convey the same message as the original. 
* Plotting the occupational titles: When I started playing with visualizations I came accross the problem of being able to simply wrap the occupational title so that the names do not overlap each other. While this may seem like a pretty simple task, it took me several tries to understand what would work best for what I was trying to accomplish. I tried creating wrapper functions to create a new line after a certain number of characters but the occupational titles were not consistent at all. I ended up by just changing the titles manually one to by one, luckily there were only ten.

### Some visualizations:
Since I hadnt really explored gotplots in ggplot2, I decided to give it a try and created a dot lot of the top 10 occupations. I also played with adding texted within the graph using geom_text function which I had not done before.
[![dotplt_top10](http://Gabya06.github.io/edav/assets/gaby_assets/dotplt_top10.png)](http://Gabya06.github.io/edav/assets/gaby_assets/dotplt_top10.png).

I also played with scatterplots and flippling coordinate axes to see what might look best. 
[![scatterplt_top10](http://Gabya06.github.io/edav/assets/gaby_assets/scatterplt_top10.png)](http://Gabya06.github.io/edav/assets/gaby_assets/scatterplt_top10.png).


### Next steps - rCharts:
Since I also attempted to play with rCharts, I am working on trying to publish these charts and will update shortly.