---
layout: post
title: Stephen's Blog Post 2
description: Visualizing product co-occurrence
tags: blogpost
---

In my day job, as a member of a Business Intelligence team, I received a request for a report quantifying the co-existence of our products in our customers' environments. The end goal is to prioritize which product interactions my employer, CA Technologies, should work to improve. While we have over one hundred distinctly named products, the request focused on approximately the top 30 products. How often do customers own any given set of two or three of these products simultaneously?

The proposed format for this report was a spreadsheet with a tab for each product. On each tab, there would be a row for each customer owning the product, and a column for each of the other products. For each customer/product combination, a contract amount would be included. Total lines could them be used to summarize the number of customers owning each other product and the total contract values across these products.

Then came the tough question... what if we want to look at co-existence of three products? An already massive and hard-to-read spreadsheet hit its limit and it was time to try a completely new design.

## My Inspiration

The first thing that came to mind when my colleagues began talking about this project was that this should be represented by a graph, where the products are nodes and edges represent the interactions between the products. Having seen Mike Bostock's sample [force-directed graph of Les Miserables character co-occurrence](http://bl.ocks.org/mbostock/4062045), I decided to use this as a starting point. Then, seeing Mike's representation of the same data as a heat map [here](http://bost.ocks.org/mike/miserables/), I started thinking that I could create a compelling visualization by combining these two visualizations into one display.

## Data Munging

To create my proof of concept (and make sure this post doesn't reveal any confidential information), I decided to substitute a number of support issues in place of the contract values requested originally.

My first task was to get my data into a format that is useful to d3's force layout. My favorite language being C#, I fell back to my comfort zone and wrote a C# console application that builds the JSON. My application first executes a query against our reporting database to get a simple list of the number of support issues opened for every product/customer combination for which at least one support ticket was opened. Using this list, my code constructs a JSON file with:

- An array of products with a count of customers and the number of total issues opened by these customers
- An array of 2-product relationships with a count of customers using both products and the total number of issues opened by these customers
- For each product, an array of 2-product relationships (similar to above) for every combination of products owned by customers that own the given product

For the version of my visualization shown in this post, I went one more step by masking the product names with generic identifiers and multiplying the numbers of customers and issues by random factors.

## My Design

My belief is that a user should be able to very quickly and easily browse the relationships between any two products. Instead of compartmentalizing each product to its own view (as in the original spreadsheet design), there should be a view that gives users an understanding of the big picture. Then, users should be able to drill-down into any product of their choice for further details.

I provided the top-level view with a force-directed graph, in which business unit is encoded as colors, number of customers is encoded as node size, and strength of product co-existence is encoded in the width and opacity of the edges connecting the products. The products that occur most often together appear clustered together in the chart, giving a very quick and intuitive high-level impression.

The next level of detail if provided by a heat map. Selecting a node in the force-directed graph drives the heat map. The heat map shows the strength of product co-existence in terms of both the number of customers and the number of issues. Hovering the mouse over the boxes in the heat map reveals the exact numeric values.

This visualization is successful in allowing users to extremely quickly examine the relationship between any combination of two or three products. None of the 10,000+ plus data points included in the visualization are more than one click away.

## The Finished Product

Some static screen shots of my visualization follow below. To see it in action, simply download the html and json files from [here](https://github.com/StephenKappel/dataology/tree/master/Night%20Sky) into the same directory and browse the html file using a locally hosted web server (using "python -m http.server", for example). 

Here's how it looks when no product is selected:
<img src="https://raw.githubusercontent.com/StephenKappel/dataology/master/Night%20Sky/NightSkyNoSelection.PNG" width ="100%">

Here's how it looks when a product is selected:
<img src="https://raw.githubusercontent.com/StephenKappel/dataology/master/Night%20Sky/NightSkyWithSelection.PNG" width ="100%">