---
layout: post
title: Michael Jiang - Blog Post Three
description: 
tags: blog
---

<section>

### Restaurant Inspection Grading in NYC (Chinese Restaurant)

* Description <br>
In this blog post, I did a visualization of the Sanity Inspection Grading for all Chinese Restaurant in NYC in R. And the following is the result for Grade_A, Grade_B, and Grade_C distribution. <br>

* Grade A Chinese Restaurant Distribution <br>
[![gradeA] (https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets_two/src/grade_A_distribution.jpeg)](https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets_two/src/grade_A_distribution.jpeg) <br>

* Grade B Chinese Restaurant Distribution <br>
[![gradeB] (https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets_two/src/grade_B_distribution.jpeg)](https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets_two/src/grade_B_distribution.jpeg) <br>

* Grade C Chinese Restaurant Distribution <br>
[![gradeA] (https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets_two/src/grade_C_distribution.jpeg)](https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets_two/src/grade_C_distribution.jpeg) <br>

* The Process <br>
First step, I download the data from the New York City Department of Health and Mental Hygiene database. This includes a huge csv file with all the grading records. <br>
Then, two problems exist: <br>
1. In this csv file, every restaurant only contains information about its address in the form of street and building number. However, when plotted in the map in R, the usual way is to use latitude and longitude. Therefore, I used a package in google called RDSTK taht could translate the exact address to the latitude-longitude pair information. However, this package only allow for 2000 queries per day, so I need to be really careful and store the intermediate results out to disk. <br>
2. Since the records in this csv file is in the unit of grading records. Therefore, for a specific restaurant, there might be multiple records related. What needed to be done is first find a primary key for all restaurants. The names of the restaurants doesn't seem to be a good primary key since some restaurants have same names, therefore, I choose to use the phone number as the primary key. Second, the grade date is in the form of something like 7/30/13 0:00, this is not the way dates in R look like, so I need to extract the month/day/year from it and transform it into the date type in R. Finally, I could sort all the records based on primary key and date, and get the lastest grading for all restaurants. <br>


* Some thoughts about the distribution
First, it's obvious and glad to see that number of grade_A Chinese restaurant is far more than grade_B and grade_C. Lots of restaurants are concentrated in downtown Chinatown, and both grade_A and grade_B are there. One conclusion I might get from the plot is that it seems to be safer to eat mid town and uptown, while when going to Chinatown, we need to keep our eyes open for grade_A restaurants. <br>
But, anyway, happy eating around! <br>


* Sample Codes <br>

```html

# this code is for EDAV blog post 3
# this code would generate 3 maps plot for grade A, grade B, grade C chinese restaurant
# in ggmap, and compare the distribution of them

# Clear all existing objects
rm(list = ls())
setwd('/Users/michaeljiang/Desktop/edav/edav/assets/michael_jiang_assets_two/src')

# Load the data
data = read.csv('nyc_restaurant_grade.csv')

# Select Chinese restaurant
data = data[data$CUISINECODE == 20 , ]

# Select Manhattan restaurant
data = data[data$BORO == 1 , ]

# Get the latest grading
require(stringr)
data = data[ , c(2 , 4 , 5 , 6 , 7 , 13 , 14)]
data = data[data$GRADEDATE != "" , ]
ddd = str_split(data$GRADEDATE , ' ')
ddd2 = NULL
for (i in 1 : length(ddd)) {
  ddd2 = c(ddd2 , ddd[[i]][1])
}
ddd2 = as.Date(ddd2 , "%m/%d/%y")
data$GRADEDATE = ddd2
data$ADDRESS = paste(str_trim(data$BUILDING) , str_trim(data$STREET) , ', New York, NY' , data$ZIPCODE)
data = data[ , c(1 , 6 , 7 , 8)]
data = data[order(data$ADDRESS , +data$GRADEDATE) , ]
data$delete = 0
for (i in 1 : (nrow(data) - 1)) {
  print(i)
  if (data[i , 1] == data[i + 1 , 1]) {
    data[i , 5] = 1
  }
}
data = data[data$delete == 0 , -c(3 , 5)]

# Split the restaurants into grade A, grade B, grade C
grade_A = data[data$CURRENTGRADE == 'A' , c(1 , 3)]
grade_B = data[data$CURRENTGRADE == 'B' , c(1 , 3)]
grade_C = data[data$CURRENTGRADE == 'C' , c(1 , 3)]

# Transform the address into latitude and longitude
require(RDSTK)

grade_A$latitude = 0
grade_A$longitude = 0
for (i in 1 : nrow(grade_A)) {
  tryCatch({
    geo_inf = street2coordinates(grade_A[i , 2])
    grade_A[i , 3] = geo_inf$latitude
    grade_A[i , 4] = geo_inf$longitude
  } , warning = function(w) {
    print(paste("MY_WARNING :  " , i))
  } , error = function(err) {
    print(paste("MY_ERROR   :  " , i))
  } , finally = {
  })
}
write.table(grade_A, "grade_A_geoinfo.txt", sep="\t")

grade_B$latitude = 0
grade_B$longitude = 0
for (i in 1 : nrow(grade_B)) {
  tryCatch({
    geo_inf = street2coordinates(grade_B[i , 2])
    grade_B[i , 3] = geo_inf$latitude
    grade_B[i , 4] = geo_inf$longitude
  } , warning = function(w) {
    print(paste("MY_WARNING :  " , i))
  } , error = function(err) {
    print(paste("MY_ERROR   :  " , i))
  } , finally = {
  })
}
write.table(grade_B, "grade_B_geoinfo.txt", sep="\t")

grade_C$latitude = 0
grade_C$longitude = 0
for (i in 1 : nrow(grade_C)) {
  tryCatch({
    geo_inf = street2coordinates(grade_C[i , 2])
    grade_C[i , 3] = geo_inf$latitude
    grade_C[i , 4] = geo_inf$longitude
  } , warning = function(w) {
    print(paste("MY_WARNING :  " , i))
  } , error = function(err) {
    print(paste("MY_ERROR   :  " , i))
  } , finally = {
  })
}
write.table(grade_C, "grade_C_geoinfo.txt", sep="\t")

# Plot the grade A B C Chinese restaurants on map using ggmap
library(ggplot2)
library(ggmap)

map <- get_map(location = c(lon = -73.98898 , lat = 40.73692) , zoom = 13 , maptype = "toner" , source = "stamen")

jpeg('grade_A_distribution.jpeg' , quality = 100)
ggmap(map) + geom_point(data = grade_A , aes(x = longitude , y = latitude) , colour = "green" , size = 3 ,  alpha = 0.6)
dev.off()

jpeg('grade_B_distribution.jpeg' , quality = 100)
ggmap(map) + geom_point(data = grade_B , aes(x = longitude , y = latitude) , colour = "orange" , size = 3 ,  alpha = 0.6)
dev.off()

jpeg('grade_C_distribution.jpeg' , quality = 100)
ggmap(map) + geom_point(data = grade_C , aes(x = longitude , y = latitude) , colour = "red" , size = 3 ,  alpha = 0.6)
dev.off()


```


</section>
