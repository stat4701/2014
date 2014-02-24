---
layout: pres
title: Color
description: Color.
tags: slides
---
<section>
	<section>
## graph of the day
</section>
</section>

<section>
## 2½ stories about data munging

1. `Stack`
2. some excel munging
3. [data prep for `tm`](http://rforwork.info/2014/02/17/a-delicious-analysis/)

</section>
<section>
	<section>
## Story 1

The story of `Stack`

  - combining surveys by fielding unit (wave, region)
  - sometimes ragged columns
  - sometimes ragged rows
  - `rbind` is too limited
  - [`rbind.fill`](https://github.com/hadley/plyr/blob/master/R/rbind-fill.r) is a (fast) blunt tool
  - some special cases, mostly factor-int
  - dates are usually annoying
</section>
	<section>

## the basic problem

`rbind` is too strict.

```
df1 <- data.frame(a=1, b=2)
df2 <- data.frame(a=1, b=2, c=3)
str(df3 <- rbind(df1,df2))
df2 <- data.frame(a=1, b="b")
str(df4 <- rbind(df1,df2))
df2 <- data.frame(a=1, b=factor("b"))
str(df5 <- rbind(df1,df2))
```

</section>
	<section>
### How about...

`rbind.fill` from plyr?

```
library(plyr)
df1 <- data.frame(a=1, b=2)
df2 <- data.frame(a=1, b=2, c=3)
str(df6 <- rbind.fill(df1,df2))
df2 <- data.frame(a=1, b="b")
str(df7 <- rbind.fill(df1,df2))
df1 <- data.frame(a=1, b=factor("a", levels="a", labels="a"))
df2 <- data.frame(a=1, b=2)
str(df8 <- rbind.fill(df1,df2))
df1 <- data.frame(a=1, b=factor("a", levels=c("a","b"), labels=c("a","b")))
df2 <- data.frame(a=1, b="b")
str(df9 <- rbind.fill(df1,df2))
df1 <- data.frame(a=1, b=factor("a", levels=c("a","b"), labels=c("a","b")))
df2 <- data.frame(a=1, b=2)
str(df10 <- rbind.fill(df1,df2))
```

</section>
	<section>
## Rbind.fill code

- [Let's look at the code.](https://github.com/hadley/plyr/blob/master/R/rbind-fill-matrix.r)
- and the [tests](https://github.com/hadley/plyr/blob/master/inst/tests/test-rbind.r).

</section>
	<section>
## cases motivating stack

1. Unequal number of columns
2. Order of values in factor levels must be preserved and expenaded
3. factor + integer is a factor with levels given by factor
4. integer+ factor is a factor with levels given by factor
5. factor + character has factor's levels, with extra character values appended
6. Dates are handled correctly (for a def of correct)

</section>
	<section>
### Oh, and for giant datasets,

1. use `ff` (`ffdf`)
2. allow stacking of `ffdf` with `data.frame`
3. allow stacking of `ffdf` with `ffdf`
3. preserve size ('vmode') of storage in ffdf
4. expand storage mode if needed (if new values will not fit in current vmode)
5. some details around `NA` handling (ff can have a 0 level of a factor; R does not)

</section>
	<section>
## Stack code

- [Let's look at the code.](https://github.com/malecki/edav/blob/gh-pages/dataExercises/Stack/R/)
- and the [tests]([Let's look at the code.](https://github.com/malecki/edav/blob/gh-pages/dataExercises/Stack/inst/tests/)


</section>
</section>

<section>
	<section>
## Story 2

### Doctors doing the work of computers

- Some stuff on paper
- Some stuff in Excel
- Excel sorted by topic
- Person-records may appear on multiple topics (sheets)

</section>
	<section>
### Pathological workflow

- Start with sheet?
  - Look for sheet1row1 on sheet2,...,K
  - Scan all sheets for all person-records
- Start with paper? 
  - Hints for topics
  - Memory game (I saw person on sheet k)
- Things computers are good at
  - unique elements in a set
  - matching ids
- Possible extensions
  - People with most/least cross-references
  - Topics with most/least overlapping people

</section>
	<section>

### Lessons in story 2

- Data are ugly
- Excel data is just about the ugliest!
- The free format of *spreadsheets* is maddening if you think about data structures
- I thought Python would be fastest, even though I had to implement two pieces of R as Python functions.
- **Simplest thing that could possibly work** is a collection of records and an iterator. Avoid any kind of rdbms, modeling the data is a waste of time.
- Aside: *Perl* itself is a backronym. Its name is Perl. Not "Practical Extraction and Reporting Language" or "Pathologically Eclectic Rubbish Lister"

</section>
	<section>
### My solution

[`chartmunge.py`](https://github.com/malecki/edav/tree/gh-pages/dataExercises/misc/chartmunge.py)

... so let's review my code. 

[![](http://www.osnews.com/images/comics/wtfm.jpg)](http://www.osnews.com/story/19266/WTFs_m)

</section>
</section>

<section>
	<section>
## Story #2½

### The python part of the recipes topic model

- Seriously?! Separate files and languages‽‽
- csv/tsv api
- relational tables stored as text 
- (projects/flavornetwork)

</section>
	<section>
### some thoughts

- `readLines` makes sense here to gsub
- Look at the `LDA` data contract (what we expect in)
- Entirely possible even with read.tsv / apply
- Experiment with `read.csv.ffdf`, except
- None of these are at all too big
- Why not just `head` the first 10k lines if you're worried?

</section>
</section>
