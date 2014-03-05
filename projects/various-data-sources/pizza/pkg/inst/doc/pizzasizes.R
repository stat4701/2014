
## ------------------------------------------------------------------------
library(pizzasizes)
library(ggplot2)
data(pizzasizes)
p <- ggplot(pizzasizes, aes(x=size, y=px_inc))


## ----plot0---------------------------------------------------------------
p+geom_point(color="#17807e", alpha=.1, size=3)+geom_smooth()


## ----plot1---------------------------------------------------------------
p+geom_point(color="#17807e", position='jitter', alpha=.1, size=3)+geom_smooth(se=FALSE)


## ----plot2---------------------------------------------------------------
p+geom_point(color="#17807e", position='jitter', alpha=.1, size=3)+geom_smooth(method='loess')


## ----plot3---------------------------------------------------------------
p+geom_point(color="#17807e", position='jitter', alpha=.1, size=3)+geom_smooth(method='loess', se=FALSE)


## ----plot4---------------------------------------------------------------
p+geom_point(color="#17807e", position='jitter', alpha=.1, size=3)+geom_smooth(method='glm',formula=y ~ x+ log(x), se=FALSE)


