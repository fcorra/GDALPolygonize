#' GDALPolygonize
#'
#' @description The function calls the C GDALPolygonize routine. It does not overwrite. It uses always 8 point connectedness. It returns always a file in "ESRI Shapefile" format.
#'
#' @param input name/location of raster file to polygonize. Any driver included in GDAL should work.
#' @param output name/location of the shape file to write. File extension should not be included.
#'
#' @return
#' integer 0
#' @export
#' @examples
#' NULL
RGDALPolygonize <- function(input, output){
  .Call("cGDALPolygonize", input, output)
  return(0L)
}
