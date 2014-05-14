## LECTURE 13 ##

## ADVANCED VISUALIZATION! ##

## Today we're going to go on a buffet tour of some of the cool visualization
## tools you can use to explore your data and help others interact with it.

## Last time we saw a way to look at lots of data all at once with the pairs() plot.
## We saw how knowing that certain variables related to each other could guide us
## to make conclusions about what terms were related, whether they should be clustered,
## etc.  However, we really had to work to color points so that we could correlate
## them across different plots or do dimensionality reduction to try to look at the
## data in 2D.  Isn't there an easier way?

## There is!  Ggobi!  If you're on Windows or Linux,
## follow the installation instructions here:
##
## http://www.ggobi.org/downloads/
##
## OR here
##
## http://www.ggobi.org/rggobi/
##
## If you're on OSX, this worked for me:
## From the commandline, run
##
# Install gtk
# curl -O http://r.research.att.com/libs/GTK_2.18.5-X11.pkg
# open GTK_2.18.5-X11.pkg

# Install ggobi
# curl -O http://r.research.att.com/libs/ggobi-2.1.8-darwin8-bin2.tar.gz
# sudo tar fvxz ggobi-2.1.8-darwin8-bin2.tar.gz -C /

install.packages("rggobi")

## Ggobi helps you visualize large datasets really easy.  Let's take it for a spin!
##

## Follow the tutorial at http://www.ggobi.org/docs/manual.pdf
##


## Overiew of what we did:
## - Open up olive data set (download from link below)

olive <- read.csv("http://www.jakeporway.com/teaching/data/olive.csv", h=T)
## - Play around with some 2D plots
##      Hmm, what do these points correspond to?
## - Identify!  Lets you see info about each point as you wish.  Double-click to permalabel
##      This is good, but it's hard to tell which points are which.  Can we identify them across plots?
## - Sure!  Barchart first (you can make different plots, white border means active)
## - Brush the barchart.  At first, as you move, it'll change.
## - Persistent - neat!  Try coloring each section a different color.
## - Scatter plot matrix shows everything now!  Can do identify here too.
## - Variable transformations let you see your data different ways too
## - What if we only want to plot some groups at a time?
##   - Brush them differently, then play with shadows!
## - OK, this has all been great - we can subset specific regions and link them across plots, but we're missing continuity somehow.
##   Can we get a real sense of the consistency between points?
## - 2D tours!  Coolest thing ever.  Like shining a lightbulb from different angles on a messy knot of wires and
##   seeing the different shadows on the wall as you move.
##   - Add variables in and out of this to see how they change!  Speed up / speed down.
##   - Pause when you see a good separation, then can manually manipulate.
## - Can do variable transformations by hand if desired
## - Parallel coordinate plots are cool for seeing how certain rows vary across variables

## So how does this help us in an R class?
## You can combine the two!

install.packages("rggobi")
library(rggobi)

g <- ggobi(iris)
clustering <- hclust(dist(iris[,1:4]),method="average")
glyph_colour(g[1]) <- cutree(clustering, 3)

# Can interact with Ggobi programmatically if we like!
d <- display(g[1], "XY Plot")
variables(d)
variables(d) <- list(X=4:1)

# Can save displays as pictures
ggobi_display_save_picture(d, path="/Users/203289/temp.jpg")

# Because things are updated continuously, we can make animations super quickly
df <- data.frame(
  x=1:2000,
  y=sin(1:2000 * pi/20) + runif(2000, max=0.5)
)
g <- ggobi_longitudinal(df[1:100, ])
df_g <- g[1]
for(i in 1:1901) {
  df_g[, 2] <- df[i:(i + 99), 2]
}

# Can also get the tour projections!
g <- ggobi(iris[,1:4])
d <- display(g[1], "2D Tour")
vec <- ggobi_display_get_tour_projection(d)
library(MASS)
eqscplot(as.matrix(iris[,1:4]) %*% vec, col=as.integer(iris[,5]))


## GGPLOT ##

# If you're like me, you were blown away by how easily R can plot things.
# plot(x, y) and you're up and running!  The flexibility to alter
# literally *anything* on the plots is amazing too. The only trouble is,
# you really have to dig into the plot() functions to learn how to use
# things well.  Moreover, R plots are, well, kind of ugly.  Take this
# as an example:
library(ggplot2)
head(diamonds) # diamond clarity data

# Let's say we wanted to plot diamond price against its carat and color
# the points by their cut:
plot(diamonds$carat, diamonds$price, col=factor(diamonds$cut))

# Woof.  I mean, this works, but yikes, it's kind of ugly.  Moreover,
# the points are hard to distinguish from each other, the x and y 
# labels are the default variables, and there's no legend.  Sucky.  Can
# we do any better?

