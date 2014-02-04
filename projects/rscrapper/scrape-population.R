library(XML)
URL <- "http://www.peakbagger.com/pbgeog/histmetropop.aspx"
poptable <- readHTMLTable(URL, header=FALSE, stringsAsFactors=T)
#str(poptable, max.level=1)

# build new column names
newnames<-c("Rank","Location","Population","Year")

# loop thru data frames
for(i in 11:33)
{
  # get the first two rows of each table
  yearnm<-as.vector(apply(poptable[[i]][1:2, ],2,paste))
  #print((yearnm)[1])
  # remove first 2 rows of each table
  poptable[[i]]=poptable[[i]][-(1:2),]
  # create 4th column with first element of yearnm (the year)
  poptable[[i]][4]<-(yearnm)[1]
  # assign each data.frame new column names
  names(poptable[[i]])<-newnames
  #print(poptable[[i]])
}

# melt tables into 1 dataframe
# select and reorder
alltables <-melt(poptable[11:33])
alltables <- subset(alltables,select=c(4,1,2,3))

# check the first couple of rows
head(alltables)
# check last few rows
tail(alltables)

# write to cvs file
write.csv(alltables, file="dev/Rstudio/population2.csv", row.names=FALSE)
