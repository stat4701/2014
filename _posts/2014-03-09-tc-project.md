---
layout: post
title: project plan - tommie chen
description: project iteration plan
tags: project edav iter1 iter2
---

## Project 
There are two project ideas I am interested to work on:
(1) study the relation among job market, housing price, and college major.
(2) evaluate the rule of 4-4-3-3 to construct a mutual fund/ETF based investment portfolio.
The final project selection will be determined by the outcome of pre-implementation phase.
Iteration 1 shows a general project plan I intend to follow.

### Iteration 1 - In Progress
#### Pre-implementation (requirement iterations)
- Determine project scope
- Assess project opportunities and risks
- Define preliminary resources (such as software specifications, data source)
- Review scope with the project manager
- \* Delivery timeline: February-March
- \* Deliverable: project high level scope set

#### Implementation (development iterations)
- Develop functional specifications 
- Design prototype (degisn - code - test)
- Acceptance testing (including peer reviews)
- \* Delivery timeline: March-April
- \* Delivarable: proof of concept

### Iteration 2 - Finalizing Project Scope & Finding Data Source
After searching multiple database from the U.S. Census Bureau, U.S. Bureau of Labor Statistics, and Federal Housing Finance Agency, there was no raw dataset, for the first school-employee-housing study, can be used without applying combination of data cleanup, manipulation and calculation iteratively. So moving on to the second project idea, 4-4-3-3 investment strategy study, here is a quick summary about searching some major data sources.
- Yahoo Finance: this is one of the oldest and popular financial website around today. The information provided is comprehensive and free. Product ranking summary is available. The problem is that no single entry can be found to download all data at once. Writing a data scraper is required to retrieve fund information one by one. 
- TD Ameritrade: the firm's website was rebuilt to be more user friendly with various financial information. In the data screening page, multiple funds are displayed in the same place. But the build-in export function can only be used for the overview type of data. So the fund ranking information can not be downloaded through this handy online function.  
- Fidelity Investment: many companies use Fidelity as their 401k provider. The research utility from the Fidelity website provides good summary and detail information. Although data scraping is still needed, time to retrieving information should be limited. However the big issue is that the site provides only partial (yearly) ranking information. The time saved from data retrieval will be used for ranking calculation.
- Morningstar: under review 
 
It is likely that I will combine pros from different websites to generate the dataset needed before next iteration. 
