---
layout: pres
title: Code+Project Reviews
description: What should you put in to and get out of a review?
tags: slides
---

<section>
	<section>
# Graphs
</section>
	<section>
## Upshot: Senate

[![]({{ site.baseurl }}/assets/spinners.png)](http://www.nytimes.com/newsgraphics/2014/senate-model/)
</section>
	<section>
## upshot: middle-class incomes

[![]({{ site.baseurl }}/assets/incomes-deciles.png)](http://www.nytimes.com/2014/04/23/upshot/the-american-middle-class-is-no-longer-the-worlds-richest.html)
</section>
</section>

<section>
	<section>
# reviews

- [sign up](http://www.slottr.com/sheets/5728)
- Overview/orientation (&lt;5 min)
- Demo the project (&lt;5 min)
- Explain in depth your implementation of two or three specific features (1-2 min each)
- Show some in-progress, probably fragile, parts of the code (5 min)
</section>
	<section>
## Written part

- Can be wiki / md / blogpost
- A paragraph or annotated list for each of the items above
- Link to some code
</section>
  	<section>
## Leading the review

- Show the completed parts first (you deserve credit for your hard work)
- Show the implementation (it might help someone else struggling with something similar)
- Decide what to complete (you can’t do *all the things*)
- Break down tasks to complete
- Work in changes/bugs from review
</section>
	<section>
## Participating

![wtf/m](http://www.osnews.com/images/comics/wtfm.jpg)
</section>
	<section>
## but seriously,

- Follow along
- Ask questions:
  - “What does this block do?”
  - “Why didn’t you use `foo()`?”
  - “Could that be clearer / more idiomatic?”
  - “Is that value worth parameterizing?”
  - “Could this procedure be a separate function?”

</section>
	<section>

## Participating

- Respond to questions:
  - “I’ll add a comment here”
  - “I didn’t know about that function!”
  - “This is probably python with a C accent. Generator or list comp?”
  - “It seems like this works, but I can see how it would break if…”
  - “Yeah, I do this several times, so it should probably be pulled out”

</section>
</section>

<section>
	<section>
## mrp example

1. [conformable arrays](https://github.com/malecki/mrp/blob/master/mrp/R/mrp.R#L216)
1. [poststratified choropleths](https://github.com/malecki/mrp/blob/master/mrp/R/spplot.R#L401)
1. [cross-validation](https://github.com/malecki/mrp/blob/master/mrp/R/xval.R#L52)
1. [simulate for errors](https://github.com/malecki/mrp/blob/99028bea8604b01955fb2c0790852da4aa688481/mrp/inst/simPoststratify.R#L13)
1. [terrible colors](https://github.com/malecki/mrp/blob/master/mrp/R/spplot.R#L262)

</section>
	<section>
## TODO

1. fix the colors
1. unit test the array manipulators
1. wire up the simulation parts
1. hook up to choroplethR/rmaps (small multiples a problem?)
1. more tools for assessing the model? (dotplot methods)

</section>
</section>
<section>
	<section>
## Course review

1. [Agenda](http://malecki.github.io/edav/agenda.html)
1. [wiki](https://github.com/malecki/edav/wiki/)
1. [blog](http://malecki.github.io/edav/archive.html)
1. [dataExercises](https://github.com/malecki/edav/tree/gh-pages/dataExercises)
</section>
	<section>
## Course review example

1. Should be (at least 50%) a lab with specific exercises
1. Discuss readings more? How to integrate week-to-week?
1. More example datasets (really only had one, cityrankings)
1. I’m no good at coming up with dataExercises, but I can code them
1. Did project management work?
1. Blog organization (or lack thereof)
1. Should have problem sets; would structure more classes around solving specific problems instead of trying to invent them
</section>
</section>