require(ggplot2, scale)

# set path to file
popFile <- "dev/Rstudio/population2.csv"
# read file in as table
poptable = read.table(popFile, header = TRUE, sep =",")

# build foundation of the plot with ggplot
g <- ggplot(poptable, aes(x=Year, y=Population))
#g # this will give error - need layers when using ggplot

# Add Layers to the basic ggplot
# add lines color coded and grouped by year by using the group aesthetic - basically
# creates line graph w separate line and graph for each year
# need to convert year to a factor to get a discrete color scale
g <- g + geom_line(aes(color=factor(Year), group = Year)) + labs(title ="Population Growth from 1790-2010\n All Data")
g <- g + scale_y_continuous(label=comma) + scale_color_discrete(name = "Year")
g

# since there isnt much data before 1900, let s subset on poptable
poptable1900 <- poptable[which(poptable$Year >= 1900),]
head(poptable1900)
# build basic ggplot & add layers
g1900 <- ggplot(poptable1900, aes(x=Year, y=Population))
g1900 <- g1900 + geom_line(aes(color=factor(Year), group = Year)) 
# format y axis & name the legend year (remove "factor")
g1900 <- g1900 + scale_y_continuous(label=comma) + scale_color_discrete(name="Year")  
# add a title and axis labels
g1900 <- g1900 + labs(title = "Population Growth from 1900-2010\n Reduced Data") 
g1900

# aggregate poptable - remove rank
agg1900 <- aggregate(Population ~ Location + Year, poptable1900,sum, na.rm=TRUE)

# sort by year and population (year is incr and pop is decr)
agg1900 <- agg1900[order(-agg1900$Year, agg1900$Population,decreasing =TRUE),]
head(agg1900)
summary(agg1900)

# check out averages per year after 1900
mean1900 <- aggregate(Population  ~ Year, agg1900, mean, na.rm = TRUE)

# subset to include only pop > average that year
# ave formula - can get average by group
large.pop <- subset(agg1900, Population>ave(agg1900$Population, agg1900$Year))
# check to make sure large.pop includes all cities with pop>average that year
head(large.pop, n= 20)
head(agg1900, n=30)
head(mean1900)

# plot a grid for each location to see trend (these are only location where pop > avg)
l <- ggplot(large.pop, aes(x = Year, y = Population, color = Location)) + geom_line()
l <- l + facet_wrap(~Location,ncol=2) + scale_y_continuous(label = comma) +
  labs(title = "Population Growth from 1900-2010\n Reduced Data")
l

# subset on datat where year > 1950
poptable1950 <- agg1900[which(agg1900$Year >= 1950),]
large.pop2 <- subset(poptable1950, Population>ave(poptable1950$Population, poptable1950$Year))
mean1900[(mean1900$Year>=1950),]

# plot a grid for each location to see trend (these are only location where pop > avg)
l2 <- ggplot(large.pop2, aes(x = Year, y = Population, color = Location)) + geom_line()
l2 <- l2 + facet_wrap(~Location,ncol=2) + scale_y_continuous(label = comma) +
  labs(title = "Population Growth from 1900-2010\n Reduced Data - 2")
l2
#### this doesnt work well with the data that is not complete - look at filledPop-Graph.R