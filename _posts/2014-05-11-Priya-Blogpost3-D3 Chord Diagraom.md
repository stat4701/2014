## BlogPost 3 - Airline on-time performance - D3 Chord Diagram

In my previous blogpost, I did preliminary analysis on [2008 Airlines Dataset](http://stat-computing.org/dataexpo/2009/the-data.html). As part of my previous analysis, I have extracted statistics with number of flights between each Origin-Destination City pair. This dataset (FlightsBetCities.csv) can be found in assets folder. You can find snapshot of the data [here](https://github.com/gnanapriyav/edav/tree/gh-pages/assets/Priya_assets/BlogPost3/Datasnapshot.png).

Objective for this blogpost is to visualize the traffic between cities among top 50 origin/destination pairs.

###Data Extraction 
```R
#Read the file 
FlightsBetCities <- read.csv("FlightsBetCities.csv")
#Load library plyr
library(plyr)

#sort on descending order of number of flights
srt <- arrange(FlightsBetCities,desc(Numofflights))

#Extract Origin-Dest with highest number of flights between the cities. Extract only top 50 such pairs
srt50 <- head(srt,50)

#create data matrix for d3 chord diagram
origin <- c(paste(srt50$OriginCity,srt50$OriginState,sep=","))
dest <- c(paste(srt50$DestCity,srt50$DestState,sep=","))
circle_data <- data.frame(origin=origin,dest=dest,flightscount=srt50$Numofflights)

#write to circle_data.csv which is later used by d3 to produce chord diagram with details of flight counts between cities.
write.csv(circle_data,"circle_data.csv",row.names=FALSE)
```

###Data Visualization

D3 chord diagram can be found [here](https://github.com/gnanapriyav/edav/tree/gh-pages/assets/Priya_assets/BlogPost3/flights.html). 

[D3 chord diagram inspiration](http://www.delimited.io/blog/2013/12/8/chord-diagrams-in-d3)

[snapshot] (https://github.com/gnanapriyav/edav/tree/gh-pages/assets/Priya_assets/BlogPost3/Flight traffic.png). I am able to view the chord diagram in Firefox, but doesn't show up in google chrome. I guess there is some settings issue. Please view the visualization in firefox to enjoy the interactiveness.

### Future Enhancements
1. For this course, I used only 2008 data (which is close to 700MB). As part of future project, I would like to generate statistics/visualization using data for the past 20 years which is available in [data expo site](http://stat-computing.org/dataexpo/2009/). There are more than 120 million records in total and I wish to use Hadoop/Hbase in AWS (Amazon Web Services).

2. Also, I would like to create a model to predict delays during severe weather conditions based on previous weather delays. I think this dataset is very interesting and can be analyzed in various dimensions. Hoping to continue my exploration.


