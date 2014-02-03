setwd("/Users/vivianpeng/git/edav/_posts")


require(XML)

# scrape table from URL
theURL <- "http://www.peakbagger.com/pbgeog/histmetropop.aspx"
uspop <- readHTMLTable(theURL, which=4, header = FALSE, skip.rows= 1, as.data.frame= TRUE, stringsAsFactors=FALSE)
head(uspop)
names(uspop)
tail(uspop)

# remove NA columns
uspop.c <- uspop[,1:3]
# remove header rows between tables
uspop.c1 <- uspop.c[! grepl("Rank",uspop.c$V1),]
head(uspop.c1)

# remove year rows
uspop.c1[is.na(uspop.c1)] <- 0
uspop.c2 <- uspop.c1[! grepl("0", uspop.c1$V2),]
head(uspop.c2)


# assign column names
colnames(uspop.c2) <- c("Rank", "City", "Pop")

# create list of all the years
# years 1680-1775
x <- c(1680, 1700, 1720, 1740, 1740, 1775)
year_1775  <- rep(x, times = 4, length.out=24, each = 4)
# years 1790-2010
y <- seq(from=1790, to= 2010, by=10)
year_2010 <- rep(y, times = 20, length.out = 460, each = 20)

# add in years as a column
years <- c(year_1775, year_2010)
uspop.c2$Year <- years


# write results to file
write.table(uspop.c2, "uspop.csv", sep=",", col.names= TRUE, row.names = FALSE)



########################### Data Exploration

# Plot data to map
require(maps)
require(maptools)
require(mapproj)
require(ggplot2)

# load US map
ciityCoords <- read.table("city_latlong.csv", stringsAsFactors = FALSe, header = TRUE, sep= ",")
stateCoords <- read.table("state_latlon.csv", stringsAsFactor = FALSE, header = TRUE , sep = ",")
colnames(stateCoords) <- c("State", "lat", "long")







