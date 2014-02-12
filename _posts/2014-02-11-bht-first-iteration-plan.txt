---
layout: post
title: First Iteration Plan
description: Complaint Prediction: Getting Started
---

When New Yorkers call 311 about a housing code violation, they are generally routed to file a complaint with Housing Preservation and Development (HPD), the city agency tasked with maintaining the quality of the city's housing stock. 

These complaints are investigated and basically end up dismissed or turning into violations. People in marketing might call this a 'conversion event.' 

I'm interested in developing a model to predict this conversion event.

In the next three weeks, I will:
+ Refresh/reinforce my understanding of Probit regression by working with dummy data 
+ Come up with a list of variables that I believe would help structure the complaints data (potential predictors)
+ Generate small-sample complaints datasets including my predictor candidates as fields in the complaint record
+ Use matplotlib to explore these predictor candidates:
++ (look at average conversion by binning complaints associated with predictor values in each percentile of the predictor's range)
+ Using broad trends found in my predictors, examine complaints data from different time ranges and (nonrigorously) select a date range

Longer term to-dos:
+ Producing complaint-plus-predictor records for my selected range
+ Ensure predictor values can be calculated in a computationally manageable way (real time applications)
+ Mapping complaints
+ Investigating spatial auto-correlation
