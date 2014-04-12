---
layout: post
title: Michael Jiang - Homework One Blog Post
description: 
tags: blog
---

<section>

### Party Affiliation Media Release D3.js Implementation

* Description <br>
The bar chart graph is an d3.js implementation on media releases data about party affiliation. I made a summary about the number of media releases in each states in 2012. <br>
I choose 3 typical states to illustrate my idea. There are California, Ohio and Texas. As we are all familiar with, California is a strong advocate for Democrates, Texas is strong advocate for Republican, while Ohio is somewhat ambiguous in deciding which side to choose. From the number of media releases from each party, we could roughly see the balance or imbalance of party power in these 3 states. Take California as an example, it's easy to see that the number of releases from Democrates is far more than that from Republican, indicating a more broader support for Democrates. <br>
In order to make this idea demostrated more clearly, I changed the color of both bar and fonts, therefore, any red color is related to Republicans, and any blue color is related to Democrates. <br>
Please refer to html in my assests and make the tsv file within the same directory as the html files. <br> <br>

* Snapshots <br>
[![california] (https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets/california.png)](https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets/california.png) <br>

[![Texas] (https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets/texas.png)](https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets/texas.png) <br>

[![Ohio] (https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets/ohio.png)](https://raw.githubusercontent.com/MichaelJ1106/edav/michael_intro/assets/michael_jiang_assets/ohio.png) <br>

* Sample Codes <br>

```html
<meta charset="utf-8">
<style>

body {
  font: 10px sans-serif;
}

h1 {
  color:steelblue;
  text-align:center;
  font-size:70px;
}
.y.axisRight text {
    fill: orange;
}

.y.axisLeft text {
    fill: black;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.bar1 {
  fill: steelblue;
}

.bar2 {
  fill: red;
}

.x.axis path {
  display: none;
}

.d3-tip {
  line-height: 1;
  font-weight: bold;
  padding: 12px;
  background: rgba(0, 0, 0, 0.8);
  color: #fff;
  border-radius: 2px;
}

.d3-tip:after {
  box-sizing: border-box;
  display: inline;
  font-size: 10px;
  width: 100%;
  line-height: 1;
  color: rgba(0, 0, 0, 0.8);
  content: "\25BC";
  position: absolute;
  text-align: center;
}

.d3-tip.n:after {
  margin: -1px 0 0 0;
  top: 100%;
  left: 0;
}


</style>
<body>

<H1 align="center">California</H1>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script src="http://labratrevenge.com/d3-tip/javascripts/d3.tip.v0.6.3.js"></script>
<script>

var margin = {top: 80, right: 80, bottom: 80, left: 80},
    width = 1500 - margin.left - margin.right,
    height = 800 - margin.top - margin.bottom;

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var y0 = d3.scale.linear().domain([0, 70]).range([height, 0]),
y1 = d3.scale.linear().domain([0, 70]).range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

// create left yAxis
var yAxisLeft = d3.svg.axis().scale(y0).ticks(5).orient("left");
// create right yAxis
var yAxisRight = d3.svg.axis().scale(y1).ticks(6).orient("right");

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("class", "graph")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var tip1 = d3.tip()
    .attr("class" , "d3-tip")
    .offset([-10 , 0])
    .html(function(d) {
      return "<strong>Frequency:</strong> <span style='color:steelblue'>" + d.democrat + "</span>";
    });

var tip2 = d3.tip()
    .attr("class" , "d3-tip")
    .offset([-10 , 0])
    .html(function(d) {
      return "<strong>Frequency:</strong> <span style='color:red'>" + d.republican + "</span>";
    });

svg.call(tip1);

svg.call(tip2);

d3.tsv("data_california.tsv", type, function(error, data) {

  x.domain(data.map(function(d) { return d.date; }));

  svg.append("g")
    .attr("class", "y axis axisLeft")
    .attr("transform", "translate(0,0)")
    .call(yAxisLeft)
  .append("text")
    .attr("y", 6)
    .attr("dy", "-2em")
    .style("text-anchor", "end")
    .style("text-anchor", "end")
    .text("Counts");

  bars = svg.selectAll(".bar").data(data).enter();

  bars.append("rect")
      .attr("class", "bar1")
      .attr("x", function(d) { return x(d.date); })
      .attr("width", x.rangeBand()/2)
      .attr("y", function(d) { return y0(d.democrat); })
    .attr("height", function(d,i,j) { return height - y0(d.democrat); })
    .on("mouseover" , tip1.show)
    .on("mouseout" , tip1.hide); 

  bars.append("rect")
      .attr("class", "bar2")
      .attr("x", function(d) { return x(d.date) + x.rangeBand()/2; })
      .attr("width", x.rangeBand() / 2)
      .attr("y", function(d) { return y1(d.republican); })
    .attr("height", function(d,i,j) { return height - y1(d.republican); })
    .on("mouseover" , tip2.show)
    .on("mouseout" , tip2.hide); 

});

function type(d) {
  d.democrat = +d.democrat;
  d.republican = +d.republican;
  return d;
}

</script>
```


</section>
