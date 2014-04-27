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

The source of the data for the above map came from several polls conducted by Gallup over the 2005-2013 period. Unfortunately the survey data was not available to download without paying a huge subscription. A full World Poll Data Set that includes data for many categories of interests including behavioral metrics has a price tag of $145,000 per year. However to Gallup's credit the complete methodology and specific survey dates were made available [Here](http://www.gallup.com/strategicconsulting/128171/Country-Data-Set-Details.aspx).  

Next, my approach was to Inspect the code of the above Map to see whether I could scrape the data from the Web Site.

* Code: <br>

[![Code](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Snippet-of-Gallup-Map.jpg)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Snippet-of-Gallup-Map.jpg).

* Country: <br>

[![Country](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Country Data Set Details Snip.jpg)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/Country Data Set Details Snip.jpg).

* NAUSA: <br>

[![NAUSA](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-1Million-on-US-Map.jpg)](http://dganepol.github.io/edav/assets/dyan_assets/Screen-Captures/NA-Major-City-Population-Over-1Million-on-US-Map.jpg).


Next was to convert it to text file using OCR conversion.



During my Blog Review and presentation session in the class, I was directed to do data research using [iPOLL at ROPER Center that allows to use CUID to Authenticate for Columbia University Membership Organization](http://www.ropercenter.uconn.edu/membership/roper_members.html). 

This site has lot of similar data available for research but didn't have the data I was looking for. At that point I shifted my focus more on the Visualization aspect than the type of data used for the Visualization. Therfore as a workaround I decided to use World's Poulation Data instead of World's Emotional Rankings. This substitution of the type of data was necessary to speed up the development of the illustration of the map without getting stuck at the data level. My other option was to use some toy data but I opted to use World's Population data as real data.          

For better clarity of the final visualization project, I decided to split the world map into four major regions. Here are the snapshots of the maps by the region: 

* Asia: <br>

[![Asia](http://dganepol.github.io/edav/assets/dyan_assets/GeoMaps/Asia+35-11+180+73.jpg)](http://dganepol.github.io/edav/assets/dyan_assets/GeoMaps/Asia+35-11+180+73.jpg)

* Europe: <br>

![Europe](https://raw.githubusercontent.com/dganepol/edav/gh-pages/assets/dyan_assets/GeoMaps/Europe-27.16+37.5+46+78.5.jpg).

* North America: <br>

![North America](https://raw.githubusercontent.com/dganepol/edav/gh-pages/assets/dyan_assets/GeoMaps/NorthAmerica-179.5+10.7-49.9+87.9.jpg).

* South America: <br>

![South America](https://raw.githubusercontent.com/dganepol/edav/gh-pages/assets/dyan_assets/GeoMaps/southamerica-87.3-54.5-31.55+14.jpg).

I have given below  the Datasets associated with each of these geographical regions. By splitting the world map into these geographical regions I could overcome the performance problem I mentioned earlier. Now instead of aggregating the entire world's data into the map I could limit the size of the dataset by choosing the region I am interested in. Why include Asia if I am only interested in North America? The datasets I gave with Geo Codes by the region are: 

[Asia](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/Asia-City,Country-English.txt).

[Europe](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/Europe-City,Country-English.txt).

[North America](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/NA-City,ST-English.txt).

[South America](https://github.com/dganepol/edav/blob/gh-pages/assets/dyan_assets/SA-City,Country-English.txt).