---
layout: post
title: Dyan Ganepola's Project Review
description: How to decide on an Interactive Data Visualization Solution?   
tags: project 
---
<section>


## Project: How to decide on an Interactive Data Visualization Solution?
 
-------------------------------------------------------------------------

#### Overview:

 According to Gartner, leading IT research organization in US, “Data Science is about problem solving. It is important for IT leaders decide whether to build, buy or outsource such solutions. Choosing the right solution path will help them to avoid project failures and lost opportunities” – January 2014

#### Methodlogy:

 My project will look into two or three commercially available off-the shelf (COTS) products in the Interactive Visualization market whose functions and features are similar to what we learnt in the class. I will attempt to see how these products fit into the academic foundation laid in our EDAV course. In the process, I intend to compare the products using pre-established criteria with real life data obtained from my organization and report pros and cons of each. I will present a use case from an application in my organization and deliver a frame work for Buying, Building and Outsourcing Data Science Solutions using the results of this project.    

#### Activities:

1. Research Gartner to find out the vendors and their offerings in Data Visualization market. Read about a dozen of Gartner White Papers on this subject to supplement my research. 
2. Select the products that fit within the scope of this project and the objectives.
3. Contact the vendors and get permission for trial evaluations.
4. Test bench the products and learn how to use the products.
5. Use public data available and/or try to scrape data from web sites to demonstrate interactive visualization marketed by these two products. 
6. Establish a testing criteria to evaluate the products (see section below).
7. Evaluate the products.
8. Use all the results thus obtained and develop a framework for Buying, Building and Outsourcing Data Science Solutions using the results of this project.


#### Criteria:

1. I decided to use a product that I currently use with the data to establish a base line. I analyzed the reports and charts produced by this system and listed their drawbacks and looked at ways to improve. I did an Exploratory Data Analysis and defined a business problem to solve. Then I used the tools to solve the problem and compared the methods and the outputs.       


#### Implementation: 

#### Operational Challenge (Problem Definition: What? When? Where? Who? Why? Questions)

How can we compare YTD overtime hours (WHAT?) worked against the budgeted amount by facility (WHERE?), by job title (WHO?) and by overtime category (WHY?) between this year and same period last year (WHEN?)? 

Above problem stated in a different way in Data Visualization sense is:

How to visualize what overtime category (WHY?) required the most YTD overtime hours (WHAT?) by job title (WHO?) and by facility (WHERE?) compared to budgeted amount based upon the same period in the previous year (WHEN?)?    

There are 22 Facility Locations - (WHERE?), 6 Job Title Ranks - (WHO?), 4 Overtime Categories - (WHY?), 2 Periods (WHEN?) and 2 Types of Over Time measures (WHAT?).

It is a complex Data Structure that needs Multi Dimensional Data Visualization.

#### Screen Captures:

1.Chart given below that is generated now from the Reporting System has no visualiation but has all the data needed for one facility only.  

* 2013 2014 YTD Budget Vs Actuals by Title by Reason per facility: <br>

![2013 2014 YTD Budget Vs Actuals by Rank by Reason per facility](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/2013 2014 YTD Budget Vs Actuals by Rank by Reason per facility.JPG). 

2.Chart given below is a visualization of the above table broken down by Title and Reason but no Location data or Budgeted data included. Only the Actual hours are included.

* 2013 2014 YTD Actuals by Title by Reason: <br>

![2013 2014 YTD Actuals by Rank by Reason](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/2013 2014 YTD Actuals by Rank by Reason.JPG).

3.Another View in use now

* Actual Vs Budget OT given Date range by Title : <br>

![Actual Vs Budget OT given Date range by Title](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/Actual Vs Budget OT given Date range by Title.JPG).

4.Given below is a new chart using Visualization effects. 

* 2014 YTD OT Actuals by Facility by Category by Title: <br>

![2014 YTD OT Actuals by Facility by Category by Title](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/2014 YTD OT Actuals by Facility by Category by Title.JPG).


5.Chart given below is a Three Dimensional View of the data. Using different color schemes for each category I can visually display four types of data. Budgeted data is missing.

* 2014 YTD Actuals 3D View: <br> 

![2014 YTD Actuals 3D View](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/2014 YTD Actuals 3D View.JPG).



6.Another new View 

* HeatMap : <br>

![HeatMap](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/HeatMap.JPG).


7.Another new report  


* OT Details Config : <br>

![OT Details Config](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/OT Details Config.JPG).

8.Another View 

* OT Difference and PCT Occurences: <br>

![OT Difference and PCT Occurences](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/OT Difference and PCT Occurences.JPG).


9.Another View 

* Total OT YTD Trend: <br>

![Total OT YTD Trend](https://raw.githubusercontent.com/ganepola/edav/gh-pages/assets/dyan_assets/Project-Images/Total OT YTD Trend.JPG).



#### Blockers: 

#### Data Load Error: 

I ran into the following problem loading data using the the other tool that I am evaluating. 

* Bug With Oracle Client - Overflow error: <br>

I seem to have found the cause for the overflow error. From support I got: 

"The overflow is a known bug with the .NET Oracle driver--something like there's a limit to the total number of digits that can be handled, so a repeating decimal like 2/3 needs to be rounded to some fairly small number of digits. See 

[OCI-22053](http://connect.microsoft.com/VisualStudio/feedback/details/94626/bug-with-oracleclient-overflow-error-oci-22053).

I am currently working on fixing my data loading SQL Script and continue to produce the Data Visualization Objects for review. 

#### Conclussion:

A framework for Buying, Building and Outsourcing Data Science Solutions:


</section>