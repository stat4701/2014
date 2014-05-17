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