# Of course we can!  There's a library called ggplot2 that can help
# us make more intuitive and more appealing graphics lickety-split:
p <- ggplot(diamonds, aes(carat, price, color=cut)) + layer(geom="point")
p

# Ah, way nicer!  We've got gridlines, well labeled axes, a legend, and
# colors that are nice and intuitive.

# ggplot is based off of the (g)rammar of (g)raphics, an amazing
# work by Lee Wilkinson that attempts to define all graphics as 
# compositions of basic primitives. For example, you don't have
# a "barchart", you have axes + labels + a data representation +
# attributes on the appearance of the data (namely the bars) +
# etc.  It's a very cool approach and you can learn about it more
# here - http://www.stat.columbia.edu/~gelman/bayescomputation/Wickham2010.pdf

# What's nice about ggplot2 is that you have instant control
# over *every* aspect of your figures with a much more consistent
# framework than R's default par().  The other plus is that a lot of
# thought to aesthetics were put into ggplot2, so the plots
# are arguably nicer to look at than R's defaults.  
# Take a look at some other sweet ggplot graphs:
library(nlme)
p <- ggplot(Oxboys, aes(age, height, group = Subject)) + geom_line()
p # line plots of boys' heights by age

# Same plot with a smoothed regression line across all groups
p <- p + geom_smooth(aes(group = 1), method="lm", size = 2, se = F)
p

# Three versions of a histogram:
d <- ggplot(diamonds, aes(carat)) + xlim(0, 3)

# Density plot
d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = "area")

# Point plot
d + stat_bin(
  aes(size = ..density..), binwidth = 0.1,
  geom = "point", position="identity"
)

# Heat map
d + stat_bin(
  aes(y = 1, fill = ..count..), binwidth = 0.1,
  geom = "tile", position="identity"
)
# Neat 2D filling options for heatmaps
install.packages("hexbin")
library(hexbin)
d <- ggplot(diamonds, aes(carat, price)) + xlim(1,3) +
  opts(legend.position = "none")
d + stat_bin2d()
d + stat_bin2d(bins = 10)
d + stat_bin2d(binwidth=c(0.02, 200))
d + stat_binhex()
d + stat_binhex(bins = 10)
d + stat_binhex(binwidth=c(0.02, 200))

# Histograms of depth broken down by quality
depth_dist <- ggplot(diamonds, aes(depth)) + xlim(58, 68)
depth_dist +
  +     geom_histogram(aes(y = ..density..), binwidth = 0.1) +
  +     facet_grid(cut ~ .)

# Big ol' color plot
depth_dist + geom_histogram(aes(fill = cut), binwidth = 0.1,
                            position = "fill")

# Line plot
depth_dist + geom_freqpoly(aes(y = ..density.., colour = cut),
                           binwidth = 0.1)

# So what the heck are all of these functions doing?  They're
# building up our graphs piece-by-piece likeso:

# The components of a ggplot2 plot are as follows:
# data - the underlying data frame that you want to visualize.  This has
#        all of your raw data in it.
# geom - the "type" of the chart.  "geom" stands for the type of geometry
#        you want to use to represent your data.  For example, a scatter plot
#        uses points to represent data, while a histogram uses bars.  Soon
#        you'll create plots with combinations of geoms that don't have traditional
#        names like "barchart" or "boxplot".
# scaling - each variable in your data frame needs to be scaled to something
#           the computer understands.  For example, our diamond data has
#           clarity ratings like "SI2" and "SI1".  How should R reinterpret these?
#           should they be on a scale from 0 to 1 where ratings closer to 0
#           are "worse" or are they all equivalent, but different, and should
#           be represented as integers, but not where any one is better or
#           worse than any other?  ggplot2 lets you scale your variables to
#           whatever values make sense for your plot.
# aesthetics - Each variable, once scaled, corresponds to a certain aesthetic representation.
#              For example, if we use R's default plot() function and plot
#              plot(a, b), a is mapped to the aesthetic of "x position" and b
#              is mapped to the aesthetic of "y position".  We could also
#              represent different a and b values by their color, size, shape, etc.
#
# facets - Faceting your data is like subsetting it along different variables.
#          ggplot2 uses facets to help you see data side-by-side.  Think of
#          faceting as creating multiple plots based on different values of one
#          variable, e.g. we could make side-by-side plots showing the price distributions
#          of each type of diamond.
#
# multiple layers - why just make a scatter plot?  Layers let you overlay
#                   different transformations of the same data (e.g. the 
#                   x and y data points as well as the straight line from
#                   a linear model fit).
#
# statistics - We can create aggregate statistics of our data and display that
#              as well, of course.  The linear model above is an example
#              of plotting some statistics that are derived from the original data.

