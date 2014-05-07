Yahoo Politician and Athlete Search
=========

------

Project Description
-------------------

The data source for this project was selected from yahoo and it covered search data for users across various states who searched for athletes and politiciansThe data provided by Yahoo Research Labs (YRL) contained locations in various states, athlete or politician users searched for and the host or URL they visited to explore more about their search.
The goal of this project is to analyze this data to understand the degree of interest by users in various states for sports or politics, the most widely visited URL to learn about their subjects, correlation of interests – ex. Search for out-of-state athletes or politicians, and lastly determine to the best possible degree their primary search objective.

**Step 1 – Data Exploration and Discovery**

I explored various data sources and found Yahoo Research Labs (YRL) had a wide variety of data domains. While exploring these domains, I found one of the most interesting data sets on users searching for politicians and athletes in various states in the US. I found this data to be quite uncommon, at the outset two fundamentally distinct areas of interest and was curious to understand the correlations that might exist between these two domains.
Four large data sets in xml formats were obtained from YRL. 

**Step 2 – Data Management**

The following activities were completed to get the data ready for analysis and insights.
1.	Get raw data from YRL
2.	Issues with the provided XML file - Cleansed the XML file and created schema before extracting.
3.	Extracted the dataset using R XML package and loaded it into R.
4.	Created smaller workable data groups and loaded the dataset for statistical analysis into Minitab.

**Step 3 - Insights **

**Politician -- URL Hits **
Looked at the data in various dimensions by State, Host/URL and most occurrence.

High level – Top 10 searches in 2012. As you can see Sarah Palin and Obama have the maximum searches. Sara Palin over 75000 URL hits.


<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/TopYahoohit.png" width = "100%>


Furthur looking Sarah palin - We find California region has the maximum number of people doing the searches.

<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/SarahPalin.png" width = "100%">

Additionally comparing the hits for Obama and Sarah Palin we see the that

<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/ObamaSarahpalin.png" width = "100%">

<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/URLobama.png" width = "100%">

Used R and Mintab to do Stat calculations .. non normal data 

Used Chisquare to do hypothesis testing to see if there is any relationship between Birthplace, homestate, state political popularity.

There seemms to be no such connections. 
Chi sq. Test of Independence:
H0: Variable A and Variable B are independent. 
Ha Variable A and Variable B are not independent.
Variable A :  state affiliation does not affects politician affiliation during search
Variable B : state affiliation affects politician affiliation during search
                         Test            Contribution
Category  Observed  Proportion  Expected     to Chi-Sq
Rep         112537         0.5     75187       18554.0
Dem          37837         0.5     75187       18554.0


     N  DF   Chi-Sq P-Value
150374   1  37108.1    0.000

Heat map : From R

<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/heatmap.png" width = "100%">


**YAHOO Athletes Data Set**

Yahoo Data Set : Initial Look at the Athletes data Set 
-	Basic graphical Analysis shows California is still the state that does the most search queries.
-	Followed by Texas, Virginia,georgia.
-	Wikipedia – most used for information both politics and athletes.
-	DJ williams – Almost 20% of the searches.


<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/AthleteCounter.png" width = "100%">

Additional charts to look at the distribution of data in states

<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/MostSearchAthletes.png" width = "100%">

<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/AthleteSearchData.png" width = "100%">

<img src = "https://raw.githubusercontent.com/anetaramesh/edav/gh-pages/assets/AthleteWebsearch.png" width = "100%">






** What did I learn**

* Learnt how to load XML data into R, do basic stat and graphs with ggplot,gplots
* Used libraries ggplot2 and maps to create the  visualizations
* Also used minitab to some regression and Chisquare tests.

 ** What I hope to do **
 
* I hope to find correlations between Athletes and Political searches .
* Currently working on presently a visual in D3 between Athletes /States and URL 




Aneta Ramesh
