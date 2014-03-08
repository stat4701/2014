---
layout: post
title: Celene - Project update
description:
tags: blog
---
<section>
	<section>
### Project update
* Set up package structure<br>
* Wrote python script (DeskCases.py) to pull all cases from Desk API<br>
* Grabbed the cases<br>
-> required pulling 'next' URL field from each page until that field was `None`<br>
* Converted it to pandas DataFrame<br>
* Started playing around with different ways to slice data (see below)<br>
* Discovered that one of the dictionary fields had nested fields, which contained information that I wanted but didn't get picked up as a column in a DataFrame<br>
-> so then had to adjust data collecting script to unnest them
-> this was trickier than expected because sometimes there were 'None' values which I had to figure out a way to handle while still not picking up the extraneous (meaningless) fields
-> resulted in a lot of practice with the notation for lists of dicts
<br><br>

### Preliminary exploratory analyses

<br><br>

### Next steps
1. More exploratory analyses<br>
-> Filter out the non-email type cases<br>
-> Figure out how to work with the dates in a meaningful way (probably need to play with the format of it)<br>
-> Splice by user ID field, so that I can do some comparisons between support case entries and account info (such as length of time as customer, # hosts, amount paying, etc.)
-> Would be neat to get a measure of `importance` for our customers, assuming that the ones that write in the most with requests and bugs are the ones that depend on us most<br>
2. Explore and Learn how to use Bokeh and D3<br>

![]({{ site.baseurl }}/assets/celene_assets/2014-03-serve_speeds.jpg)<br>



</section>
</section>
