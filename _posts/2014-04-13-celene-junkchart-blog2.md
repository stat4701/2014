---
layout: post
title: Celene - Junk chart take 2
description:
tags: blog
---
<section>
	<section>
### Tennis Grand Slams junk chart - d3 challenge
The original image that inspired my junk charts exploration is here:
![]({{ site.baseurl }}/assets/celene_assets/2014-03-ndevisual_tennis.png)<br>
Source: http://ndevisual.wordpress.com/2011/09/22/tennis-trend-and-tableau/<br><br>

My goals in the first pass of improving this chart were to:<br>
* make clearer separations between the events<br>
* get rid of the meaningless trend lines<br>
* use a scale that is more meaningful<br>
* incorporate ability to compare head-to-heads<br>
* add a couple years to update it<br><br>

My first pass at improving the image is here:
![]({{ site.baseurl }}/assets/celene_assets/2014-03-top_players_grand_slams.png)<br><br>


This time around, my goal was to re-make my visualization using d3.js, and add mouseovers that contain meaningful details. I'm a fan of mouseovers because it allows exploration without adding clutter.<br><br>

I was able to make the gridlines and circle images thanks to the tutorial on [alignedleft](http://alignedleft.com/tutorials/d3). When it came to plotting the data, at first I thought I would need to make a separate array for each player and tournament. I started with 8 x 7 matrices (years by rounds) of 0s and 1s, where each row would have a single 1.<br><br>

```javascript

	var djok_aus = [ 1, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 1, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 1,
                    0, 0, 0, 0, 1, 0, 0,
                    0, 0, 0, 0, 1, 0, 0,
                    0, 0, 0, 0, 0, 0, 1,
                    0, 0, 0, 0, 0, 0, 1,
                    0, 0, 0, 0, 0, 0, 1
                     ];

    var nad_aus = [ 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 1, 0, 0,
                    0, 0, 0, 0, 0, 1, 0,
                    0, 0, 0, 0, 0, 0, 1,
                    0, 0, 0, 0, 1, 0, 0,
                    0, 0, 0, 0, 1, 0, 0,
                    0, 0, 0, 0, 0, 0, 1,
                    0, 0, 0, 0, 0, 0, 0
                     ];
```

Then, I across examples of d3.js visualizations on Mike Bostock's bl.ocks page. Particularly inspiring was his map image of airports in the US: [http://bl.ocks.org/mbostock/4408297](http://bl.ocks.org/mbostock/4408297)<br>
From this, I realized that JSON-formatted variables can easily be referenced in d3 - including subvariables of a JSON list. Therefore, I changed my datasets to look like this:<br>

```javascript

var aus_open = [
            {
                "name": "N. Djokovic",
                "year": "2006",
                "round": "1",
                "result": "def. by P. Goldstein, 6-2 1-6 6-3 6-2",
                "color": "rgba(256, 51, 51, 0.5)",
                "colorFill": "rgba(256, 51, 51, 1)"
        },
        {
                "name": "N. Djokovic",
                "year": "2007",
                "round": "4",
                "result": "def. by R. Federer, 6-2 7-5 6-3",
                "color": "rgba(256, 51, 51, 0.5)",
                "colorFill": "rgba(256, 51, 51, 1)"
        },

        [...]
     ]
```

These datasets allow a LOT more meaningful information to be incorporated into my data points! Clearly, this latter structure is a large improvement. I started to really appreciate d3's data-binding feature upon discovering this.<br>

The final code and visualization can be viewed here: [Grand Slam visualization](http://bl.ocks.org/celenechang/10517119). Here's a screenshot:<br>

![]({{ site.baseurl }}/assets/celene_assets/2014-04-tennisd3-screenshot.png)<br>


In general I'm pleased with how it turned out. The trends are interesting; here are a few:<br>

* Federer's decline in the US Open - after winning in 2008, he's exited 1 round earlier than the previous year almost consistently<br>
* Nadal's near-total dominance of the French Open is underscored<br>
* the two hard court Grand Slams seem to have less variance in results compared to the others<br><br>

The addition of the scorelines as well as opponent names (in the mouseover) make the visualization richer.<br><br>

Most importantly, I think I was able to develop a good understanding of how d3.js works. I'm excited to take further advantage of its features for my project visualizations.<br><br>

A blocker I encountered was how to handle overlapping data points. The colors of the datapoints are transparent, so one can pretty easily tell if there is an overlap. However, the mouseover data only displays for one of the points - that is, the most recently written one. I worked around this for the final round by adding a 'C' (for Champion) column, which I think works well enough. Otherwise I haven't spent the time to think of a good way around this, and if anyone has tips they would be greatly appreciated!<br><br>







</section>
</section>
