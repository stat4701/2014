# this code is for EDAV blog post 2
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

