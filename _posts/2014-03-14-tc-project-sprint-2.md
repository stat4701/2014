---
layout: post
title: project plan - tommie chen
description: project iteration plan
tags: project edav iter1 iter2
---

### Iteration 1 Recap + Iteration 2 Update
Initially there were two project proposals in the iteration 1. For my first school-employee-housing project idea, after searching multiple database from the U.S. Census Bureau, U.S. Bureau of Labor Statistics, and Federal Housing Finance Agency, I feel there is no applicable dataset which can be used without doing hard data cleanup, manipulation and calculation iteratively. The process of preparing raw information may take much longer than expected. This will leave me little room for more interesting work in data exploration and visualization.

So moving on to the second project idea, the 4-4-3-3 investment strategy study, following is a brief summary about finding data source.
- [Yahoo Finance](http://finance.yahoo.com): this is one of the oldest and popular financial website around today. The information provided is comprehensive and free. Product ranking summary is available. The problem is that no single entry can be found to download all data at once. Writing a data scraper is required to retrieve fund information one by one. 
- [TD Ameritrade](http://research.tdameritrade.com/grid/public/mutualfunds/premierlist/premierlist.asp): the website was rebuilt couple years ago to be user friendly with a good deal of financial information. Under their data screening tool, multiple funds are displayed in the same place. But the build-in export function can only be used for the overview type of data, not for specific fund ranking information.  
- [Fidelity Investment](https://www.fidelity.com/mutual-funds/overview): many companies use Fidelity as their 401k provider. The research utility from the Fidelity website provides good summary and detail information. Although data scraping is still needed, time to retrieving information can be minimized. However the biggest issue is that the website does not provides full-scale ranking information. 
- [Morningstar](http://www.morningstar.com/Cover/Funds.aspx): I signed up for a basic account and took a look at the content of fund performance section. It turns out that majority of information from the website can also be retrieved from Yahoo Finance for free. Since I need to calculate fund ranking regardless, Yahoo Finance is a better choice for the project data source.  

Therefore, I will be working on the second project idea. In addition, before diving into the data mugging process, I need to get a master list of all mutual funds. The [Alphabetical Fund Listing](http://www.marketwatch.com/tools/mutual-fund/list?firstLetter=A) was found from the MarketWatch, a popular financial information website from Dow Jones & Company. For next iteration 3, focus areas are data mugging and a *bad* graph.
