---
layout: posts
title: Visualizing data - A contrarian view
description: Assignment 1 - Reimagining City Population data
Tags: assignment KISS minimalistic visualization not chartoons
---
## Reimagining City Populations Data 1790 to 2010

#### Purpose of graphs and data visualization, per Tukey (1993), is to describe, compare, make an impact and report the results of data analysis.


### Methodology

Philip Guo's insightful work on [Data Science Workflow: Overview and Challenges](http://cacm.acm.org/blogs/blog-cacm/169199-data-science-workflow-overview-and-challenges/fulltext) is a good starting point on developing a methedology for Exploratory Data Analysis and Visualization (EDAV).  

### Workflow

[![](http://cacm.acm.org/system/assets/0001/3678/rp-overview.jpg)](http://cacm.acm.org/blogs/blog-cacm/169199-data-science-workflow-overview-and-challenges/fulltext) 
(note the redirect!) 

A [checklist for creating data products](http://www.juiceanalytics.com/writing/a-checklist-for-creating-data-products/)

[![](http://www.juiceanalytics.com/wp-content/uploads/2013/10/JuiceChecklist-ProductManager.png)](http://media.juiceanalytics.com/downloads/JuiceChecklist-ProductManager.pdf)

>> Expand on :
Its different from information graphics
Strength and Weaknesses of the current trend
A balanced approach
High priesthood of data scientists and analysts
I come not to praise Caesar but to burry him

### Approach
The choice of an approach depends on the time available and the frequency of analysis.  In addition, the visualization choices will differ immensely for a business decision makers than for the general public.  
This attempt leans towards simplicity, speed and clarity versus visually rich complex and dynamic graphs.  

The aim was to add US regional and state metadata to this city level data.  This would provide an ability to assess trends at the state and compare regional population growths.  

#### Prepare

##### Base dataset:

The City Population data set is from the [US Census website](http://www.census.gov).  Professor [Malecki](https://github.com/malecki/) eased us into the world of web scrapping and data munging by providing a csv dataset. 
The uspop.csv is the starting point of this analysis.  
    
-[Web Scrapper](https://github.com/malecki/edav/blob/uspop/projects/popgraph/get-data.py)

-[US Population uspop.csv](https://github.com/malecki/edav/blob/gh-pages/projects/darrenxing/citypop.csv)

The base dataset ranks (top 20) populations of US cities.  This is census data covering a period of 1790 to 2010.  Data are not available for all cities for every time the census was taken.  There are gaps in the data.  

##### Software and platforms
The following tools were used to support this analysis:

- Version control: Github (public on-line repository)

- Hosting:    [Github](https://github.com/malecki/edav) (local copies of repository and files).  Some insights was twitted.  The images embedded in the [tweets](https://twitter.com/mayankmisra) were brought back into this post to avoid issues with asset includes from pull requests.  

- Data Integration and enrichment: [Data Wrangler](http://vis.stanford.edu/wrangler/) and [Tableau Public](http://www.tableausoftware.com/public//)

- Visualization: [Tableau Public](http://www.tableausoftware.com/public//)

##### Ancillary data sets: 

The AdWords datasets available from Google were used enrich the state and regional information.  

The ZIP data, though available, was not added to the base dataset as it would have been of marginal benefit given the choice of visualization tool (Tableau).  The tool provides an easy way to map data to a geography, given that the dataset contains country, state and city information.  I assume this is done by inbuilt libraries that already have the longitude and latitude mapped for, at least, the major countries/state/cities.  

-[DMA Regions and their associated cities](http://goo.gl/itBaJE)

-[DMA Geographical Targeting](http://goo.gl/zYf1gK)

##### Wrangled Data

- Data Wrangler was used for basic clean up.  

- The base dataset CSV was cleaned for spaces and commas.  Some cities were listed with states (Newport, RI).  

- The state, where existed, was extracted to its own column.  This way we didn't loose the orignal state mapped to a city. This came in handy when states were added through other sources for the rest of the cities.  

- The headings were extracted from the first row.  

Here is the python code derived from data wrangler for cleaning up the csv file:

```
from wrangler import dw
import sys

if(len(sys.argv) < 3):
	sys.exit('Error: Please include an input and output file.  Example python script.py input.csv output.csv')

w = dw.DataWrangler()
# Output version - wrangled_1_citypop1.csv
# Split data repeatedly on newline  into  rows
w.add(dw.Split(column=["data"],
               table=0,
               status="active",
               drop=True,
               result="row",
               update=False,
               insert_position="right",
               row=None,
               on="\n",
               before=None,
               after=None,
               ignore_between=None,
               which=1,
               max=0,
               positions=None,
               quote_character=None))

# Split data repeatedly on ','
w.add(dw.Split(column=["data"],
               table=0,
               status="active",
               drop=True,
               result="column",
               update=False,
               insert_position="right",
               row=None,
               on=",",
               before=None,
               after=None,
               ignore_between=None,
               which=1,
               max=0,
               positions=None,
               quote_character="\""))

# Cut  on '"'
w.add(dw.Cut(column=[],
             table=0,
             status="active",
             drop=False,
             result="column",
             update=True,
             insert_position="right",
             row=None,
             on="\"",
             before=None,
             after=None,
             ignore_between=None,
             which=1,
             max=0,
             positions=None))

# Promote row 1  to header
w.add(dw.SetName(column=[],
                 table=0,
                 status="active",
                 drop=True,
                 names=[],
                 header_row=0))

# Split city between ' any word ' and ', '
w.add(dw.Split(column=["city"],
               table=0,
               status="active",
               drop=True,
               result="column",
               update=False,
               insert_position="right",
               row=None,
               on=".*",
               before=", ",
               after="[a-zA-Z]+",
               ignore_between=None,
               which=1,
               max=1,
               positions=None,
               quote_character=None))

# Split split4 between ' ' and ' any word '
w.add(dw.Split(column=["split4"],
               table=0,
               status="active",
               drop=True,
               result="column",
               update=False,
               insert_position="right",
               row=None,
               on=".*",
               before="[a-zA-Z]+",
               after=" ",
               ignore_between=None,
               which=1,
               max=1,
               positions=None,
               quote_character=None))

# Drop split5
w.add(dw.Drop(column=["split5"],
              table=0,
              status="active",
              drop=True))

w.apply_to_file(sys.argv[1]).print_csv(sys.argv[2])

```

- Tableau was used to merge data sets.  

- Regional and State information was added to the city using the AdWords DMA Targeting and Regional datasets.  The AdWords data is global.  It was filtered for US and then merged with the base dataset.  

-[Finally the cleaned data set](http://public.tableausoftware.com/views/City_Population_Trend/Data?:embed=y&:display_count=no)
[![](https://pbs.twimg.com/media/BhxsUWMIMAEylvj.png:large)](http://public.tableausoftware.com/views/City_Population_Trend/Data?:embed=y&:display_count=no)

- As a biproduct of this process, [a reference file on US State to City look up]({{ site.baseurl}}/assets/mm3557-cp-city-state-lkup.csv) was derived.  This can be helpful in future projects and is made available publicly on Github.  


#### Analysis

-[Trend Summary - National](http://public.tableausoftware.com/views/City_Population_Trend/TrendSummary-GeoHierarchy?:embed=y&:display_count=no)
[![](https://pbs.twimg.com/media/Bhxs-fkIMAAEwzw.png:large)](http://public.tableausoftware.com/views/City_Population_Trend/TrendSummary-GeoHierarchy?:embed=y&:display_count=no)

-[Population Migration](http://public.tableausoftware.com/views/City_Population_Trend/PopulationMigration?:embed=y&:display_count=no)
[![](https://pbs.twimg.com/media/Bhxtap5IMAAM025.jpg:large)](http://public.tableausoftware.com/views/City_Population_Trend/PopulationMigration?:embed=y&:display_count=no)

-[Population Size - Census Region/Division](http://public.tableausoftware.com/views/City_Population_Trend/PopulationSize-CensusRegionDivision?:embed=y&:display_count=no)
[![](https://pbs.twimg.com/media/BhxuMNuIEAALcAt.png:large)](http://public.tableausoftware.com/views/City_Population_Trend/PopulationSize-CensusRegionDivision?:embed=y&:display_count=no)


#### Reflection

#### Dissemination

### Thoughts

Visual display of data of data is not only for communicating inferences and insights to a broader audience unfamiliar with the dataset.  The more powerful use of visualizing data is as a medium to grasp relationships in multi-dimensional and complex datasets.  

Network graphs do this exceptionally well.  I have provided my Facebook and LinkedIn social network graphs. Visualizing my connections in this form, I was able to form powerful insights about the way people in my network are connected with each other and to me.   

A network graph I created of [my Facebook connections](http://t.co/TNgVXpwBcy)
[![](https://pbs.twimg.com/media/Bhw6GIeIAAAAGWd.jpg:large)](https://twitter.com/MayankMisra/status/440290740791689217/photo/1/large) is based on [Gephi](https://gephi.org/).  

Connections form [Taj Hotel, a TATA company](http://www.tata.com/company/profile/Indian-Hotels), where I worked right after college, holds the center (blue/yellow).  The top connections are connected to me through my wife while the right and bottom ones are from where I have lived in the US.  On the left are folks I know from [work](http://www.pfizer.com).  I also found some outliers... which will be pruned soon...

A similar one for [my professional connections on LinkedIn](https://pbs.twimg.com/media/Bhw7p_DIcAA9ce4.jpg:large) created using the [LinkedIn Labs graph app](http://bit.ly/1kKpr1G) 
[![](https://pbs.twimg.com/media/Bhw7p_DIcAA9ce4.jpg:large)](https://twitter.com/MayankMisra/status/440292456224276480/photo/1/large)

The legend reflects the various clusters in the graph.  




