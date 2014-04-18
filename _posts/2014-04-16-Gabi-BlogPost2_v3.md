<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <script src="http://d3js.org/d3.v3.min.js" type='text/javascript'></script>
    <script src="http://dimplejs.org/dist/dimple.v1.1.5.min.js"></script>
  </head>
  <body>
<div class="chartContainer">
<p><style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 600px;
    height: 400px;
  }  
</style></p>
<h3 id="basic-dotplot-using-rcharts">Basic dotplot using <code>rCharts</code></h3>
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
</div>

</body>
</html>