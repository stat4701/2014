---
layout: pres
title: Working with Text
description: Working with Text
tags: slides
---
<section>
	<section>
## Graphs of the Day
</section>
	<section>
## Facebook Valentine's Week

### Religion
[![religion](https://scontent-a.xx.fbcdn.net/hphotos-prn1/t1/1911831_10152210870858415_1137687035_n.jpg)](https://www.facebook.com/notes/facebook-data-science/love-and-religion/10152056520123859)
</section>
	<section>
## Age
[![age](https://scontent-a.xx.fbcdn.net/hphotos-ash3/t1/1796655_10152213202838415_1157197979_n.jpg)](https://www.facebook.com/notes/facebook-data-science/the-age-of-love/10152058525083859)
</section>
	<section>
## Duration
[![duration](https://scontent-a.xx.fbcdn.net/hphotos-prn1/t1/1620958_10152215126828415_2080663211_n.png)](https://www.facebook.com/notes/facebook-data-science/flings-or-lifetimes-the-duration-of-facebook-relationships/10152060513428859)
([research paper](http://smr.sagepub.com/content/36/3/402.abstract))
</section>
	<section>
## A graphless paper!
> Regardless of the country, regardless of the topic, and despite what the information theory states, there is no gain in information when an AD scale with more than five categories is used. There is, instead, a loss of quality. That is why if AD scales must be used, we recommend that they contain no more than five response categories.

From [another interesting paper](http://smr.sagepub.com/content/43/1/73.short).

</section>
	<section>
## Quick & Dirty Sentiment
[![](https://scontent-a.xx.fbcdn.net/hphotos-ash3/t1/s720x720/1898250_10152219519288415_127545461_n.png)](https://www.facebook.com/notes/facebook-data-science/the-formation-of-love/10152064609253859)

> For each timeline interaction, we counted the proportion of words expressing positive emotions (like "love", "nice", "happy", etc.) minus the proportion of words expressing negative ones (like "hate", "hurt", "bad", etc.)
</section>
	<section>
## Baby names -- lots of fun data
[Gelman Post](http://andrewgelman.com/2014/02/14/popularity-certain-baby-names-falling-clifffffffffffff/)

[![](http://home.uchicago.edu/~jsfalk/misc/baby_names/images/final_all.png)](http://home.uchicago.edu/~jsfalk/misc/baby_names/)
</section>
	<section>
## R code from post
[![](https://pbs.twimg.com/media/Bgc17i1CEAE0xsf.jpg)](http://andrewgelman.com/2014/02/14/popularity-certain-baby-names-falling-clifffffffffffff/#comment-154271)
</section>
</section>

<section>
	<section>
## Data manipulation exercise

### Slate Olympic medal thing
[![]({{ site.baseurl }}/assets/medalscreenshot.png)](http://www.slate.com/articles/sports/fivering_circus/2014/02/medal_table_time_machine_how_many_medals_the_2014_u_s_olympic_team_would.html)
</section>
	<section>
## data and code

- Inspect element to see script
- What is the shape of the data?
- Any obvious bugs?
- Potential sources of error?
- JSON in R, with `lapply` and `do.call`
</section>
</section>

<section>
	<section>
## Working with text

- Always use unicode
- Explicit ≫ implicit
</section>
	<section>
## Working with text — System

- Does Windows still like CP-1252?
- Set system `locale` 
- `en_US.UTF-8`
- Collation / comparison (is 'ü' == 'ue' in your language?)
- Is your dataset already UTF-8 or Latin-1?
- Use `iconv` or your favorite text editor
- `iconv -l`
</section>
	<section>
## Python 2


- `reload(sys).setdefaultencoding('UTF-8')` in system `sitecustomize.py`
- csv: [unicodecsv](https://github.com/jdunck/python-unicodecsv)
- basically, a lot of `encode` and `decode`
- Note the [encode-after-read vs generator approach](http://docs.python.org/2/library/csv.html)
</section>
	<section>
## Python 3

- strings are 21ˢᵗ-century!
- (they are always unicode)
- [issues with files](http://python-notes.curiousefficiency.org/en/latest/python3/text_file_processing.html)
</section>

	<section>
## R

- defualt is utf-8 in [RStudio](http://www.rstudio.com/ide/docs/advanced/encoding)
- use [stringr](https://github.com/hadley/stringr)
- not-always-obvious behavior of basic string functions
- `grep`, `grepl`, `gsub`, `paste`, `paste0`
</section>
</section>
