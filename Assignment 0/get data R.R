require(XML)
require(stringr)

# scrape table from URL
theURL <- "http://www.peakbagger.com/pbgeog/histmetropop.aspx"
uspop <- readHTMLTable(doc=theURL, which=4, header = FALSE, skip.rows= 1, as.data.frame= TRUE, stringsAsFactors=FALSE)

# remove NA columns
uspop <- uspop[,1:3]
# assign column names
colnames(uspop) <- c("Rank", "City", "Pop")
# remove header rows between tables
uspop <- uspop[! grepl("Rank",uspop$V1),]

# remove year rows
uspop[is.na(uspop)] <- 0
uspop <- uspop[! grepl("0", uspop$V2),]

# create list of all the years
# years 1680-1775
x <- c(1680, 1700, 1720, 1740, 1740, 1775)
year_1775  <- rep(x, times = 4, length.out=24, each = 4)
# years 1790-2010
y <- seq(from=1790, to= 2010, by=10)
year_2010 <- rep(y, times = 20, length.out = 460, each = 20)

# add in years as a column
years <- c(year_1775, year_2010)
uspop$Year <- years

# split city column into city and state
citystate <- str_split_fixed(uspop$City, ", ", 2)
colnames(citystate) <- c("City", "State")
citystate <- as.data.frame(citystate)

uspop$State <- citystate$State
uspop$City <- citystate$City
head(uspop)

# write results to file
write.table(uspop, "uspop.csv", sep=",", col.names= TRUE, row.names = FALSE)

