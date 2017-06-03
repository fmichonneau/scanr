<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/fmichonneau/scanr.svg?branch=master)](https://travis-ci.org/fmichonneau/scanr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/fmichonneau/scanr?branch=master&svg=true)](https://ci.appveyor.com/project/fmichonneau/scanr)

*This a quickly put together package, if you have feedback or ideas to contribute, feel free to open an issue*

scanr
=====

**`scanr`** allows you to scan the directory that holds your R code and tells you in which file you can find the function(s) you are looking for. For instance, running **`scanr`** inside the source code of this package:

``` r
scanr()
#> scanr.R:
#>     mark_matches 
#>     print.scanr 
#>     scanr
scanr(pattern = "scan")
#> scanr.R:
#>     print.scanr 
#>     scanr
```

Installation
------------

This package is not (yet?) on CRAN, if you want to try it out copy and paste in your terminal:

``` r
source("https://install-github.me/fmichonneau/scanr")
```

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
