## Some R data manipulation excercises

This is meant as an example both for how to enacapsulate
the work you do with data, by writing functions and documenting
them, and of using test-driven development for work in R 
with [testthat](https://github.com/hadley/testthat).

The initial example demonstrates some frustrations that are
maddeningly common working with survey and demographic data and 
which show the the weakness of the "csv api" 
(the same goes for the json api).

## How to use

*Given* you have installed *testthat* , preferably using
devtools and `install_github('testthat')`, *and* that you have installed make, you should
be able to 

```{bash}
make test
```

But that's not too useful as a development environment. Testthat
provides a watcher, so that tests rerun when you save source.

```{bash}
make watch
```

If you haven't installed make, this is just 3 commands instead of 1. 

### One successful workflow

I had some success with RStudio and Terminal open simultaneously, doing the following stuff. (I did this on a mac, but I don't think I did anything mac-specific) 

In RStudio,
``` {R}
install.packages("devtools")
library(devtools)
install_github('testthat')
library(testthat)
library("dataExercises", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
```

I believe I got the install working just using the RStudio GUI 
![Imgur](http://i.imgur.com/20rpRAe.png)

Now we turn to Terminal/Command Prompt/your shell of choice. You can go to the directory, ![go to the directory](http://i.imgur.com/wEagYoZ.png),

display the contents of the makefile,
![display the contents of the makefile](http://i.imgur.com/pWuNf5A.png)

ignore the erroneous first command (which references an unset cache variable?), and run the watch (or auto_test) command
![watch or auto_test command](http://i.imgur.com/kB7eOw4.png)

You'll see something like this 
![something like this](http://i.imgur.com/nJmdKzq.png)

Suppose you then make Admit and Gender into factors and set their levels - as soon as you save the function, you should see something like this
![see something like this](http://i.imgur.com/tGFEjeq.png)

How you can get it past the string mismatch issue is beyond the understanding of the present author.  -bht

Have fun!

## Forked repos

Please work on a **branch** of your fork and **try not to submit solutions** in requests to the `gh-pages` branch here (upstream). Of course you can push to your 'exercises' branch; that will be really useful for sharing your solutions. I might open a `solutions` branch or something, we'll see.

```{bash}
git fetch upstream
git checkout gh-pages
git rebase upstream/gh-pages
git checkout -b exercises
```

… and get hacking!

### TODO
- A companion Python one using nosetests (anyone want to set up?)
- other manipulation tasks:
   - factor to indicator matrix
   - indicator matrix to factor
   - interaction indicator matrix (array filling)
   - binary selections to item-response matrix
   - array ops and permutations
   - text frequencies to LDA format
   - stemming/preparing text input
- other output formats
   - geoJSON
   - plain useful json from a data.frame (not obvious)
   - estimates with uncertainty to 'plottable data frame'
