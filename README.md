
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GDALPolygonize

I needed an utility to use GDALPolygonize in R. As far as I know it is
not implemented in R yet. At least it is does not come with the rgdal
package. Therefore, here is an implementation of the C API
GDALPolygonize tool. It does not keep any of the creations options
passed to the rutine with papszOptions, and it is always using 8 point
connectedness. I did not need to change anything.
