---
layout: pres
title: binding data to the dom
description: binding data to the dom
tags: slides
---

<section>
	<section>
# graphs
</section>
	<section>
[![](http://cdn.theatlanticcities.com/img/upload/2014/02/27/vmt3.png)](http://www.theatlanticcities.com/commute/2014/02/were-driving-less-so-should-we-stop-building-new-roads/8507/)
</section>
	<section>
# us and them
[![](https://scontent-b.xx.fbcdn.net/hphotos-frc3/t31.0-8/s720x720/1836717_10152265008628415_417442065_o.png)](https://www.facebook.com/notes/facebook-data-science/talking-about-us-and-them/10152107038848859)
</section>
	<section>
# pies!
[![](http://junkcharts.typepad.com/.a/6a00d8341e992c53ef01a51184b688970c-300wi)](http://junkcharts.typepad.com/junk_charts/2014/03/pi-day-special-onelesspie-initiative-to-clean-up-wikipedia.html)
</section>
</section>
<section>
## Quick standup --

Is your project about half done?

What have you accomplished in sprints so far that you want to share?

Anything blocking you?
</section>
<section>
	<section>
## Input data

- arrays
- functions of arrays
- requests that resolve to arrays
- (convenience requests)
- `d`
</section>
	<section>
## Selections / selectors

- attributes: id, class, etc.
- selected element
- selected object
- jquery-like (reach into DOM and do something)
</section>
	<section>
## Operations

- append
- attr
- data
- text, html
</section>
	<section>

## Subselections

- ["General update pattern"](http://bl.ocks.org/mbostock/3808218)
- enter
- update
- exit
</section>
	<section>
## scales

- quantitative
- ordinal
- time
</section>
	<section>

### Where to put it?

- CORS is annoying
- serve locally
- Plunkr is nice
- jsfiddle if small enough
</section>
	<section>
## Best practices

- ["Toward Reusable Charts"](http://bost.ocks.org/mike/chart/)
</section>
	<section>

### Wrapping with angular

- separate concerns
- limit how much dom you're touching
- leave data fetching to another service
- ['replacing'](http://alexandros.resin.io/angular-d3-svg/)
- ['radian'](http://openbrainsrc.github.io/Radian/index.html)
</section>
	<section>
## Live-code together?

- [Dotplot directive](http://plnkr.co/edit/NlvdXdlX4IR14jSbAHPM?p=info)
</section>

</section>

