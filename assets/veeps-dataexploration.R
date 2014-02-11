setwd("/Users/vivianpeng/git/edav/_posts")
popdata <- read.table("uspopmap.csv", stringsAsFactors = FALSE, header = TRUE, sep= ",")
head(popdata)

require(ggplot2)
require(maps)
require(maptools)
require(mapproj)

# basic exploration with ggplot

ggplot(popdata, aes(x=Year, y=Pop, color = City)) + geom_point() 
ggplot(popdata, aes(x=Year, y=Rank, color = City)) + geom_point()

names(popdata)
# map distribution on US map

# find max and min longitude and latitude

long <- c(-124,-67 )
lat <- c(25, 50)
all_states <- map_data("state")

head(all_states)
# select for the year 1840
names(popdata)

popdata1840 <- popdata[grep("1840", popdata$Year),]
PopMapDistribution <- ggplot(data = popdata1840, aes(Long,Lat)) 
PopMapDistribution + geom_polygon(data=all_states, aes(x=long, y=lat, group = group, color = State),colour="darkgray", fill="ivory" ) + 
  geom_point(aes(size=Pop, color=Rank, alph = 1/2)) + xlim(long) + ylim(lat)



names(popdata1840)