---
layout: pres
title: Refining code and data processes
description: Refining code and data processes
tags: slides
---

<section>
	<section>
## Standup

Discuss: 

1. Project status
  - What have I done?
  - Is anything blocking me now?
  - I would like to do *x* but don't know how
  - *y* might be an alternative to *x*

</section>
	<section>

## Links!
  - Inundation: narrow immediate scope (ﬁgure out something doable)
  - example: [set](http://votesmart.org/share/api#thirdparty) [up](https://github.com/kpascual/nbascrape) [some](http://eglenn.scripts.mit.edu/citystate/wp-content/uploads/2013/02/wpid-working_with_acs_R2.pdf) [extant](https://blogs.worldbank.org/opendata/accessing-world-bank-data-apis-python-r-ruby-stata) [libs](https://github.com/Rapleaf/Personalization-Dev-Kits) or find [connectors](https://github.com/zatonovo/odessa)
  - Don't know where to start: first thing to make a preliminary result
  - example: get and save example xml/json and work against that (possibly test-driven)
  - Connect-last; simulate/sample

</section>
	<section>

## Agenda notes

1. R package work and testing on Monday
2. More api connecting and integrating on Wednesday
3. Readings stay the same
4. Added some things for ‘after’ today

(commit diff)

</section>
</section>

<section>
	<section>
## graph of the day
</section>
	<section>
## Now
[![](http://imgs.xkcd.com/comics/now.png)](http://xkcd.com/1335/) (note the redirect!)
</section>
	<section>
## Uber

[![]({{ site.baseurl }}/assets/uberchord.png)](http://bost.ocks.org/mike/uberdata/)
</section>
	<section>
## basketball

[![](https://pbs.twimg.com/media/BeXFnrlCUAAdL--.png)](https://twitter.com/EdKupfer/status/424963025355821056/photo/1)
</section>
	<section>
## Rank and filed
[![](http://cf.computationallegalstudies.com.s3.amazonaws.com/wp-content/uploads/2014/02/Screen-Shot-2014-02-22-at-11.04.51-PM.jpg)](http://rankandfiled.com/)

[Discussion](http://e-pluribusunum.com/2014/02/19/rankandfiled-com-is-like-the-secs-edgar-database-but-for-humans/)
</section>
</section>

<section>
	<section>
## Work with static json/xml

[Can we make this test pass?](https://github.com/malecki/edav/blob/gh-pages/dataExercises/pkg/inst/tests/test-json.R)