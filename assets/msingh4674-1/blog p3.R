library(ggplot2)
library(ggmap)

setwd("C:/Users/mandeep/Desktop/ms4826/proj")

data <- read.csv("npi_pcg_prod.csv")
colnames(data) <- c("State","City","Specialization","Classification","NPI","Type","Name","Labeler","Drug","Ccount","Cqty","Csum")

freq <- as.data.frame(table(data$City))
longlat <- geocode(unique(as.character(data$City))) 
cities <- cbind(freq, longlat)
colnames(cities) <- c("City","Freq","long","lat")
cities <- cities[order(cities$Freq,decreasing=T),]
top_cities <- cities[1:10,]
states <- map_data("state")
tri_states <- subset(states, region %in% c( "connecticut", "new jersey", "new york")) 
p <- ggplot(tri_states, aes(x=long, y=lat, group = group)) 
p <- p + geom_polygon(fill="grey10", colour="white") 
p <- p + xlim(-80, -70) 
p <- p + geom_point(data=top_cities, inherit.aes=F, aes(x=long, y=lat, size=Freq), colour="red", alpha=.8) + scale_size(name="Claim Frequency")
p <- p + geom_text(data=top_cities, inherit.aes=F, aes(x=long, y=lat, label=City), vjust=1, colour="red", alpha=.8)
p + ggtitle("Physician Claims in TriState Area")
