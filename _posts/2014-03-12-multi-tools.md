---
layout: pres
title: EDAV
description: exploratory data analysis and visualization
tags: slides
---


<section>
	<section>
## Reporter app to ggplot
[![]()](https://twitter.com/toph/status/443770938451320833)
</section>
	<section>

- [worth of a human challenge](http://www.informationisbeautiful.net/2014/dataviz-challenge-design-a-page-of-my-new-book/)
</section>
	<section>
# A million lines
[![]()](http://www.informationisbeautifulawards.com/2013/10/a-million-lines-of-code/)
</section>
	<section>
# word clouds 1
[![]()](http://www.nakedapartments.com/blog/apartment-descriptions/)
</section>
	<section>
[![]()](http://ny.curbed.com/archives/2014/03/12/how_do_brokers_use_babble_to_describe_homes_in_your_hood.php)
</section>
	<section>
## my dotplots again

[![]({{ site.baseurl }}/assets/EbyNdetailed.png)](https://github.com/malecki/eb-satis-dem/blob/master/posterGraphics.R#L102)

</section>
</section>
	<section>
# Lightning talks/reviews
</section>
	<section>
## Zijian Yi
</section>
	<section>
## Andy Cao
</section>
<section>
	<section>
## not graphs
</section>
	<section>
- <http://inundata.org/R_talks/BARUG/>
- <https://drive.google.com/folderview?id=0ByIrJAE4KMTtaGhRcXkxNHhmY2M&usp=sharing>
- stuff added to the [wiki](https://github.com/malecki/edav/wiki)
</section>
</section>

<section>
	<section>
## some refactoring
[![]()](http://www.phdcomics.com/comics.php?f=1688)
</section>
	<section>
## This is slow

(Also not idiomatic R)

```
oldFunction <- function(inputData){
    out <- as.data.frame(matrix(0, nrow(inputData),
                                length(unique(indicators))))
    names(out) <- paste0("V1",letters)
    for (i in 1:nrow(out)){
        for (j in 1:length(unique(indicators))) {
            colname=paste('V1',inputData[i,j],sep='')
            out[i,colname] <- TRUE
        }
    }
    return(out)
}
```
</section>
	<section>
## Live coding time

Let's use RMarkdown.
</section>
	<section>
## Refactor

```
newFunction <- function(inputData){
    indicatorMatrix1 <- model.matrix(~ 0+ V1, data=inputData)
    indicatorMatrix2  <- model.matrix(~ 0+ V2, data=inputData)
    out <- indicatorMatrix1 | indicatorMatrix2
    return(as.data.frame(out))
}
```
</section>
</section>