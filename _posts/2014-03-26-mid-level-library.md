---
layout: pres
title: D3, A mid-level library
description: binding data to the dom
tags: slides
---

<section>
## Ceci n'est pas...

"D3 is not a graphing/charting library"
It is not low-level
It is not bound to svg or html, but is bound to the DOM

</section>
<section>
## It is mid-level.

### api

- [graphics.h](https://github.com/SurajGupta/r-source/blob/master/src/include/Graphics.h)

### implementation

- [graphics.c](https://github.com/SurajGupta/r-source/blob/master/src/library/graphics/src/graphics.c)
- [grid.c](https://github.com/SurajGupta/r-source/blob/master/src/library/grid/src/grid.c)
### devicelevel

- [devQuartz.c](https://github.com/SurajGupta/r-source/blob/master/src/library/grDevices/src/devQuartz.c)

</section>
<section>
	<section>

## What do high-level libraries look like?

- `plot(x,y)`
- `barplot(x, names.arg)`
- `xyplot(y~x, data, ...)`
- `qplot(x, y, data, ...)`
- `ggplot(data, aes)`
- `xlsxWriter.Workbook.(...).add_chart('scatter').add_series ...`
- `barplot(table)`
- `spplot(mrp)`
- `coefplot(lm)`
</section>
	<section>

##What does each of these do?

- `plot(x,y)`
- `barplot(x, names.arg)`
- `xyplot(y~x, data, ...)`
- `qplot(x, y, data, ...)`
- `ggplot(data, aes)`
- `xlsxWriter.Workbook.(...).add_chart('scatter').add_series ...`
- `barplot(table)`
- `spplot(mrp)`
- `coefplot(lm)`

</section>
	<section>
### `plot(x,y)` or `qplot(x,y)`

- two equal length arrays.
- equivalently, an array of objects {x: number, y: number}
- internally xy.coords is doing this
- deeper internally, graphics.c is translating to device units

</section>
	<section>
## Data contracts

- simple arrays/vectors/lists
- data.frames (lists)
- multidimensional arrays `a[i][j]`
- arrays of objects == R list

</section>
</section>
<section>
	<section>
## mid-level ceremony

With D3 you have to do a lot of ceremony that higher-level tools do for you

- size
- data range
- data scale to output scale
- create objects
- object properties (in output api terms)

</section>
	<section>
## some pseudocode ceremony

```
width = w in device units
height = h in device units
aes[x] = function(x) device.scale(x (data units) -> x(device units))
aes[y] = function(y) scale(y)
device.drawPoints(x,y) = function(x,y) points(aes[x](x), aes[y](y), ...)
device.drawAxis(aes[x])
device.drawAxis(aes[y])
```
</section>
	<section>

## other attributes:

- color
- size
- events

</section>
	<section>

## What does it buy you?

- selections
- data binding
- array methods
- some math
- interpolations
- 'layouts' == functions with specific api

</section>
	<section>
## What's weird? 

- selections
- js arrays
- method chaining
- callbacks
- xhr
</section>
	<section>
### Selections

- Subclass of js array
- Like jquery $(),
- Less awkward than `document.getElementById` (but that still works)
</section>
	<section>
## Binding

- puts something in `__data__` attribute (`datum()`)
- returns `enter`, `update`, `exit` selections
- based on the data array and the existing selection
- existing selection is empty? all data enter.
- matching data (by key which defaults to index) go to update
- more data? new things go to enter.
- less data? exiting elements go to exit.

</section>
</section>
<section>
	<section>
## Back to higher-level

- `ggplot(data, aes(x=x, y=y))`
- `xyplot(y~x, data)`
</section>
	<section>
### Data contract

- effectively an array of objects as before, with keys in aes or in formula
- d3: callback function within the array. just `d` is the element itself.
- functor `function(d) return d.x`
</section>
	<section>
## Interior data contracts

- Consider <http://bl.ocks.org/mbostock/4063663>

```
// input data csv evaluates to 
[{'trait0': value, 'trait1': value, ...}]
// 16 of these:
p.datum = { x: 0, y: 0, a: 'sepal length', b: 'sepal length' }

// 4 of these domainByTrait:
{'namedtrait': [min, max]}

// accessed by name
// original data accessed by index
x(d[p.x]), y(d[p.x])
d[p.a] // should also work
```
</section>
	<section>
## Next

- Requests mostly hide `xmlHttpRequest`
- Services that return promises
- Transitions
- Interactions (listeners)
- Brush
</section>
</section>
