---
layout: post
title: Project Outline
tags: project
---
## Physician Affinity Graph

Team — Mayank Misra, Mandeep Singh

Goal — Graph social and professional affiliation for prescribers (doctors). 
Project Name: Physician Affinity Graph
We are looking at using publicly available data sets to form a network graph of physicians. 
ML will be used in this context for clustering based on common features/dimensions between physicians.  
The aim is to to establish influencers/opinion leaders and physicians that have the most klout in a particular cluster. 
 
1.	Create a list of different datasources to procure publicly available healthcare claims data, pharmaceutical relationship (sunshine act) data, and hospital/practice/association affiliation data sets.  
2.	Analyze the format in which data is available from these sources and scrape the data in a repository. Eg CSV, JSON, API, Website etc
3.	Create a database model  using these data sources to analyze the physician relationships with hospitals, medical colleges, medical associations, pharmaceuticals, journals and other professional networks
4.	Munge and analyze the raw data collected above and create a network graph  
5.  We will be using a combination of Python, R, D3, Neo4j and Github for coding 

## Long Term

1.	Develop a influence score based ranking of physicians
2.	Develop a 'Key Opinion Leader' KOL recommendation engine for payers, pharmaceutical companies, patients, research and academia
