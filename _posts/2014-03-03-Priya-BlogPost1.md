##Junk Chart - Green House Gas Emission by Country

[Source](http://cait2.wri.org/wri/Country%20GHG%20Emissions?indicator=Total%20GHG%20Emissions%20Excluding%20LUCF&indicator=Total%20GHG%20Emissions%20Including%20LUCF&year=2010&chartType=bars.)

For my first attempt to improve a Junk chart, I decided to make the above graph more readable and informative. In particular, I focused on 2010 data and built bar charts and line graphs using Tableau.

###Data Extraction

Data for the original bar chart is available for download at the website mentioned above and it is a fairly simple data with amount of Emission of CO2 for 185 countries.

###Weakness of the Original Design

Few of the shortcomings that I could perceive are, 

1. Many bars are congested in a single page view which makes the chart almost unreadable.
2.	While the legend/labels are scrollable, the bar chart itself doesn’t scroll.
3.	Bars are so thin that one cannot mouse over effectively to identify color Vs country Mapping.
4. Since the underlying data is ranging from 0.05 to 10K, scaling is an issue.
5. Since the chart is about CO2 emission which is a key climate-relevant data, it would be beneficial to highlight countries with high and low levels of CO2 emission.
	

###My Design Rationale

1. Countries are ranked by CO2 emission levels.
2. Make the bar chart interactive and to provide filtering capabilities. Provide slide bar to filter based on emission levels.
3. Since the chart is to be plotted for 180 countries, groupings like Top5, Bottom5 and other countries will help to improve visualization.
4. I decided to enrich the graphic by plotting the median so as to enable comparison between Top5/Bottom5/Any Country with median emission level.

###The Finished Product

[Modified Graphic](http://public.tableausoftware.com/views/CountryVsCO2Emission_GP1/Dashboard1?:embed=y&:display_count=no)

###Observations

1. Since there were 185 countries, it was difficult to make sense of the graph without being interactive. Also the range of data (from 0.05 to 10K) for 185 frequencies made it difficult to visualize the data using line graph or tree map.
2. Hoping to try future graphs with rCharts (Another Interactive Visualization using R).






