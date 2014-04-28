
var chart = d3.parsets();
chart.width(850);


    categoryFormat = chart.categoryFormat(),
    percent = d3.format("%");

chart.tooltipFormat(function(d) {
      var count = d.count,
          p = count / d.parent.count,
          path = [categoryFormat(d.name, d.dimension.name)];
      while ((d = d.parent) && d.name) path.unshift(categoryFormat(d.name, d.dimension.name));
      return path.join(", ") + "<br>" + count + ", " + percent(p);
    });





var vis = d3.select("#vis").append("svg")
  .attr("width", chart.width())
  .attr("height", chart.height());


var dataSet = ["includes/age1.csv", "includes/maritalStatus.csv", "includes/countryOfOrigin.csv", "includes/education.csv", "includes/religion.csv"];
function dataFunc(value) {
 d3.csv(dataSet[value], function(csv) {
  vis.datum(csv).call(chart);
  });
}


//set default opening for viz
age();


function age(){
		d3.select("#vis").selectAll("svg").remove();
		chart = d3.parsets().dimensions(["Sex", "Age", "State"]).value(function(d){return +d.count;})
		chart.width(850);
		vis = d3.select("#vis").append("svg")
		  .attr("width", chart.width())
		  .attr("height", chart.height());
	    dataFunc(0); 
	
	chart.tooltipFormat(function(d) {
	      var count = d.count
	          p = count / d.parent.count,
	          path = [categoryFormat(d.name, d.dimension.name)];
	while ((d = d.parent) && d.name) path.unshift(categoryFormat(d.name, d.dimension.name));
	      return count + ", " + path.join(", ") + ", " + percent(p);
})
}




function maritalStatus(){
	d3.select("#vis").selectAll("svg").remove();
	chart = d3.parsets().dimensions(["Sex", "Marital Status", "State"]).value(function(d){return +d.count;})
	chart.width(850);
	vis = d3.select("#vis").append("svg")
	  .attr("width", chart.width())
	  .attr("height", chart.height());
    dataFunc(1); 
    	chart.tooltipFormat(function(d) {
	      var count = d.count
	          p = count / d.parent.count,
	          path = [categoryFormat(d.name, d.dimension.name)];
	while ((d = d.parent) && d.name) path.unshift(categoryFormat(d.name, d.dimension.name));
		      return count + ", " + path.join(", ") + ", " + percent(p);

		// tooltip for Sex, Marital Status, State pancake
		
	    	}
	    )};	
	
function countryOfOrigin(){
		d3.select("#vis").selectAll("svg").remove();
	chart = d3.parsets().dimensions(["Sex", "Country of origin", "State"]).value(function(d){return +d.count;})
	chart.width(850);
	vis = d3.select("#vis").append("svg")
	  .attr("width", chart.width())
	  .attr("height", chart.height());
    dataFunc(2); 
    	chart.tooltipFormat(function(d) {
	      var count = d.count
	          p = count / d.parent.count,
	          path = [categoryFormat(d.name, d.dimension.name)];
	while ((d = d.parent) && d.name) path.unshift(categoryFormat(d.name, d.dimension.name));
	      return count + ", " + path.join(", ") + "<br>" + percent(p);

		
	    	}
	    )};


	
	
	
	
	
