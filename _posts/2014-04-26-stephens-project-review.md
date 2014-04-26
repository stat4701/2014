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
## Yet to come

- Explore data from a user/relationship perspective
- Explore the textual data (ML project)
- Share the data (Crossfilter magic in blog post 3)
- Incorporate data from [CA Communities](https://communities.ca.com/)
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

[My code](https://github.com/StephenKappel/dataology/tree/master/MsdnForums/ForumScraper)

- Get list of forum categories
- Get a list of forums in each category
- Get a list of threads in each forum
- Get details for each thread

</section>
	<section>
## Exploration and Modeling

[The unabridged narrative](https://github.com/StephenKappel/dataology/blob/master/MsdnForums/ExplorationAndCommentary.md)

- SharePoint and SQL Server forums cluster fairly distinctly.
- Shorter titles and questions attract more success.
- MSFT involvement dropped off significantly as 2013 progressed.
- Time of day and day of week impact TTFR much more than TTFA.
</section>
</section>
<section>
	<section>

## Pending Improvements

#### Logit regression model

- Add co-variates and power terms
- Engineer features differently
- Better visual representation of results

#### Regression tree model

- Broaden scope to include features that are not known initially

</section>
	<section>
## Suggestions?

- Long knitr doc is not easily navigable
- Repetitive code for ggplot graphing
- Customization of ggthemes
- adding fill/stroke colors to theme
- Color-coding of R code in rmd
</section>
	<section>
## Lessons learned

- knitr is awesome!
- For SQL geeks, SQL view -> RODBC is clean workflow.
- Beware of the *family* parameter in *glm()*.
- When too many points, aggregate with ddply.
- factor-ize numerical values with sapply
</section>
</section>