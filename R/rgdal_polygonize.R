#' GDALPolygonize in R
#'
#' @description The function calls the C GDALPolygonize routine (using C++). It does not overwrite. It uses always 8 point connectedness. It returns always a file in "ESRI Shapefile" format.
#'
#' @param raster name/location of raster file to polygonize. Any driver included in GDAL should work.
#' @param folder name/location of the shape file to write. File extension should not be included.
#' @param layer name of the layer (.shp file) to write.
#' @param field name of the field that will keep the raster values.
#'
#' @return
#' integer 0
#' @export
#' @examples
#' NULL
rgdal_polygonize <- function(raster, folder, layer, field){
  .Call("gdal_polygonize", raster, folder, layer, field)
  return(0L)
}
