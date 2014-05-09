---
layout: post
title: Tommie's Project 2014
description: The Secret of Compound Interest
tags: edav project 
---

### Introduction 
[link-introduction-01]: http://web.williams.edu/Mathematics/devadoss/careerpath.html
[link-demo]: http://tc2680.github.io/Hello-World/ProjectDemo.html

Initially there were two project proposals in the beginning of semester. The first proposal was about discovering hidden relations among College Major, Employment Rate, and Housing Trend. Most people understand the consequence of housing market when employment rate is increasing or decreasing. But the concept of Employment is vague in terms of ages or years of working experience. My hypothesis is - is there a correlation exists in popularity of college major versus employment rate which ultimately leads to housing trend development?

<img src="http://tc2680.github.io/Hello-World/major-employment-housing.png" width ="600">

There was a study at Williams College about [Impact of Major on Career Path for 15600 Williams College Alums][link-introduction-01] which had similar idea but with much smaller scope and dataset. My study began with reviewing data sources including: 
- [U.S. Census Bureau](http://www.census.gov)
- [U.S. Bureau of Labor Statistics](http://www.bls.gov)
- [Federal Housing Finance Agency](http://www.fhfa.gov)
- Multiple college admin websites

And the result is... there are all kinds of different data format - image, pdf, csv, freetext, webpage, and so on. And no single data source can be obtained to extract useful information. After a week of struggling, I realized that without doing hard data cleanup, manipulation, transformation, and calculation repeatedly, I'd not go too far for this project. And by the time I finished data preparation, I might not have enough time for data exploration and visualization.

<img src="http://tc2680.github.io/Hello-World/spent-5-days.png" width ="220">


### Second Proposal - The Secret Revealed
Therefore I decided to move on to the second project idea - study a (semi) secret investment strategy nicknamed **4433** in fund management industry. Here is The Secret:

    1. Funds ranked top quartile by recent yearly return of same type
    2. Funds ranked top quartile by last two, three, and five years return of same type
    3. Top one-third of funds from last six months return of same type
    4. Top one-third of funds from last three months return of same type


### Learn to Swim in the Deep Data Sea
Financial Data Explored:
- [Yahoo Finance](http://finance.yahoo.com): this is one of the oldest and popular financial website around today. The information provided is comprehensive and free. Product ranking summary is available. The problem is that no single entry can be found to download all data at once. Writing a data scraper is required to retrieve fund information one by one. 
- [TD Ameritrade](http://research.tdameritrade.com/grid/public/mutualfunds/premierlist/premierlist.asp): the website was rebuilt couple years ago to be user friendly with a good deal of financial information. Under their data screening tool, multiple funds are displayed in the same place. But the build-in export function can only be used for the overview type of data, not for specific fund ranking information.  
- [Fidelity Investment](https://www.fidelity.com/mutual-funds/overview): many companies use Fidelity as their 401k provider. The research utility from the Fidelity website provides good summary and detail information. Although data scraping is still needed, time to retrieving information can be minimized. However the biggest issue is that the website does not provides full-scale ranking information. 
- [Morningstar](http://www.morningstar.com/Cover/Funds.aspx): I signed up for a basic account and took a look at the content of fund performance section. It turns out that majority of information from the website can also be retrieved from Yahoo Finance for free. Since I need to calculate fund ranking regardless, Yahoo Finance is a better choice for the project data source.  
- [Market Watch](http://marketwatch.com/): conveniently the security master list I need can be downloaded here


Data Munging:
- Becutiful Soup 4.3.2
- Python 3
- Excel 2010
- SQL 2012


### The Data Exploration Map

<img src="http://tc2680.github.io/Hello-World/project_flow_chart.png" width ="500">



### A Picture is Worth a Thousand Words

| Week 1: very exciting | Week 2: exciting |
| ------------- | ------------- |
| <img src="http://tc2680.github.io/Hello-World/100-master-list.png" width ="180">| <img src="http://tc2680.github.io/Hello-World/101-symbol-performance.png" width ="180">


| Week 3: work | Week 4: more work |
| ------------- | ------------- |
| <img src="http://tc2680.github.io/Hello-World/102-master-excel.png" width ="180">    | <img src="http://tc2680.github.io/Hello-World/103-data-scraper.png" width ="180">    |


| Week 5: are we there yet?  | Week n+1: are we there...|
| ------------- | ------------- |
| <img src="http://tc2680.github.io/Hello-World/104-output-roi.png" width ="360"> | <img src="http://tc2680.github.io/Hello-World/999_warning.png" width ="180"> |


### Data Visualization and The Practice
Finally here comes the visualization part. 
- From 1991 to 2013, average Return On Investment for S&P500 is **8.97%**
- But in the same period, All-Categories Strategy and All-Symbols Strategy return **11.29%** and **12.69%** respectively

    Compound interest is "the most powerful force in the universe" - Albert Einstein


- There are various styles to apply the investment strategy. For example, instead of looking at all recommended products, we can choose top 1%, 5%, 10%, or 20% of highest ranked funds 
- Static charts are displayed below. You can also find the [motion chart][link-demo] here

<img src="http://tc2680.github.io/Hello-World/300-line-chart.png" width ="400">
<img src="http://tc2680.github.io/Hello-World/301-bar-chart.png" width ="400">
<img src="http://tc2680.github.io/Hello-World/302-bubble-chart.png" width ="400">


### About The Future
Something to consider:  

<img src="http://tc2680.github.io/Hello-World/chart-idea-02-universe.png" width ="400">
<img src="http://tc2680.github.io/Hello-World/chart-idea-06-portfolio.png" width ="400">


