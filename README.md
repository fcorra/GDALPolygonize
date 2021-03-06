
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GDALPolygonize

I need an utility to use GDALPolygonize in R. As far as I know the
routine is not implemented in R. At least it does not come with rgdal
package.

I made a simple implementation of the C API GDALPolygonize tool. It
mimics what python gdal\_polygonize.py program does (i.e. it is a wraper
for gdal/alg/polygonize.cpp). It has limitations:

  - It does not keep any of the creations options (I omitted the
    papszOptions argument).
  - The output is always in “ESRI Shapefile” file format.

## Windows notes

Migrate to windows was tricky. I used the GDAL version distributed by
[rwinlib: Static libraries for building R packages on
Windows](https://github.com/rwinlib). I borrowed both the *Makevars.win*
file and the *tools/winlibs.R* from
[rgdal](https://github.com/cran/rgdal).

## See also

[GDAL Github page](https://github.com/OSGeo/gdal)

[GDAL official webpages](https://gdal.org/)

[rgdal project](https://r-forge.r-project.org/projects/rgdal/)

[rwinlib project](https://github.com/rwinlib)

## How to install

Install the current development from github via:

``` r
remotes::install_github("fcorra/GDALPolygonize")
```
