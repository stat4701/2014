<!DOCTYPE html>
<meta charset="utf-8">
<style>

body {
  font: 10px sans-serif;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.dot {
  stroke: #000;
}

.tooltip {
  position: absolute;
  text-align: center;
  width: 220px;
  height: 38px;
  background: #ddd;
  border: solid 1px #aaa;
  border-radius: 8px;
  pointer-events: none;
}

</style>

<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 800 - margin.top - margin.bottom;

var xValue = function(d) { return d.budget_raw; }, //data -> value
    xScale = d3.scale.linear().range([0, width]),
    xMap = function(d) { return xScale(xValue(d));},
    xAxis = d3.svg.axis().scale(xScale).orient("bottom");


var yValue = function(d) { return d.earnings_ratio; }, //data -> value
    yScale = d3.scale.log().range([height, 0]),
    yMap = function(d) { return yScale(yValue(d));},
    yAxis = d3.svg.axis().scale(yScale).orient("left").ticks(20, ",.1s");

var cValue = function(d) { return d.even;},
    color = d3.scale.category10();


var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var tooltip = d3.select("body").append("div")
    .attr("class", "tooltip")
    .style("opacity", 0);

d3.csv("simple_movie_info.csv", function(error, data) {
  data.forEach(function(d) {
    d.budget_raw = +d.budget_raw;
    d.earnings_ratio = +d.earnings_ratio;
    console.log(d);
  });

  <!-- x.domain(d3.extent(data, function(d) { return d.budget_raw; })).nice(); -->
  <!-- y.domain(d3.extent(data, function(d) { return d.earnings_ratio; })).nice(); -->
  xScale.domain([d3.min(data, xValue)-1, d3.max(data, xValue)+1]);
  yScale.clamp(true).domain([d3.min(data, yValue)+ .01, d3.max(data, yValue)+1]);
  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)
    .append("text")
      .attr("class", "label")
      .attr("x", width)
      .attr("y", -6)
      .style("text-anchor", "end")
      .text("Production Budget");

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("class", "label")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Earnings Ratio");

  svg.selectAll(".dot")
      .data(data)
    .enter().append("circle")
      .attr("class", "dot")
      .attr("r", 3.5)
      .attr("cx", xMap)
      .attr("cy", yMap)
      .style("fill", function(d) { return color(d.even); })
      .on("mouseover", function(d) {
          tooltip.transition()
               .duration(200)
               .style("opacity", .9);
               tooltip.html(d.movie + "<br/>World Gross: " + d.worldwide_gross +
                 "<br/>Budget: " + d.production_budget)
               .style("left", (d3.event.pageX + 5) + "px")
               .style("top", (d3.event.pageY - 28) + "px");
      })
      .on("mouseout", function(d) {
          tooltip.transition()
               .duration(500)
               .style("opacity", 0);
      });

  var legend = svg.selectAll(".legend")
        .data(color.domain())
      .enter().append("g")
        .attr("class", "legend")
        .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

    legend.append("rect")
        .attr("x", width - 18)
        .attr("width", 18)
        .attr("height", 18)
        .style("fill", color);

    legend.append("text")
        .attr("x", width - 24)
        .attr("y", 9)
        .attr("dy", ".35em")
        .style("text-anchor", "end")
        .text(function(d) { return d; });
});

</script>
