---
layout: pres
title: Stephen's Project Review
description: Diving into MSDN Forums Data
tags: slides
---

<section>
	<section>
# Analyzing MSDN Forums Data
[MsdnForums GitHub Repo](https://github.com/StephenKappel/dataology/tree/master/MsdnForums)
</section>
	<section>
## Why support forums?

- It's my job
- Issue deflection
- Customer engagement

</section>
	<section>
## Why MSDN forums?

- Personal experience
- Lots of data
- Competitive intelligence/benchmark
- Publicly available ([check it out](http://social.msdn.microsoft.com/Forums/en-US/home))

</section>
	<section>
## Project outline

- Gather the data ([Python script](https://github.com/StephenKappel/dataology/tree/master/MsdnForums/ForumScraper))
- Store the data ([SQL Server database](https://github.com/StephenKappel/dataology/blob/master/MsdnForums/DatabaseDiagram.PNG))
- Aggregate the data (SQL views to give tidy table of forums and tidy table of threads)
- Explore the non-textual data ([fun with R](https://github.com/StephenKappel/dataology/blob/master/MsdnForums/ExplorationAndCommentary.md))
</section>
	<section>
## Project outline

- Gather the data ([Python script](https://github.com/StephenKappel/dataology/tree/master/MsdnForums/ForumScraper))
- Store the data ([SQL Server database](https://github.com/StephenKappel/dataology/blob/master/MsdnForums/DatabaseDiagram.PNG))
- Aggregate the data (SQL views to give tidy table of forums and tidy table of threads)
- Explore the non-textual data ([fun with R](https://github.com/StephenKappel/dataology/blob/master/MsdnForums/ExplorationAndCommentary.md))
</section>
	<section>
## Yet to come

- Explore data from a user/inter-personal relationship perspective
- Explore the textual data (ML project)
- Share the data (Crossfilter magic in blog post 3)
- Incorporate data from [CA Communities](https://communities.ca.com/) (and perhaps Stack Overflow)
- Broaden the scope of MSDN forums analyzed
</section>
</section>
<section>
	<section>
## Let's look at the implementation...
</section>
	<section>
## Database design
![Database Diagram](https://raw.githubusercontent.com/StephenKappel/dataology/master/MsdnForums/DatabaseDiagram.PNG)
</section>
	<section>
## Scraping threads

- Get list of forum categories
- Get a list of forums in each category
- Get a list of threads in each forum
- Get details for each thread
[My code](https://github.com/StephenKappel/dataology/tree/master/MsdnForums/ForumScraper)
</section>
	<section>
## Exploration and Modeling
[The unabridged narrative](https://github.com/StephenKappel/dataology/blob/master/MsdnForums/ExplorationAndCommentary.md)
Interesting findings:

- SharePoint and SQL Server forums cluster fairly distinctly. SQL Server forums are: more plentiful, smaller in # of threads, quicker in giving responses/answers, better monitored MSFT employees
- Shorter titles and questions breed more success
- MSFT involvement dropped off significantly as the year progressed
- Time of day and day of week impact time to first reply but not so much time to first answer
</section>
</section>
<section>
	<section>
## Improvements yet to be attempted
Logit regression model

- Add co-variates and power terms
- Engineer features differently
- Better visual representation of results
- 
Regression tree model

- Broaden scope to include features that are not known initially
- 
Break knitr doc into pieces
</section>
	<section>
## Suggestions?

- Repetitive code for graphing, especially applying in applying fill and stroke colors
- Color-coding of R code in rmd
</section>
	<section>
## Lessons learned

- knitr is awesome!
- For those comfortable using SQL, building an SQL view and pulling data in with RODBC package worked cleanly.
- Beware of the *family* parameter in *glm()*.
- When too many data points to plot separately, aggregate with ddply.
</section>
</section>