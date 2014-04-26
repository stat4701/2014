## BlogPost 2 - Airline on-time performance

###Learning to process/Analyze Large data set in R

####Background
I came across an interesting,but huge data set [here](http://stat-computing.org/dataexpo/2009/the-data.html). This is in fact a Data Expo competition of 2009. The aim of the data expo was to provide graphical summary of important features of the data set. The competition was to analyze 22 years of flight arrival/departure data and to predict departure or arrival delay in the future.
	
My idea is to work with 2008 year data [approx 690 MB] and to perform the analysis on this data set and to scale the logic using Hadoop/Hive in Amazon EMR (Elastic MapReduce) in the future.
	
I have worked with Hive briefly in the past, but I am new to R. So, I took this opportunity to learn data analysis using R.

#### Objectives

1. For each Origin/Destination City, I was interested to calculate the average arrival/departure delay. And, hence to identify the top 5 cities with high/low Arrival/Departure delays.
1. To identify the correlation between weather delay and Month of the year.
1. To find out if there is any significant difference between flying in and flying out of a specific airport - BlogPost 3


####Background of the Data 

The data consists of flight arrival and departure details for all commercial flights within the USA. Each trip is recorded with critical information like Arrival delay, departure delay, weather delay, security delay, carrier delay, flight number, Unique Carrier etc between cities in US. Also, downloaded supplement data like airport code/description and Airlines information from the same website.

####Challenge working with 690 MB of data in R.

For many days together, I was uploading the large data file as a dataframe in R, until Mike introduced me to data.table package in R. Using data.table, I noticed significant improvement in processing speed. Also data.table package is more like SQL in which we can create INDEXs for columns for faster grouping/aggregation. 700 MB data load using data.table package was 890 times faster than the conventional data load using as data frame using read.csv.

You can find data.table vignette [here](http://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.pdf)

Following are the observations/interesting R packages that I came across while working for this blogpost.

1. R package [sqldf](http://cran.r-project.org/web/packages/sqldf/sqldf.pdf).  Coming from a conventional RDBMS background, I always tend to think in terms of processing data using a relational database. I found sqldf package extremely helpful. One can write sql queries with group by and joins just as in RDBMS world.
1. R package [RSQLite](http://cran.r-project.org/web/packages/RSQLite/RSQLite.pdf). This package embeds the SQLite database engine in R and provides an interface with DBI package. I found this only in later part of my data analysis and hence didn't try it out. 
1. Dangerous "merge" function of R. I was looking for method to join two data tables on common columns and noticed that merge function of R. At first, it seemed to work fine, but the result it took me significant amount of time to notice that the result of the merge function merges the two data frames/data tables on requested columns, but fails to rearrange the rest of the data. Since the data set was huge, it was very difficult and time consuming to identify this bug. 
1. R package [plyr]([http://cran.r-project.org/web/packages/plyr/plyr.pdf). I found functions like join, count, arrange very handy for splitting/combining data.

####Exploratory Data Analysis using ggplot2

To eliminate the outliers, extract trips within Median +/- (2*Standard deviation) to fetch the minimum and maximum range of arrival and departure delays.

Airlines Vs Number of Flight carriers:

![AirLines Vs Number of Flights](https://github.com/gnanapriyav/edav/blob/gh-pages/assets/Priya_assets/AirLines%20Vs%20Number%20of%20Flights.jpeg)

Southwest Airlines flies the highest number of airlines with 3983 flights in year 2008 and Aloha Airlines, the lowest number of flights. 

Top 5 Cities with highest Average Arrival and Departure Delay

![Top5Delays-Dodged](https://github.com/gnanapriyav/edav/blob/gh-pages/assets/Priya_assets/Top5Delays-Dodged.jpeg)

It can be noticed that Arrival and departure delays are highest To and From Allentown PA and New York, NY. Surprisingly, the arrival and departure delay is highest between JFK airport of New York and LGA airport of New York.

###DotChart
While working with dodged chart, I also noticed that DotCharts are nicer ways to represent multi level data.

![Top5Delays-DotChart](https://github.com/gnanapriyav/edav/blob/gh-pages/assets/Priya_assets/Top5Delays.jpeg)

Average WeatherDelay by Month

![WeatherDelay]([https://github.com/gnanapriyav/edav/blob/gh-pages/assets/Priya_assets/WeatherDelayByMonth.jpeg)

It can be inferred that the average weather delay across the country is highest in August and second highest in September. Surprisingly for 2008, average weather delay across the country is lowest in November.

####Future Analysis 
There can be many more interesting analysis that can be done with this data set. For example, one can find if older flights results in high average delays. 

I would like to visualize the delays between cities using bar chart and or Chord diagram in D3 for the next blog post.

####Code
	``` R
	setwd("AirCloud") #Set working directory

	#Define colclass for faster data upload 
	classes <- c(year="integer",
	             month="integer",
	             dayofmonth="integer",
	             dayofweek="integer",
	             deptime="integer",
	             crsdeptime="integer",
	             arrtime="integer",
	             crsarrtime="integer",
	             uniquecarrier="character",
	             flightnum="integer",
	             tailnum="character",
	             actualelapsedtime="integer",
	             crselapsedtime="integer",
	             airtime="integer",
	             airdelay="integer",
	             depdelay="integer",
	             origin="character",
	             dest="character",
	             distance="integer",
	             taxin="integer",
	             taxiout="integer",
	             cancelled="integer",
	             cancellationcode="character",
	             diverted="integer",
	             carrierdelay="integer",
	             weatherdelay="integer",
	             nasdelay="integer",
	             securitydelay="integer",
	             lateaircraftdelay="integer")      

	#689.4MB file - 7009728 rows
	system.time(data2008 <- read.csv("Data/2008.csv",comment.char="",colClasses=classes))
	
	############ Carrier Vs Number of Flights Analysis ################
	#Total Number of flights per carrier
	NumOfFlights <- aggregate(data2008$FlightNum ~ data2008$UniqueCarrier,data=data2008,FUN=function(x) length(unique(x)))
	#Rename the columns and write to a csv file
	NumOfFlights <- rename(NumOfFlights,replace=c("data2008$UniqueCarrier"="Carrier","data2008$FlightNum"="NumOfFlights"))
	write.csv(NumOfFlights,"NumOfFlights.csv")
	
	#Install data.table package
	install.packages("data.table",dep=TRUE)
	library(data.table)
	
	#Reload the data as a data table
	NumOfFlights <- data.table(read.csv("Output/Final/NumOfFlights.txt"))
	#Rename the column names 
	NumOfFlights <- rename(NumOfFlights,replace=c("data2008.UniqueCarrier" = "Carrier","data2008.FlightNum"="FlightCount"))
	#Sort on FlightCount (Total number of flights of each carrier)
	SortByFlightCount <- arrange(NumOfFlights,NumOfFlights$FlightCount)
	
	#Factorize the FlightCount varible so as to display the exact flight count in the plot
	SortByFlightCount$FlightCount <- factor(SortByFlightCount$FlightCount,levels=unique(SortByFlightCount$FlightCount),ordered=TRUE)
	
	#Factorize the airlines so as to preserve the order as in data file. Please note that ggplot doesn't preserve the data order by default. Plot is display by ascending order of the flight carrier.
	SortByFlightCount$Carrier <- factor(SortByFlightCount$Carrier,levels=unique(SortByFlightCount$Carrier),ordered=FALSE)
	
	#Load the carriers description
	carriers <- data.table(read.csv("Data/carriers.csv"))
	SortByFlightCount <- rename(SortByFlightCount,replace=c("Carrier"="Code"))
	
	#Join SortByFlightCount and carriers dataframe to get carrier description
	f <- join(SortByFlightCount,carriers,by="Code",type="inner")
	f$Desc <- c("Aloha","Hawaiian","Frontier","Alaska","JetBlue","Mesa","AirTran Airways","Continental","Pinnacle","Northwest","United","Expressjet","Comair","Atlantic Southeast","American Eagle","Delta","US Airways","American Airlines","Skywest","Southwest")
	f$Desc <- factor(f$Desc,levels=unique(f$Desc),ordered=FALSE)
	p3 <- ggplot(f,aes(x=FlightCount,y=Desc))
	p3 + geom_point(color="purple",size=3) + ggtitle("Airlines by Number of Flights") + xlab("Number of Flights") + ylab("Airlines")
	
	#############Average arrival delay/departure delay for origin-dest pair Analysis #########################
	#To plot the top 5 Origin-Dest pair with highest Arrival/Departure Delay
	stats <- read.csv("Output/stats.csv")
	stats <- data.table(stats)
	
	#Calcuate the min and max range for departure and arrival delays... could have used ddply.. may be next time
	
	stats$MinArrDelay <- mapply(function(med,sd) (med-(2*sd)),med=stats$MedianArrDelay,sd=stats$SDArrDelay)
	stats$MaxArrDelay <- mapply(function(med,sd) (med+(2*sd)),med=stats$MedianArrDelay,sd=stats$SDArrDelay)
	stats$MinDepDelay <- mapply(function(med,sd) (med-(2*sd)),med=stats$MedianDepDelay,sd=stats$SDDepDelay)
	stats$MaxDepDelay <- mapply(function(med,sd) (med+(2*sd)),med=stats$MedianDepDelay,sd=stats$SDDepDelay)
	#calcuate the average delay of subset of data within the desired minimum and maximum range of each origin and destination pair.
	
	              
	delay <- function(origin,dest,mindelay,maxdelay){ 
	        s1 <- subset(data2008,data2008$Origin == origin,data2008$Dest == dest,data2008$ArrDelay >= mindelay & data2008$ArrDelay <= maxdelay)
	        avgdelay <- mean(s1$ArrDelay)
	}
	
	stats$AvgArrDelay <- mapply(function(x,y,z1,z2) delay(x,y,z1,z2),x=stats$Origin,y=stats$Dest,z1=stats$MedianArrDelay,z2=stats$SDArrDelay)
	
	setkey(stats,Origin,Dest) 
	
	#Extract rows from dt.2008 with and without NAs in DepDelay and Arrival Delay - dt.2008 - 7009728 rows
	dt.2008.subset <- subset(dt.2008,!is.na(dt.2008$ArrDelay) & !is.na(dt.2008$DepDelay)) #6855029 rows
	dt.2008.subset.na <- subset(dt.2008,is.na(dt.2008$ArrDelay) | is.na(dt.2008$DepDelay)) #154699 rows
	pair <- dt.2008[,Origin,Dest]
	pairfreq <- as.data.frame(table(pair))
	statsfreq <- join(stats,pairfreq,by=c("Origin","Dest"),type="inner")
	setkey(statsfreq,Origin,Dest)
	
	#It is noticed that there is data with NA in STD DEV. Upon extracting such data separatley and analyzing, it has been identified that those were data with just 1 trip in the year of 2008 and hence the SD calcuation resulted in 1. It is safe to replace the min and max delay ranges to the original values.
	#Data with such just 1 trip is not our area of interest and hence such trips were ignored from this analysis.
	
	withNA <- subset(stats,is.na(stats$SDArrDelay) | is.na(stats$SDDepDelay))
	notNA <- subset(stats,!is.na(stats$SDArrDelay) & !is.na(stats$SDDepDelay)) #5054 unique origin and destination pair
	
	#Extract dataset only for cities in notNA table.
	setkey(notNA,Origin,Dest)
	subset1 <- join(dt.2008,notNA,by=c("Origin","Dest"),type="inner")
	subset2 <- subset1[subset1$ArrDelay > subset1$MinArrDelay & subset1$ArrDelay <= subset1$MaxArrDelay & subset1$DepDelay > subset1$MinDepDelay & subset1$DepDelay <= subset1$MaxDepDelay &(!is.na(subset1$ArrDelay) | !is.na(subset1$DepDelay))]
	#6443508 obs. of  39 variables:
	write.csv(subset2,"Output/subset2.csv") ### Important file...
	result <- subset2[, j=list(mean(ArrDelay, na.rm = TRUE),mean(DepDelay, na.rm = TRUE)),by = list(Origin,Dest)]
	
	colnames(result)[3] <- "AvgArrDelay"
	colnames(result)[4] <- "AvgDepDelay"
	
	sorted_result_arr <- arrange(result,desc(result$AvgArrDelay))
	sorted_result_dep <- arrange(result,desc(result$AvgDepDelay))
	
	sorted_result_arr_asc <- arrange(result,result$AvgArrDelay)
	sorted_result_dep_asc <- arrange(result,result$AvgDepDelay)
	result1 <- data.table(read.csv("Output/Final/result1.csv"))
	library(plyr)
	
	sorted_result1_arr <- arrange(result1,desc(result1$AvgArrDelay))
	
	arr <- head(sorted_result1_arr,5)
	arr$OriginDest <- paste(arr$Origin,arr$Dest,sep="-")
	
	top5arrdelay <- data.table(OriginDest = arr$OriginDest,DelayType="ArrDelay",AvgDelay=arr$AvgArrDelay)
	top5depdelay <- data.table(OriginDest = arr$OriginDest,DelayType="DepDelay",AvgDelay=arr$AvgDepDelay)
	top5delay <- rbind(top5arrdelay,top5depdelay)
	
	top5delay$DelayType <- factor(top5delay$DelayType)
	top5delay$OriginDest = c("Allentown,PA To New York, NY","Wichita,KS To Oklahoma City, OK","JFK, New York, NY To LGA, New York, NY","Roanoka, VA To Covington, KY","Knoxville, TN To Austin, TX")
	top5delay$OriginDest <- factor(top5delay$OriginDest)
	
	qplot(x=OriginDest,y=AvgDelay,data=top5delay,stat="identity",geom="bar",position="dodge",fill=DelayType,xlab="OriginCity-DestinationCity",ylab="Average Delay in minutes",main="Top 5 cities with highest Average Arrival and Departure Delays")
	
	#Dot Chart
	qplot(x=OriginDest,y=AvgDelay,data=top5delay,stat="identity",geom="bar",position="dodge",fill=DelayType,xlab="OriginCity-DestinationCity",ylab="Average Delay in minutes",main="Top 5 cities with highest Average Arrival and Departure Delays") + coord_flip()
	
	#Extract rows with weather delays
	w1 <- data2008[complete.cases(data2008[,26]),]
	weatherdelay <- w1[w1$WeatherDelay > 15,]
	
	write.csv(weatherdelay,"Output/weatherdelay.csv")
	
	#Extract rows with security delays
	s1 <- data2008[complete.cases(data2008[,28]),]
	securitydelay <- s1[w1$SecurityDelay > 15,]
	write.csv(securitydelay,"Output/securitydelay.csv")
	
	###############

	```







	

 
	
	
	