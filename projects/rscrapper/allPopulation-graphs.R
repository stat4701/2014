# This script takes in the data set with the entire population set
# In comparison with the "population-graph" script, this one pulls all data and not just
# the top ranked cities.
# This data set needs some cleaning ** remove NA

library(ggplot2)
library(scales)

# read file in as csv
citypopMissing <- read.csv("~/edav/projects/popgraph/citypopMissing.csv")

# Clean Data
# remove missing or NA rows 
# remove first column & rename name of dataframe
cleanpop <- citypopMissing[!(citypopMissing$pop=="" | is.na(citypopMissing$pop)),]
cleanpop <- cleanpop[,2:5]
names <-c("Location","Year","Rank","Population")
names(cleanpop) <- names

# plot basic graph showing population since 1790 by year
g <- ggplot(cleanpop, aes(x=Year, y=Population))
g <- g + geom_line(aes(color=factor(Year), group = Year)) + labs(title ="Population Growth from 1790-2010\n All Data")
g <- g + scale_y_continuous(label=comma) + scale_color_discrete(name = "Year")
g


# since there isnt much data before 1950, let's subset data
cleanpop1950 <- cleanpop[which(cleanpop$Year >= 1950),]

# build basic ggplot & add layers
g1950 <- ggplot(cleanpop1950, aes(x=Year, y=Population))
g1950 <- g1950 + geom_line(aes(color=factor(Year), group = Year)) + 
  scale_y_continuous(label=comma) + scale_color_discrete(name="Year")  + 
  labs(title = "Population Growth from 1900-2010\n Reduced Data") 
g1950

# build a histogram - looks prettier
h1950 <- ggplot(cleanpop1950, aes(x=Year, y=Population))
h1950 <- h1950 + geom_histogram(stat="identity", aes(color = Year, group = Year)) +
  scale_y_continuous(label = comma) + labs(title = "Population Growth from 1950-2010\n Reduced Data") 
h1950 

# aggregate population by year
agg1950 <- aggregate(Population ~ Location + Year, cleanpop1950, sum, na.rm=TRUE)

# sort by year and population (year is increasing and pop is decreasing)
agg1950 <- agg1950[order(-agg1950$Year, agg1950$Population,decreasing =TRUE),]
# look @ data
head(agg1950, n=20)

# check out averages per year after 1900
mean1950 <- aggregate(Population  ~ Year, agg1950, mean, na.rm = TRUE)

# subset data to include only the cities where the population was greater than the avg that year
large.pop1950 <- subset(agg1950, Population>ave(agg1950$Population, agg1950$Year))

# plot a grid for each location for 1950-2010
# these are only location where pop > avg
l1950 <- ggplot(large.pop1950, aes(x = Year, y = Population, color = Location)) + geom_line() +
  facet_wrap(~Location,ncol=2) + scale_y_continuous(label = comma) + 
  labs(title = "Population Growth from 1950-2010\n All Data")
l1950
