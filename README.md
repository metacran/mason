
# mason

> Friendly Craftsman Who Builds Slick R Packages

[![Linux Build Status](https://travis-ci.org/metacran/mason.svg?branch=master)](https://travis-ci.org/gaborcsardi/mason)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/gaborcsardi/mason?svg=true)](https://ci.appveyor.com/project/gaborcsardi/mason)
[![](http://www.r-pkg.org/badges/version/mason)](http://www.r-pkg.org/pkg/mason)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/mason)](http://www.r-pkg.org/pkg/mason)

![](/inst/mason.png)

Mason builds R packages. It asks you some simple questions, fills in a
template based on your answers, and creates proper metadata files, READMEs
with badges, git repositories, everything you need to just start writing
and committing your code.

Mason is extensible: each template is a separate R package named
`mason.<template>`, where `<template>` is the name of the template. To use
a new template, you need to install it first. Mason will be then able to
use it immediately, without any configuration.  See
e.g. [mason.rpkg](https://github.com/gaborcsardi/mason.rpkg) for a generic
R package template. 

Mason makes sure that you get your package as quick as possible, with the
least number of keystrokes: it tries to find out your username, name email
address, GitHub login name, etc. from your settings, to give you reasonable
defaults, so that all you need to do is press `ENTER` a couple of times.

Mason's role model is [Yeoman](http://yeoman.io).

## Installation

You can install Mason and its dependencies from GitHub, using the
`devtools` package:

```r
devtools::install_github("metacran/mason")
```

You need to install at least one template as well:

```r
devtools::install_github("metacran/mason.rpkg")
devtools::install_github("metacran/mason.github")
```

## Usage

Create an empty directory and make that your current directory.
The new package will be created within that:

```r
dir.create("mypackage")
setwd("mypackage")
```

Then just call Mason with the name of the template:

```r
mason::mason("github")
```

![](/inst/mason-1.png)

![](/inst/mason-2.png)

![](/inst/mason-3.png)

![](/inst/mason-4.png)

## License

MIT © [Gábor Csárdi](https://github.com/gaborcsardi).