# All summed up, one creates a plot by incorporating the following layers:
# - A data and aesthetic mapping
# - A statistical transformation (stat)
# - A geometric object (geom)
# - A position adjustment.

# Phew! Let's go back to our first plot:
p <- ggplot(diamonds, aes(carat, price, color=cut))

# OK, what happened here?
# 1.  The first argument to ggplot is the data we want to use.  Simple enough.
# 2.  The second argument to ggplot is the "aes" or "aesthetics" argument.
#     This is where we specify mappings between variables and their aesthetics.
#     The first two arguments are, by default, x and y position, after which
#     we need to specify named arguments like "shape", "size", "color", etc.
#     In this case we're plotting carat on the x axis, price on the y axis, and
#     coloring the diamonds by their cut.

# So what gives, why didn't it print anything??
#
# In ggplot we *construct* plots, so we're building a plot object that
# we'll later display.  To plot something, we need to add at least one 
# layer and, so far, we've just set up the data and aesthetics for this plot.

# The simplest layer is just one that specifies the geom we want to use.
# We can add layers to our plot object p with the "+" operator.  Let's
# simply add a layer that says we want to use points:
p <- p + layer(geom="point")

# Simply type "p" to see our plot
p

# Neato!  Compare this to how we would have done this in R:
plot(diamonds$carat, diamonds$price, col=diamonds$cut, pch=19)

# Now there are a *LOT* of defaults going on here in the layer() function.
# You could actually control a lot more here, including the
# for example, to make a
# Zoolander histogram (blue steel), we could do this:

p <- ggplot(diamonds, aes(x = carat))
p <- p + layer(
  geom = "bar",
  geom_params = list(fill = "steelblue"),
  stat = "bin",
  stat_params = list(binwidth = 0.1)
) 
p

# There's SO much more to go into to learn ggplot2, but hopefully
# this gives you a taste and lets you know it's out there.  Go play!

## D3 ##
# Head to the other code file for this lesson! 
# http://jakeporway.com/teaching/code/D3.zip.

## EXPLORING DATA ##

# One of the biggest questions I've gotten so far is
# "Sure, I've got some data and I know all these techniques, but
# what should I look at?  And how?"  Here's a quick and dirty method
# for doing data analysis:

# STEP 0:  Get your data into R and understand what it is, conceptually (e.g. is this mortality data?)
# STEP 1:  1D Analysis:  Analyze each variable individually and understand its properties.
#          - What are the min/max values?
#          - What is the distribution of the variable?
#          - What are the counts of occurrences of values for this variable (table())?
#          - Are there outliers?
# STEP 2:  2D Analysis:  Analyze pairs of variables together that might be related
#          - How are pairs of variables correlated?  (pairs())
#          - Do certain variables behave together in interesting ways?
#          - Are there any outliers?

# At this point you should have a good sense of the properties of your data.
# If you're stuck thinking about what to do, here are some tips:
#  - If it's x,y or lat,lon data, plot it on a map.
#  - If it's time data, plot it over time, looking for cycles and outliers.
#  - If it's text data, find frequent words.
#  - If it's continuous numerical data, describe its distribution and any outliers.
#  - If it's factor data (e.g. race, in the Stop and Frisk) count up the occurrences
# 
# Once you've done that for single variables, go ahead and ask simple questions
# about pairs of data.  The trick is simply to ask, "how does x relate to y?"
# For example, in the Stop and Frisk data, we could pick age and race and
# simply ask "how does the age of the person relate to the race of the person?"
# More specifically, this could be asking "what are the ages of people stopped
# by race?" or "which race has the most old/young people stopped?"  You could
# explore these questions by looking at the distributions of ages by race,
# for example.  Usually looking at data this way leads us to questions we 
# want to examine more deeply.

# Once you've gotten here, you can go further by:
#  - Using ggobi to visualize multiple dimensions or brush your data.
#  - Using multidimensional scaling to find low-level patterns in your data.
#  - Clustering your data to find hidden patterns within it.
#  - Building classifiers to predict categorical outcomes (e.g. can we guess if
#    someone will be arrested based on their demographics).
#  - Building linear models to predict continuous outcomes (e.g. can we predict
#    someone's weight from their height).

# And that's pretty much it!  The first 1D and 2D analyses will probably
# get you nearly all the way to the end of your project - the rest (classification
# or clustering) are really just gravy.  The hardest part of this process
# is really just finding the right question to ask once you've seen the data.
# 
# Good luck!