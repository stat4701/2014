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
devtools and `install_github('testthat')`, you should
be able to 

```{bash}
make test
```

But that's not too useful as a development environment. Testthat
provides a watcher, so that tests rerun when you save source.

```{bash}
make watch
```

Have fun!

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
