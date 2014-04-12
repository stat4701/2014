---
layout: pres
title: Rmd, Rnw, Packaging, and Lattice
description: Rmd, Rnw, Packaging, and Lattice
tags: slides
---

<section>
	<section>
## backlog

- commit from today (I had been on local branch and not pushed. ack!)
  - See Migrations inside
- My [Angular-wrapped d3 plunk](http://plnkr.co/edit/nP5ljv) (directive instead of controller; $http service could also connect to backend)
- High-level libraries doing binding with Angular:
  - [rMaps](http://rmaps.github.io/blog/posts/animated-choropleths/)
  - [Revolution example](http://blog.revolutionanalytics.com/2013/12/combining-the-power-of-deployr-rcharts-and-angularjs.html) (shiny is free instead of deployr)
- [neighborhood word frequencies](https://docs.google.com/spreadsheet/ccc?key=0AruyJI76uB8RdGotd0dDV011aktJV1FYVzVSZmFLcHc&usp=sharing) / [xls link](https://docs.google.com/spreadsheet/pub?key=0AruyJI76uB8RdGotd0dDV011aktJV1FYVzVSZmFLcHc&output=xls)
</section>
	<section>
## Upcoming

- Wednesday, Pablo Barberá
- Wednesday, blog post 2
</section>
</section>

<section>
	<section>
## graphs
</section>
	<section>
## ‘big data’/nyt

[![](http://static01.nyt.com/images/2014/04/07/opinion/07oped/07oped-master675.jpg)](http://www.nytimes.com/2014/04/07/opinion/eight-no-nine-problems-with-big-data.html)
</section>
	<section>
## GFT

[![]({{ site.baseurl }}/assets/gft.png)](http://scholar.harvard.edu/files/gking/files/0314policyforumff.pdf)

[GFT](https://www.google.org/flutrends/us/#US)
</section>
	<section>
# carbon visuals

[![](http://www.carbonvisuals.com/media/item/508/451/508_1385055083-CircleDiagramflat-480.png)](http://www.carbonvisuals.com/products-and-services/interactives)

[NYC clean heat](http://www.nyccleanheat.org/spot-the-soot)

</section>
</section>
<section>
	<section>
## Structure and workflow

1. Interactive R/py
1. Rmd/Rnw (knitr)
1. Repo + README.md
1. R code to `pkg`
1. Rmd to a ‘vignette’
1. Rmd to `example()`

</section>
	<section>
## abstract pattern

1. load data
1. transform data
1. fit model
1. plot fit
1. check model
1. annotation / interactive plots

</section>
	<section>
### Doing that with knitr and a package
`
- Package part
  - functions in R
  - possibly store supplemental data / code
  - testable functions
  - dependencies
  - Versioning
- knitr part
  - Just run it
  - Code inline with what it says it is doing (maybe only in source)
  - cacheing
  - vignette (part of build)

</section>
	<section>
### Other relevant tools

1. Python is a bit of a [mess](http://ged.msu.edu/papers/2012-diginorm/); [IJulia](https://github.com/JuliaLang/IJulia.jl) is a similar pattern
1. [RCloud](https://github.com/att/rcloud)
1. Makefiles
</section>
	<section>
### Packaging concerns

 1. A package suitable to put down and come back to in a year.
 1. A package another collaborator could join and get started on from the documentation
 1. Example: A repo tagged with a release.
 1. A tarball of a repo tagged with a release.
 1. If your data are huge, leave that out of the snapshot.
 1. A link to some rendered `README.md` with instructions to build the result
 1. Rendered results. If html/js or other assets require serving, just note that in the readme
 1. Data privacy or size concerns: *email Malecki*

</section>
</section>

<section>
	<section>
### Lattice functional approach

1. High-level interface (formula) creates subsets
1. Call `panel` function called per-subset
1. Pretty good solution
1. Writing panel functions -- [panel.Dotplot](https://github.com/harrelfe/Hmisc/blob/master/R/xYplot.s#L567) is a clever hack;
1. what would you do to prepare data in ggplot? d3?

</section>
	<section>
### Some more links

1. [The online examples](http://lmdvr.r-forge.r-project.org/figures/figures.html)
1. [Lattice graphs in ggplot](http://learnr.wordpress.com/2009/06/28/ggplot2-version-of-figures-in-lattice-multivariate-data-visualization-with-r-part-1/) ([pdf](http://learnr.files.wordpress.com/2009/08/latbook.pdf))
1. [GridSVG](http://timelyportfolio.github.io/gridSVG_intro/)

</section>
</section>