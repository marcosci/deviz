
<!-- README.md is generated from README.Rmd. Please edit that file -->

# devis

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/marcosci/devis/branch/master/graph/badge.svg)](https://codecov.io/gh/marcosci/devis?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/marcosci/devis/workflows/R-CMD-check/badge.svg)](https://github.com/marcosci/devis/actions)
<!-- badges: end -->

The goal of devis is to …

## Installation

### Prerequisities

### Linux

``` bash
sudo apt-get install xdotool #ubuntu
sudo dnf install xdotool     #fedora
sudo pacman -S xdotool       #arch
```

### MacOS

``` bash
brew install xdotool
defaults write org.x.X11 enable_test_extensions -boolean true  
defaults write org.macosforge.xquartz.X11 enable_test_extensions -bool yes   
```

### Package

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("marcosci/devis")
```

## Example

### Mouse movement tracking

If you use RStudio, the most convienent way to track your mouse movement
with `devis` is to use the jobs pane. Just create somewhere a file
like the following:

``` r
library(devis)

track_mouse("00h00m90s")

visualize_mouse(momove, "tinygrid")
```

… and specify everything in there that is of interest to you. The time,
maybe you don’t want to save the coordinates in a tempfile or you don’t
want to immediately plot the data.

Then run the job with the following settings:

<center>
<img src="https://raw.githubusercontent.com/marcosci/devis/main/vignettes/job.png?token=ACS4PPQQKRGDB6EMRG3UDRC73ZGKK" style="width:60%" />
</center>

### Visualize mouse movement

``` r
visualize_mouse(mouse_df, type = "dot")
```

## Code of Conduct

Please note that the devis project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
