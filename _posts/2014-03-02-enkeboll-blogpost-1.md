---
layout: post
title: Enkeboll - Blog Post 1
description: Fixing a Chart
tags: blogpost1
---

# Blogpost 1: Fixing a graph

[Original Post](http://blogs.wsj.com/digits/2014/02/20/chart-so-how-big-is-whatsapp/)

I disliked this chart because it reports three measures on each of the company, but only shows one (presumably Purchase Price) even though it is trying to make a statment out of the small number of employees it has.

<img src="http://si.wsj.net/public/resources/images/MK-CK222_WHATSA_G_20140220152404.jpg" width="620" alt="Original Chart"/>

I decided to turn it into a bar chart, comparing each of the three measures between the six companies listed.  I initially wanted to display the information as a spider/radar map, but the different scales threw everything off.
The different scales became a big issue for me, both in coding and in chart design (whcich I'm not sure if I made any clearer). The fact that the number of employees is on a very different scale than the purchase price and sales of each of the companies makes the graph slightly difficult to read.  I tried to make this clear by using colored labels and providing textual context.

<img src="https://dl.dropbox.com/s/z6ta2mdej4awsf8/whatsapp.png" width="620" alt="My Redesign"/>

I grabbed the data manually, since there were only 6 observations with 3 measures each. this is stored in a tab separated file, saved as `data.tsv`:

```
Metric	WhatsApp	Gap	Harley-Davidson	Campbell Soup	ConAgra Foods	Best Buy
Purchase Price (Billions $)	19	18.96	14	13.62	12.27	8.65
Sales (Billions $)	0	16.29	5.49	8.13	17.37	48.13
Employees	55	135000	5800	17700	26100	145000
```

I then decided to use d3 to plot the graph.  I got a lot of help fom Bostock on making the chart from [this page](https://github.com/liufly/Dual-scale-D3-Bar-Chart) and help on displaying multiple Y axes from [this page](http://bl.ocks.org/mbostock/3887051)

I used HCL [Colorpicker](http://tristen.ca/hcl-picker/) for the colors.

The code that generates this is below.  Because of the way d3 works, you can't just open the page using file:\\\ in a browser, you must run `python -m SimpleHTTPServer 8000` from a shell.  then you can access the page from your browser at `localhost:8000\blog1.html`.

```html
<meta charset="utf-8">
<style>

body {
  font: 10px sans-serif;
}

.y.axisRight text {
    fill: orange;
}

.y.axisLeft text {
    fill: steelblue;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.bar {
  fill: steelblue;
}

.x.axis path {
  display: none;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var margin = {top: 80, right: 80, bottom: 80, left: 80},
    width = 1000 - margin.left - margin.right,
    height = 600 - margin.top - margin.bottom;

var x0 = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1),
    x1 = d3.scale.ordinal();

var y0 = d3.scale.linear().domain([0, 50]).range([height, 0]),
    y1 = d3.scale.linear().domain([0, 150000]).range([height, 0]);

var color = d3.scale.ordinal()
    .range(["#F07A8B", "#D999D3", "#86C4F9", "#18E6E2", "#7DF89F", "#F0F964"]);

var xAxis = d3.svg.axis()
    .scale(x0)
    .tickSize(0)
    .orient("bottom");

// create left yAxis
var yAxisLeft = d3.svg.axis()
    .scale(y0)
    .ticks(10)
    .tickFormat(d3.format("$.2s"))
    .orient("left");
// create right yAxis
var yAxisRight = d3.svg.axis()
    .scale(y1)
    .ticks(10)
    .tickFormat(d3.format(".2s"))
    .orient("right");

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("class", "graph")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.tsv("data.tsv", function(error, data) {
  var companyNames = d3.keys(data[0]).filter(function(key) {return key !== "Metric"});

  data.forEach(function(d) {
    d.companies = companyNames.map(function(name) { return {name: name, value: +d[name], metric: d.Metric}; });
  });

  x0.domain(data.map(function(d) { return d.Metric; }));
  x1.domain(companyNames).rangeRoundBands([0, x0.rangeBand()]);
  
  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
	  .attr("class", "y axis axisLeft")
	  .attr("transform", "translate(0,0)")
	  .call(yAxisLeft)
	.append("text")
    .attr("transform", "rotate(-90)")
	  .attr("y", 6)
	  .attr("dy", ".71em")
	  .style("text-anchor", "end")
	  .text("Dollars (Billions)");
	
  svg.append("g")
	  .attr("class", "y axis axisRight")
	  .attr("transform", "translate(" + (width) + ",0)")
	  .call(yAxisRight)
	.append("text")
    .attr("transform", "rotate(-90)")
	  .attr("y", 6)
	  .attr("dy", "-1.2em")
	  .style("text-anchor", "end")
	  .text("Employees");

  var bars = svg.selectAll(".bar")
      .data(data)
    .enter().append("g")
      .attr("class", "g")
      .attr("transform", function(d) { return "translate(" + x0(d.Metric) + ",0)"; });

  bars.selectAll("rect")
      .data(function(d) { return d.companies; })
    .enter().append("rect")
      .attr("width", x1.rangeBand())
      .attr("x", function(d) { return x1(d.name) - 5; })
      .attr("y", function(d) { if(d.metric === 'Employees') { return y1(d.value); } else { return y0(d.value); } }) 
      .attr("height", function(d) { if(d.metric === 'Employees') { return height - y1(d.value); } 
                                    else { return height - y0(d.value); } })
      .style("fill", function(d) { return color(d.name); })

  bars.selectAll("text")
      .data(function(d) { return d.companies; })
    .enter().append("text")
      .attr("x", function(d) { return x1(d.name) - 0; })
      .attr("y", function(d) { if(d.metric === 'Employees') { return y1(d.value); } else { return y0(d.value); } })
      .attr("dx", 15)
      .attr("dy", -4)
      .attr("text-anchor", "middle")
      .text(function(d) { format = d3.format(".4s"); return format(d.value); })
      .attr("fill", function(d) { if(d.metric === 'Employees') { return "orange"; } else { return "steelblue"; } });

  var legend = svg.selectAll(".legend")
      .data(companyNames.slice())
    .enter().append("g")
      .attr("class", "legend")
      .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

  legend.append("rect")
      .attr("x", 180)
      .attr("width", 18)
      .attr("height", 18)
      .style("fill", color);

  legend.append("text")
      .attr("x", 200)
      .attr("y", 9)
      .attr("dy", ".35em")
      .style("text-anchor", "top")
      .text(function(d) { return d; });

});


</script>
```