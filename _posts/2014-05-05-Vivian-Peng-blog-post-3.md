---
layout: post
title: Blog Post 3 - Vivian
description: blog post 3 
tags: blogpost
---

### Drawing 14,6000 Pills

## Background

The inspiration behind this blog post comes from one of my work assignments at Doctors Without Borders. With the currently available pills in the market, it takes up to 14,600 pills to treat one patient with drug-resistant Tuberculosis (DR-TB). I was working on an advocacy campaign to push Big Pharma and scientific innovation to create better treatment for DR-TB. If you line up the pills, end-to-end, 14,600 pills is equivalent to the height of the San Francisco Golden Gate Bridge. We wanted to showcase how insane that number is.

I designed this infographic that was meant to take along time to scroll down for the information you need.

[Click Here](http://vivianpeng.com/14600_infographic_scroll.pdf)

You can imagine how painstakingly long it took for me to draw out 14,600 pills in AdobeIllustrator. The final file size is huge, it's hard to render a high quality version on the web, and it's not as interactive as I wanted it to be. There has to be a better way!

## My plan for a better design

I was inspired by Josh Worth's ["If the moon were only 1 pixel"](http://joshworth.com/dev/pixelspace/pixelspace_solarsystem.html) scrolling data visualization. I liked that the user had to continually scroll to the right to get more information, and the tracker at the bottom calculates the number of pixels scrolled and converts it into km distance from the sun.

I want to replicate a similar effect, where you can scroll to the right for information and the counter increases from 0 to 14,600. Instead of showing you the planets in Josh Worth's visualization, I would like to present the amount of water you would have consumed to intake that many pills.

## What I have so far

Though Josh Worth's code looked relatively simple to replicate, I could not get his counter to work. I'm not familiar with jQuery, and spent a day trying to crash learn it. Instead, I looked for an alternative in D3.

I liked Mike Bostock's text animation from his [Wealth & Health of Nations](http://bost.ocks.org/mike/nations/) visualization. You can also use the mouse to scroll to different data points, so I copied parts of his code to get the text to tween from 0 to 14,600. I still haven't figured out how to use the mouseover to interpolate between different numbers, since I don't really have a dataset tied to the visualization.

For now, I drew circles to represent the pills. The chunk of code I used should render 14,600 pills, but I can't get that section to scroll in order to show all the 'pills'. 

As you can see, I still have a lot of work to go. Even though the overall time I put into creating this hacked-together-version of a visualization was longer than actually drawing the pills in Illustrator, the code used to populate circles via a for loop is very helpful. I'm sure it will come in handy the next time I have to illustrate some insane number of items.


## Update 5-14-14 [Click Here](http://vivianpeng.com/pills.html)

My final product uses D3 to interpolate the number of pills taken, from 0 to 146000. As you scroll to the right, 14,600 'pills'. I created a sample dataset that randomly generates numbers from 0 to 14,6000 and for each of those datapoints I draw a circle. This is the code used to generate the data and draw the circles:

```{r chunkLabel}
var dataset = [],
    i = 0;

    for(i=0; i<14600; i++){
        dataset.push(Math.round(Math.random()));
    }        

var sampleSVG = d3.select("#viz")
      .append("svg")
      .attr("width", 116800)
      .attr("height", 200);

    sampleSVG.selectAll("circle")
        .data(dataset)
        .enter().append("circle")
        .style("fill", "black")
        .attr("r", 2)
        .attr("cx", function(d,i){return  5+ (i*10)})
        .attr("cy", 20);

```{r chunkLabel}

The images were drawin in AdobeIllustrator, and the positioning of the text were just hardcoded by calculating the number of pills at that point, and the distance between each pill. It's not the most elegant code, but it gets what I want. Ideally I would have liked the counter to stay at the middle of the screen, and the user can interact with it by scrolling left or right. I couldn't figure out how to do so, since I don't have an index for the pills and couldn't bind the animation to a position.

Overall, I'm happy with how this looks. I wanted it to be intentionally annoying to scroll all the way to the right to get the infromation at the end. I think I can improve on this by adding more dynamic interaction, and using a custom svg for the pills instead of using circles.