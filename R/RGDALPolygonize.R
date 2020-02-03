#' GDALPolygonize
#'
#' @description GDALPolygonize is not available in rgdal. Moreover, it is only available in C or Python. The function implements GDALPolygonize in the R environment
#'
#' @param input input name of raster file to polygonize
#' @param output output name of the shape file to write
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
