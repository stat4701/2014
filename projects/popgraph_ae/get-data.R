if (!require(XML)) install.packages('XML')
library(XML)

# Read in raw HTML
uspop <- "http://www.peakbagger.com/pbgeog/histmetropop.aspx"
# which picks the important tables, suppressWarnings prevents warning on 
# 'NA' values from coersion, which will be dropped later
uspop.tables <- suppressWarnings(readHTMLTable(uspop, which = 5:33, colClasses = c("integer","character","numeric")))

nms <- c("Rank","Area","Population","Year")
# create empty master table to append smaller tables to
uspop.table <- data.frame()

# loop through each of the 29 tables and add them to master
for (t in uspop.tables) {
  # year is always in the first row, first column
  year <- as.vector(apply(t[1, ], 2, paste, collapse=''))
  year <- year[1]
  
  # remove rows 1 and 2 as they have header info
  t <- t[-(1:2), ]
  # add "year" column to keep track of the census year
  t[, "Year"] <- year
  
  # append this year's table to the master table
  uspop.table <- rbind(uspop.table, t)
}

# add columns to the master table
names(uspop.table) <- nms
# resets row numbers to incremental
row.names(uspop.table)<- NULL