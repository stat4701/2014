---
layout: post
title: Dyan's Blog Post 2
description: A color-coded map of the world’s most and least emotional countries - Revisited 
tags: blogpost
---

* This Blog Post is a continuation of Blog Post 1 which was about a Color-coded map of the world's most and least emotional countries: <br> 


[![World Map](http://ganepola.github.io/edav/assets/dyan_assets/emotional-countries.JPG)](http://ganepola.github.io/edav/assets/dyan_assets/emotional-countries.JPG)


Overview:

The problem with the above map is, although it has great color coding, it has no interactive visualization capability. It has a great potential to be enriched by using interactive visualization techniques which is the Goal # 1 of this Blog Post. Also as the Goal # 2, I thought as a Data Science student it would be interesting to find out if there is any statistical correlation of this polled data to some other parameter such as the country's population or the literacy rate. I was able to accomplish the Goal # 1 with a slight modification and left the Goal # 2 for a next iteration of this Blog Post. 

Also for the interested bloggers I have listed a Data Exercise at the end that can be done to explore the data in a more meaningful way which I couldn't do due to time limitations.     


This is what I did for the Blog Post #2 in my attempt to make it interactive by introducing the visualization capability that was missing in the Blog Post #1. This should provide grounds for further analysis to get more insight of the data.

The source of the data for the above map came from several polls conducted by Gallup over the 2005-2013 periods. Unfortunately the survey data was not available to download without paying a huge subscription. A full World Poll Data Set that includes data for many categories of interests including behavioral metrics has a price tag of $145,000 per year. However to Gallup's credit the complete methodology and specific survey dates (not Data) can be downloaded using the link in My BlogPost1. Sample of the file is given below for reference.  

* Country Data Set: <br>

[![Country](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Country Data Set Details Snip.JPG)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Country Data Set Details Snip.JPG)

Next, my approach was to inspect the code of the above Map to see whether I could scrape the data from the Web Site. Sample of the code is given below.  

* Code: <br>

[![Code](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Snippet-of-Gallup-Map.JPG)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Snippet-of-Gallup-Map.JPG)

As you can see in the code highlighted above, the data are images (JPG) and not readily available to scrape from the Website. Next I turn my attention to the "Emotional State of the World" chart whose link was given on the Website. That chart has the data I was looking for. Sample of that chart is given below.

* Emotional State of the World: <br>

[![EmotionalState](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Emotional State of the World Snip.JPG)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Emotional State of the World Snip.JPG)

However scraping this chart threw more challenges to my effort. The data is arranged in two columns that are side by side and scraping as one continuous column was time consuming. Besides, I had to run the scrapped data through an OCR converter to convert it into text format so I can use the data on My New Map. This was tedious and I had to look for other means. 

During my Blog Review and presentation session in the class, I was directed by my professor to do data research using [iPOLL at ROPER Center that allows to use CUID to Authenticate for Columbia University Membership Organization](http://www.ropercenter.uconn.edu/membership/roper_members.html). 

This site has lot of similar data available for research but didn't have the data I was looking for. At that point I shifted my focus more on the Visualization aspect than the type of data used for the Visualization. Therefore as a workaround I decided to use World's Population Data instead of World's Emotional State Rankings. This substitution of the type of data was necessary to speed up the development of the illustration of the map without getting stuck at the data level. My other option was to use some toy data but I opted to use World's Population data as it is real data.          

World's population by city with city's Geo-codes and Geo-coded Maps were downloaded through the courtesy of Open Street Map and GeoNames. Data were organized into four major Geographical regions making it easy to load data for each region. Total number of cities in the four regions combined is 129,300 (Asia = 38,200, Europe = 64,000, North America = 18,800, South America = 8,300). The Gallup Map had data for only 150 countries. Therefore to limit the number of cities to a manageable size I selected to filter cities that have a population greater than 100,000 in the North American region only. This gave me a list of 500 North American cities with the Geo-codes. I was also interested to plot North American cities with a population greater than 1 million. There were 30 such cities in the North American region. This provided me enough data to play with for my Visualization project. I mapped the data on a World Map and also for better clarity I mapped the data on a map of the North American region.

 I used Plug and Play software that came quite handy to use as a development tool to produce the maps given below. Most of the development time was spent on learning the tool.

Summary:

As I move the mouse over the dots or the cylinders on the Maps it displays a tool-tip with the population. The height of the cylinder is proportional to the population. I could pan, rotate, turn and zoom the maps to get a better visualization of the data. That was my Goal #1 in this Visualization project and I am satisfied with the results I have obtained.         

* NAWORLDMAP: <br>

[![NAWORLDMAP](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-1Million-on-World-Map.JPG)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-1Million-on-World-Map.JPG)

* NAUSMAP: <br>


[![NAUSMAP](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-1Million-on-NAUS-Map.JPG)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-1Million-on-NAUS-Map.JPG)


* NAUSMAPGT100K: <br>
NA-Major-City-Population-Over-100K-on-US-Map

[![NAUSMAPGT100K](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-100K-on-US-Map.JPG)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-100K-on-US-Map.JPG)


Here are the snapshots of the maps by the region without any data mapped on them. 

* Asia: <br>

[![Asia](http://dganepol.github.io/edav/assets/dyan_assets/GeoMaps/Asia+35-11+180+73.jpg)](http://dganepol.github.io/edav/assets/dyan_assets/GeoMaps/Asia+35-11+180+73.jpg)

* Europe: <br>

![Europe](https://raw.githubusercontent.com/dganepol/edav/gh-pages/assets/dyan_assets/GeoMaps/Europe-27.16+37.5+46+78.5.jpg).

* North America: <br>

![North America](https://raw.githubusercontent.com/dganepol/edav/gh-pages/assets/dyan_assets/GeoMaps/NorthAmerica-179.5+10.7-49.9+87.9.jpg).

* South America: <br>

![South America](https://raw.githubusercontent.com/dganepol/edav/gh-pages/assets/dyan_assets/GeoMaps/southamerica-87.3-54.5-31.55+14.jpg).

I have given below the population Datasets (raw data) associated with each of these geographical regions along with their respective Geo-codes. 

[Asia](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/Asia-City,Country-English.txt).

[Europe](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/Europe-City,Country-English.txt).

[North America](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/NA-City,ST-English.txt).

[South America](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/SA-City,Country-English.txt).


* Data Exercise: <br> 

1. Aggregate the city data by country to get the population of the country for each of the four geographic regions.

2. Merge the four country population datasets obtained in 1 above for the four regions into one aggregated dataset.

3. Sort the file obtained in 2 above by population.

4. Extract the population of the 150 countries listed in Gallup's poll in Worlds Emotional State Ranking chart.

5. Map the population of these 150 countries on the world map.  

6. What conclusions can you make?




   