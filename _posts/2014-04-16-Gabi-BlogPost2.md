---
layout: post
title: Gabi - Blog Post 2
description: The 10 Most Common Jobs in America
tags: blogpost
---

### Main Source of Data:
For this 2nd blogpost I came across this chart [here](http://www.businessinsider.com/most-popular-jobs-in-america-2014-4). After looking around a bit I found a pdf report [here](http://www.bls.gov/news.release/pdf/ocwage.pdf) with a little more detail on the occupations. I found the data here 
[here](http://www.bls.gov/oes/#news)

### Thoughts on the original government chart:

I decided to focus solely on the first chart and honestly thought it was a little dull and at least lacking color. My initial thought was that the least I could do was make the chart look prettier. I also wondered if I looked at the data if I would come up with the same numbers and how these figures were summarized, and if there was a better way to represent the data.

### Getting the data and some initial troubles:

Getting the data was not too difficult - all I had to do was download a pretty massive excel file. The excel file contains all the information I need with alot of uneeded information - there are over 400,000 rows and about 30 columns. Here are a couple challenges I came accross:
* Loading the data in R: I tried different ways to load the file such as read.csv, read.cvs2, read.table but not matter what I did it looks like the file I just big and I stuck with read.csv. 
* Understanding the different characters I had to remove: As I started looking through the data I noticed that numbers were formatted as characters and that there were empty spaces, commas, symbols such as '*', '**', '#', and not to mention empty useless rows in the data. In order to really understand what other irrelevant information there was in the file I had to unfortunately go back and look at the excel file. So, there was quite a bit of cleaning up to do which took a while and was not as straightforward as I would have liked. 
* Understanding how the data was being summarized: I still dont think I have this correct. In the data there are different groups such as: detail, broad, major, minor and total. No matter which way I summarized the data using R and Excel, I still did not come up with the same numbers as the originial chart! I got the numbers a little bit close using the detail group, but not quite, so my chart will not convey the same message as the original. 
* Plotting the occupational titles: When I started playing with visualizations I came accross the problem of being able to simply wrap the occupational title so that the names do not overlap each other. While this may seem like a pretty simple task, it took me several tries to understand what would work best for what I was trying to accomplish. I tried creating wrapper functions to create a new line after a certain number of characters but the occupational titles were not consistent at all. I ended up by just changing the titles manually one to by one, luckily there were only ten.

### Some visualizations:
Since I hadnt really explored gotplots in ggplot2, I decided to give it a try and created a dot lot of the top 10 occupations. I also played with adding texted within the graph using geom_text function which I had not done before.
[![dotplt_top10](http://Gabya06.github.io/edav/assets/gaby_assets/dotplt_top10.png)](http://Gabya06.github.io/edav/assets/gaby_assets/dotplt_top10.png).

I also played with scatterplots and flippling coordinate axes to see what might look best. 
[![scatterplt_top10](http://Gabya06.github.io/edav/assets/gaby_assets/scatterplt_top10.png)](http://Gabya06.github.io/edav/assets/gaby_assets/scatterplt_top10.png).


### Next steps - rCharts:
Since I also attempted to play with rCharts, I am working on trying to publish these charts and will update shortly.


##### Install and import package
```{r installLibraries, eval= T}
#require(devtools)
#install_github('rCharts', 'ramnathv')
suppressPackageStartupMessages(require(rCharts,quietly = T))
library(knitr)
library(shiny)
load("~/dev/Rstudio/blogpost2/top10.rdata")
```

#### Setup for Charts
```{r setupcharts, echo = T, message = F, cache = F}
require(rCharts)
options(RCHART_WIDTH = 600, RCHART_HEIGHT = 400)
knitr::opts_chunk$set(comment = NA, results = 'asis', tidy = F, message = F)
```

### Basic multiBarChart using `rCharts` 
```{r nPlt1, echo=FALSE, fig.height=400, fig.width=600}
n1 <- nPlot(
  chartID = 'chart10',
  x="occTitle2" , 
  y= "empMillions", 
  data =top10_v2, 
  type ="multiBarChart")
n1$print("chart10", include_assets = TRUE)
n1$save('n1.html',cdn=T) n1$publish('n1',host='gist')
```


### MultibarChart with categories by Employment number
```{r nPlt2, echo=FALSE,fig.height=400,fig.width=600}
nplt <- nPlot(
  chartID ='chart2',
  x="occTitle2",
  y="empMillions",
  group ="Category",
  data= top10_v2,
  type="multiBarChart",
  color = "Category")
nplt$set(width = 600)
nplt$show('iframe')
```


### Basic dotplot using `rCharts` 
```{r dotplt1, echo=FALSE,fig.height=400,fig.width=600}
d1<- dPlot(
  x="empMillions",
  y="occTitle2",
  groups="Category",
  data= top10_v2,
  type="multiBarChart")
d1$xAxis(type = "addMeasureAxis")
d1$yAxis(type = "addCategoryAxis", orderRule = "empMillions")
d1$legend( x = 100, y = 10, width = 700, height = 20, horizontalAlign = "right", orderRule = "Categories")
d1$set(width = 600)
d1$print("chart1", include_assets = TRUE, cdn = TRUE)
```

---
## R Code for file manipulation
```{r readingfile, eval=F, comment="",echo=T,message=FALSE,cache=TRUE, background="skyblue"}
options(stringsAsFactors= FALSE)
file <- read.csv('~/dev/Rstudio/data/oesm13all/oes_data_2013.csv' , strip.white=TRUE)


# select only  important data
occdata <- subset(file, select = c('area','area_title','area_type','naics','naics_title','occ_code','occ_title',
                                     'group','tot_emp','emp_prse','h_mean','a_mean','a_median')  )

# functions to get rid of spaces and commas
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
trim_comma <- function (x) gsub(pattern = ",",replacement = "",x, fixed = TRUE)

# remove any rows with missing values for total employment and average annual and hourly wage 
occdata <- occdata[(!occdata$tot_emp %in% c("**","*","#")) & 
                     (!occdata$a_mean %in% c("*","#"))  & 
                     (occdata$h_mean!="*") ,]

# make sure no commas or white spaces
occdata$tot_emp <- trim(occdata$tot_emp)
occdata$tot_emp <- trim_comma(occdata$tot_emp)
occdata$a_mean <- trim(occdata$a_mean)
occdata$a_mean <- trim_comma(occdata$a_mean)


# subset data with grouped as detail
detail <- with(occdata, subset(occdata, (group=='detail')))

# subset data by major group
major <- with(occdata, subset(occdata, (group=='major')))

# convert from character to number
detail$tot_emp <- as.integer(detail$tot_emp)
detail$a_mean <- as.integer(detail$a_mean)

# aggregate total employee occupation and sort
detail_agg <- aggregate(tot_emp ~ occ_title, data = detail, sum, na.rm = TRUE)
detail_agg <- detail_agg[(order(detail_agg$tot_emp, decreasing = T)),]

# get top10 emploment occupations from detail set
top10 <- detail_agg[(1:10),]

# create a second version of top10 to play with rCharts 
top10_v2 <- top10
# remove underscore from names
names(top10_v2)<- gsub('\\_','',names(top10_v2))

# add levels for total employement
top10_v2$empcat[(top10_v2$totemp <13000000)]<-"low employment"
top10_v2$empcat[(top10_v2$totemp >13000000) & (16000000< top10_v2$totemp)]<-"high employment"
top10_v2$empcat[is.na(top10_v2$empcat)]<-"medium employment"
# add column with employment in millions
top10_v2$totempmil<- signif(top10_v2$totemp/10000000,2)


# change occupations to be shorter names
top10_v2$occtitle2 <- c("Retail","Nurses","Cashiers", "Clerks","FoodPrep","Waiters","Cust Svs","Admin","Janitors","Laborers")
# change names to be more meaninggul
names(top10_v2)<-c("occupTitle","employment","Category","empMillions","occTitle2")

#add factor for employment category
top10_v2$Category <- factor(top10_v2$Category, levels = rev(c("low employment",
                                                              "medium employment","high employment")),
                         ordered = T)
```
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta charset="utf-8">
		<script src="http://d3js.org/d3.v3.min.js" type='text/javascript'></script>
  		<script src="http://dimplejs.org/dist/dimple.v1.1.5.min.js" type='text/javascript'></script>
		<script src="http://labratrevenge.com/d3-tip/javascripts/d3.tip.v0.6.3.js"></script>
		<title>D3: Creating dimple rChartt </title>
	</head>
	<body>
<div class="chartContainer">
<h3 id="install-and-import-package">Install and import package</h3>
<pre class="r"><code>require(devtools)</code></pre>
<pre><code>Loading required package: devtools</code></pre>
<pre class="r"><code>library(rCharts)
library(knitr)
load(&quot;~/dev/Rstudio/blogpost2/top10.rdata&quot;)
#rCharts::open_notebook()
#read_chunk(&quot;~/dev/Rstudio/blogpost2/plots_rCharts.R&quot;)</code></pre>
<h3 id="setup-for-charts">Setup for Charts</h3>
<pre class="r"><code>options(RCHART_WIDTH = 600, RCHART_HEIGHT = 400)
knitr::opts_chunk$set(comment = NA, results = 'asis', tidy = F, message = F)</code></pre>
<h3 id="basic-dotplot-using-rcharts">Basic dotplot using <code>rCharts</code></h3>
<p><style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 600px;
    height: 400px;
  }  
</style></p>

<div id = 'chart15a' class = 'rChart dimple'></div>
<script type="text/javascript">
  var opts = {
"dom": "chart15a",
"width":    600,
"height":    400,
"x": "empMillions",
"y": "occTitle2",
"chartID": "chart15a",
"z": "empMillions",
"groups": "Category",
"type": "multiBarChart",
"id": "chart15a" 
},
    data = [
 {
 "occupTitle": "Retail\nSalespersons",
"employment": 22674065,
"Category": "high employment",
"empMillions":    2.3,
"occTitle2": "Retail" 
},
{
 "occupTitle": "Reg.Nurses",
"employment": 17281827,
"Category": "high employment",
"empMillions":    1.7,
"occTitle2": "Nurses" 
},
{
 "occupTitle": "Cashiers",
"employment": 17119402,
"Category": "high employment",
"empMillions":    1.7,
"occTitle2": "Cashiers" 
},
{
 "occupTitle": "Office Clerks",
"employment": 15903173,
"Category": "medium employment",
"empMillions":    1.6,
"occTitle2": "Clerks" 
},
{
 "occupTitle": "Food Prep \nand Serv. Workers,\nIncl.Fast Food",
"employment": 15757493,
"Category": "medium employment",
"empMillions":    1.6,
"occTitle2": "FoodPrep" 
},
{
 "occupTitle": "Waiters and\nWaitresses",
"employment": 13930973,
"Category": "medium employment",
"empMillions":    1.4,
"occTitle2": "Waiters" 
},
{
 "occupTitle": "Cust Svc\nReps",
"employment": 12644049,
"Category": "low employment",
"empMillions":    1.3,
"occTitle2": "Cust Svs" 
},
{
 "occupTitle": "Admn.Assist,\nExcl.Legal,Med\nAnd Exec",
"employment": 12523873,
"Category": "low employment",
"empMillions":    1.3,
"occTitle2": "Admin" 
},
{
 "occupTitle": "Janitors and\nCleaners\nExcl.Maids",
"employment": 12075777,
"Category": "low employment",
"empMillions":    1.2,
"occTitle2": "Janitors" 
},
{
 "occupTitle": "Laborers and\nMat.Movers,\nHand Workers",
"employment": 11206052,
"Category": "low employment",
"empMillions":    1.1,
"occTitle2": "Laborers" 
} 
],
    xAxis = {
 "type": "addCategoryAxis",
"showPercent": false 
},
    yAxis = {
 "type": "addCategoryAxis",
"showPercent": false,
"orderRule": "empMillions" 
},
    zAxis = {
 "type": "addMeasureAxis",
"overrideMax":     10 
},
    colorAxis = [],
    legend = {
 "x":     10,
"y":     10,
"width":    400,
"height":     40,
"horizontalAlign": "center",
"orderRule": "Categories" 
};
  var svg = dimple.newSvg("#" + opts.id, opts.width, opts.height);

  //data = dimple.filterData(data, "Owner", ["Aperture", "Black Mesa"])
  var myChart = new dimple.chart(svg, data);
  if (opts.bounds) {
    myChart.setBounds(opts.bounds.x, opts.bounds.y, opts.bounds.width, opts.bounds.height);//myChart.setBounds(80, 30, 480, 330);
  }
  //dimple allows use of custom CSS with noFormats
  if(opts.noFormats) { myChart.noFormats = opts.noFormats; };
  //for markimekko and addAxis also have third parameter measure
  //so need to evaluate if measure provided
  //x axis
  var x;
  if(xAxis.measure) {
    x = myChart[xAxis.type]("x",opts.x,xAxis.measure);
  } else {
    x = myChart[xAxis.type]("x", opts.x);
  };
  if(!(xAxis.type === "addPctAxis")) x.showPercent = xAxis.showPercent;
  if (xAxis.orderRule) x.addOrderRule(xAxis.orderRule);
  if (xAxis.grouporderRule) x.addGroupOrderRule(xAxis.grouporderRule);  
  if (xAxis.overrideMin) x.overrideMin = xAxis.overrideMin;
  if (xAxis.overrideMax) x.overrideMax = xAxis.overrideMax;
  if (xAxis.overrideMax) x.overrideMax = xAxis.overrideMax;
  if (xAxis.inputFormat) x.dateParseFormat = xAxis.inputFormat;
  if (xAxis.outputFormat) x.tickFormat = xAxis.outputFormat;
  //y axis
  var y;
  if(yAxis.measure) {
    y = myChart[yAxis.type]("y",opts.y,yAxis.measure);
  } else {
    y = myChart[yAxis.type]("y", opts.y);
  };
  if(!(yAxis.type === "addPctAxis")) y.showPercent = yAxis.showPercent;
  if (yAxis.orderRule) y.addOrderRule(yAxis.orderRule);
  if (yAxis.grouporderRule) y.addGroupOrderRule(yAxis.grouporderRule);
  if (yAxis.overrideMin) y.overrideMin = yAxis.overrideMin;
  if (yAxis.overrideMax) y.overrideMax = yAxis.overrideMax;
  if (yAxis.inputFormat) y.dateParseFormat = yAxis.inputFormat;
  if (yAxis.outputFormat) y.tickFormat = yAxis.outputFormat;
//z for bubbles
    var z;
  if (!(typeof(zAxis) === 'undefined') && zAxis.type){
    if(zAxis.measure) {
      z = myChart[zAxis.type]("z",opts.z,zAxis.measure);
    } else {
      z = myChart[zAxis.type]("z", opts.z);
    };
    if(!(zAxis.type === "addPctAxis")) z.showPercent = zAxis.showPercent;
    if (zAxis.orderRule) z.addOrderRule(zAxis.orderRule);
    if (zAxis.overrideMin) z.overrideMin = zAxis.overrideMin;
    if (zAxis.overrideMax) z.overrideMax = zAxis.overrideMax;
  }
  if(d3.keys(colorAxis).length > 0) {
    myChart[colorAxis.type](colorAxis.colorSeries,colorAxis.palette) ;
  }
  
  //here need think I need to evaluate group and if missing do null
  //as the first argument
  //if provided need to use groups from opts
  if(opts.hasOwnProperty("groups")) {
    var s = myChart.addSeries( opts.groups, dimple.plot[opts.type] );
    //series offers an aggregate method that we will also need to check if available
    //options available are avg, count, max, min, sum
    if (!(typeof(opts.aggregate) === 'undefined')) {
      s.aggregate = eval(opts.aggregate);
    }
    if (!(typeof(opts.lineWeight) === 'undefined')) {
      s.lineWeight = eval(opts.lineWeight);
    }
    if (!(typeof(opts.barGap) === 'undefined')) {
      s.barGap = eval(opts.barGap);
    }    
  } else var s = myChart.addSeries( null, dimple.plot[opts.type] );
  //unsure if this is best but if legend is provided (not empty) then evaluate
  if(d3.keys(legend).length > 0) {
    var l =myChart.addLegend();
    d3.keys(legend).forEach(function(d){
      l[d] = legend[d];
    });
  }
  //quick way to get this going but need to make this cleaner
  if(opts.storyboard) {
    myChart.setStoryboard(opts.storyboard);
  };
  myChart.draw();

</script>

<div class="references">

</div>

</div>

</body>
</html>




