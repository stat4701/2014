---
layout: pres
title: graphs, blogposts, and packaging
description: graphs, blogposts, and packaging
tags: slides
---

<section>
### Administrative stuff

- blogposts were due monday;
- second iteration plans are due today/this week;
- class on Wed 9 April is going to be LDA and Twitter
- do we want to move to SSW903 on Mondays? 
- lightning demos?
</section>

<section>
	<section>
## Land mammals by weight

[![](http://imgs.xkcd.com/comics/land_mammals.png)](http://xkcd.com/1338/)

</section>
	<section>
## Swirlogram

[![](http://static1.businessinsider.com/image/52fbfa8c69bedd3118905b64-800-/markets_cotd-new-3.png)](http://www.businessinsider.com/a-swirlogram-of-wage-growth-2014-2)

</section>
	<section>
## “Insight”

[![](https://pbs.twimg.com/media/Bhxtap5IMAAM025.jpg:large)](http://public.tableausoftware.com/views/City_Population_Trend/PopulationMigration?:embed=y&:display_count=no)

</section>
	<section>
## Pleasant places

[![]({{ site.baseurl }}/assets/pleasantplaces.png)](http://www.kellegous.com/j/2014/02/03/pleasant-places/)

</section>
	<section>

## Tips I
[![]({{ site.baseurl }}/assets/cab-tips-1.png)](http://home.uchicago.edu/~haggag/Default_Tips_aej_final.pdf)

</section>
	<section>
## Tips II

[![](http://www.newyorker.com/online/blogs/currency/tipping-map.gif)](http://www.newyorker.com/sandbox/tipping/)
</section>
	<section>
## Pizza II

[![](http://www.npr.org/news/graphics/2014/02/manhattan.gif)](http://www.npr.org/blogs/money/2014/02/21/280745564/the-price-of-a-pizza-in-237-u-s-neighborhoods?utm_medium=facebook&utm_source=npr&utm_campaign=nprnews&utm_content=02282014)

</section>
</section>
<section>
	<section>
### Digging for data

[![]({{ site.baseurl }}/assets/pizza-slider.png)](http://www.npr.org/blogs/money/2014/02/26/282132576/74-476-reasons-you-should-always-get-the-bigger-pizza)

</section>
	<section>
## source

[![]({{ site.baseurl }}/assets/pizza-source-finding.png)](http://apps.npr.org/dailygraphics/graphics/pizza/js/graphic.js)

</section>
	<section>
## So now what?

</section>
	<section>
## So now what?

- recreate with ggplot2
- jitter
- what's the smoother?
- wrap it up in an R package for later?

</section>
	<section>
	
```
df <- read.csv("pizza_m.csv")
f2 <- read.csv("fittedvals_all.csv")
# plyr::join() #?
pizzasizes <- df
save(pizzasizes, file="data/pizza-size.RData")
```

f2 has 'sizes' not 'size'; has 230 rows; could just make a mapping with `aes()`…
</section>
	<section>
## make a package..	
```
package_skeleton("pkg") # convention?
# edit, add, etc
devtools::document()
```
… [et voilà](https://github.com/malecki/edav/tree/gh-pages/projects/various-data-sources/pizza)

</section>
	<section>
## Roxygen

```
##' pizzasizes
##' A data.frame with the data for 
##' http://www.npr.org/blogs/money/2014/02/26/282132576/74-476-reasons-you-should-always-get-the-bigger-pizza
##'
##' @name pizzasizes
##' @docType data
##' @keywords datasets
NULL
```

</section>
	<section>
## *Now* start playing

- make a [vignette](http://malecki.github.io/edav/projects/various-data-sources/pizza/pkg/inst/doc/pizzasizes.html) ([source](https://github.com/malecki/edav/blob/gh-pages/projects/various-data-sources/pizza/pkg/vignettes/pizzasizes.Rmd))
- `build_vignettes()`
- promote (copy) code from vignette to [examples](https://github.com/malecki/mrp/blob/master/mrp/R/mrp.R#L78)
- `example()`
</section>
