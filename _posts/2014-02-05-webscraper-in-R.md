---
layout: post
title: R webscraper in 2 lines of code
description: Intro to the XML package in R
---

    require(XML) # this calls for the package in R

# assign the URL to a variable
theURL <- "http://www.peakbagger.com/pbgeog/histmetropop.aspx"

# scrape the table from website
uspop <- readHTMLTable(doc=theURL, which=4, header = FALSE, skip.rows= 1, as.data.frame= TRUE, stringsAsFactors=FALSE)

# 'which' indicates the table number you want to scrape from the website
