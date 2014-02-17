---
layout: post
title: Introducing - Gabrielle Agrocostea
description: A short intro and Assignment 0 Update
---

>I am a student in the Data Science Certificate Program here at Columbia and my undergraduate degree was in Mathematics from Fordham University.

>My previous work experience has been in the finance industry. My career started as an Intern in the Operations team at BlackRock and from there I have worked in other departments such as Investment Accounting, Expense Analysis & Budgeting and Business Analysis (and other firms such as Morgan Stanley and Allianz Global Investors). Although it is not really considered a programming language, my first exposure to programming was in Excel/Access VBA while trying to automate various processes. I am new to Python and R and look forward to learning more about data visualization.

## Assignment 0 
>I chose to rewrite the data scrapper in R and was also able to make a few graphs.
Using ggplot I plotted all the population by years and location - which allowed me to see that there isnt much data for years before 1900. 
+[![popGraph-allData](http://Gabya06.github.io/edav/assets/popGraph-allData.png)](http://Gabya06.github.io/edav/assets/popGraph-allData.png)

>I then focused only on the population by location after 1900 and removed the ranking information. This graph shows how the population increased but there is no location information. 
+[![popGraph-allData](http://Gabya06.github.io/edav/assets/popGraph-reducedData.png)](http://Gabya06.github.io/edav/assets/popGraph-reducedData.png)
>I found it difficult to incorporate all of the locations so I ended up by finding the average by year and keeping only the locations that had populations greater than the yearly average. This graph shows only a few locations which were above the yearly average.
+[![popGraph-allData](http://Gabya06.github.io/edav/assets/popGraph-byCity.png)](http://Gabya06.github.io/edav/assets/popGraph-byCity.png)

> Rscrapper for summary dataset and full dataset [here](https://github.com/malecki/edav/tree/gh-pages/projects/popgraph/rscrapper/scrape-population.R)

## Next Steps
> I am starting to work analyzing the data using D3.
