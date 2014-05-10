---
title: Stage C - Josh (jsp2014)
description: Project Stage C
tags: project, josh plotkin, jsp2014
---

## Contents for Stage C - Analysis of Winrate and Standard Deviation of winnings

* __Folder 'Python'__: this folder contains two scripts and the iPython notebook. The scripts are as follows:
	* the suffix of the file tells in which order to run them (and the order I'll describe below)
	* pulls in the Stage A data, separates out the regulars, and cleans up the data so it's in a form we can use for Stage C.
	* shuffles the data to randomize, and split the hands into 10 files to prepare for bucketing (goes much quicker in pieces)
	* pulls in the 10 files and assigns a bucket number
	* merges the 10 files together
	* performs a Bayesian analysis on winrate and standard deviation.
*  Here is a dropbox link to Stage c's csv files, which will not fit on github: __[download me](https://www.dropbox.com/sh/rywkbemje177yia/JFZcJ_N4bU)__
* __[iPython notebook viewer]http://nbviewer.ipython.org/github/joshplotkin/edav/blob/gh-pages/projects/jsp2014/StageC/PYTHON/StageC.ipynb)__