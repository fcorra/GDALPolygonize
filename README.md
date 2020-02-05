
<!-- README.md is generated from README.Rmd. Please edit that file -->
GDALPolygonize
==============

I need an utility to use GDALPolygonize in R. As far as I know it is not implemented in R. At least it does not come with the [rgdal package](https://r-forge.r-project.org/projects/rgdal/).

Therefore, I made a simple implementation of the C API GDALPolygonize tool. It has limitations:

-   It does not keep any of the creations options (I omitted the papszOptions argument).
-   It does not overwrite an existing file.
-   The output is always in "ESRI Shapefile" file format.

See also
--------

[GDAL Github page](https://github.com/OSGeo/gdal)

[GDAL official webpages](https://gdal.org/)

How to install
--------------

Install the current development from github via:

``` r
remotes::install_github("fcorra/GDALPolygonize")
```
