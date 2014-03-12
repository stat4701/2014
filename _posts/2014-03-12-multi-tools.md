---
layout: pres
title: some things to refactor
description: some refactoring
tags: slides
---

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
## Reporter app to ggplot
[![](https://pbs.twimg.com/media/BiiXUS8IUAAnPNF.jpg)](https://twitter.com/toph/status/443770938451320833)
</section>
	<section>

- [worth of a human challenge](http://www.informationisbeautiful.net/2014/dataviz-challenge-design-a-page-of-my-new-book/)
</section>
	<section>
# A million lines

[![](http://s.informationisbeautifulawards.com/blog-content/uploads/2013/10/Screen-shot-2013-10-30-at-15.25.47.png)](http://www.informationisbeautifulawards.com/2013/10/a-million-lines-of-code/)
</section>
	<section>
# word clouds 1

[![](http://blog.nakedapartments.com.s3.amazonaws.com/blog/wp-content/uploads/2011/03/cloud-thumb.gif)](http://www.nakedapartments.com/blog/apartment-descriptions/)
</section>
	<section>
# word clouds 2
[![](http://cdn.cstatic.net/images/gridfs/53208a28f92ea10510005260/wrdastoria.png)](http://ny.curbed.com/archives/2014/03/12/how_do_brokers_use_babble_to_describe_homes_in_your_hood.php)
</section>
	<section>
## my dotplots again

[![]({{ site.baseurl }}/assets/EbyNdetailed.png)](https://github.com/malecki/eb-satis-dem/blob/master/posterGraphics.R#L102)

</section>
</section>
<section>
	<section>
# Lightning talks/reviews
</section>
	<section>
## Zijian Yi
</section>
	<section>
## Andy Cao
</section>
</section>
<section>
	<section>
## some refactoring

[![](http://www.phdcomics.com/comics/archive/phd031014s.gif)](http://www.phdcomics.com/comics.php?f=1688)
</section>
	<section>
# What's this do?

```
  year <- as.vector(apply(t[1, ], 2, paste, collapse=''))
  year <- year[1]
  
  # remove rows 1 and 2 as they have header info
  t <- t[-(1:2), ]
  # add "year" column to keep track of the census year
  t[, "Year"] <- year
```

\([picking on @enkeboll](https://github.com/enkeboll/edav/blob/9d93d331bc022b146f1dfa6d018a3fbb5f41b80e/projects/popgraph_ae/get-data.R#L18)\)
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
</section>
