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

My first pass at improving the image is here:
![]({{ site.baseurl }}/assets/celene_assets/2014-03-top_players_grand_slams.png)

My goals in the first pass were to:
* make clearer separations between the events<br>
* get rid of the meaningless trend lines<br>
* use a scale that is more meaningful<br>
* incorporate ability to compare head-to-heads<br>
* add a couple years to update it<br><br>

This time, my goal was to re-make my visualization using d3.js, and add mouseovers that contain meaningful details. I'm a fan of mouseovers because it allows exploration without the clutter.<br><br>
I was able to make the gridlines and circle images thanks to the tutorial on alignedleft.com. When it came to plotting the data, at first I thought I would need to make a separate array for each player and tournament. I started with 8 x 7 matrices (years by rounds) of 0s and 1s, where each row would have a single 1.<br><br>

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

Then, I across examples of d3.js visualizations on Mike Bostock's bl.ocks page. Particularly inspiring was his map image of airports in the US: http://bl.ocks.org/mbostock/4408297<br>
From this, I realized that JSON-formatted variables can easily be referenced in d3 - including subvariables of a list. Therefore, I changed my datasets to look like this:

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

and could have a lot more meaningful information incorporated into my data points!<br>

The final code and visualization can be viewed here: http://bl.ocks.org/celenechang/10517119<br><br>





</section>
</section>
