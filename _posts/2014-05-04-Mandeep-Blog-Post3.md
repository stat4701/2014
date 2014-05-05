---
title: Mandeep's Blog Post 3
description: Visualizing geocode data in R using ggmap package
tags: blogpost
---

The intent behind this blog post is to learn how to use R's ggmap package to visualize geocode data. There are many options available in R to visualize geocode data but my research indicates this package provideds detailed output with a few lines of code.
I am so satisified with the ease of using this package that we have also incorporated this in our final project analysis.
[Source: ggmap package description](http://www.inside-r.org/packages/cran/ggmap/docs/geocode) 

Here's a breakdown of what I did for this blog post:

1\. I used the geocode function in the package and passed it the city information which I had in a dataframe created for the source excel data file.

This is how you capture the longitude and latitude information for the cities and append it to the dataframe:
```{r chunkLabel}
library(ggmap)
freq <- as.data.frame(table(data$City))
longlat <- geocode(unique(as.character(data$City))) 
cities <- cbind(freq, longlat)
```

2\. The second step was to generate a map of all the U.S. state on which I can superimpose the data I have for all the cities that I want to show in the visualization.
```{r chunkLabel}
states <- map_data("state")
p <- ggplot(states, aes(x=long, y=lat, group = group)) 
p <- p + geom_polygon(fill="grey10", colour="white") 
```

3\. In my dataset I wanted to focus on the tri-state area and so I created a subset vecotr of all the cities in the New York, New Jersey and Connecticut Area.
```{r chunkLabel}
tri_states <- subset(states, region %in% c( "connecticut", "new jersey", "new york")) 
p <- ggplot(tri_states, aes(x=long, y=lat, group = group)) 
```
4\. Finally I plot the points on the map by passing the dataframe with the longitude and latitude columns and size of the point as the frequency.

I also changed the x coordinates to focus on the tristate area in the map and added another layer for showing the city name on the map.
```{r chunkLabel}
p <- p + geom_point(data=top_cities, inherit.aes=F, aes(x=long, y=lat, size=Freq), colour="red", alpha=.8) + scale_size(name="Claim Frequency")
p <- p + xlim(-80, -70)
p <- p + geom_text(data=top_cities, inherit.aes=F, aes(x=long, y=lat, label=City), vjust=1, colour="red", alpha=.8)
```

5\. [Source code in R](https://github.com/msingh4674/edav/tree/gh-pages/assets/msingh4674-1/blog p3.R)  Complete source code of the R script.

![Plot](https://github.com/msingh4674/edav/tree/gh-pages/assets/msingh4674-1/ggmap.png)

Future Improvements

I plan to explore more the output = "more" in the geocode() function of the ggmap package. This gives more detailed information on the location in addition to 
the longitude and latitude coordinates. 





