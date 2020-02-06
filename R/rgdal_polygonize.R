#' GDALPolygonize in R
#'
#' @description The function calls the C GDALPolygonize routine (using C++). It does not overwrite. It uses always 8 point connectedness. It writes on disc a file in "ESRI Shapefile" format.
#'
#' @param raster name/location of raster file to polygonize. Any driver included in GDAL should work.
#' @param folder name/location of the shape file to write. File extension should not be included.
#' @param layer name of the layer (.shp file) to write. Do not include de file extension.
#' @param field name of the field that will keep the raster values.
#' @param overwrite TRUE/FALSE to overwrite an existing file (folder).
#'
#' @return
#' integer 0
#' @export
#' @examples
#' raster <- system.file("extdata", "bigrastertest.tif", package="GDALPolygonize")
#' folder <- gsub("bigrastertest.tif", "testout", raster)
#' rgdal_polygonize(raster, folder, "cluster", "DN")
rgdal_polygonize <- function(raster, folder, layer, field, overwrite = TRUE){

  if(!file.exists(raster)){
    warning("\n Source file not found!")
    return(1L)
  }

  # check to overwrite
  dst_layer <- paste(paste(folder, layer, sep = .Platform$file.sep), ".shp", sep = "")
  if(file.exists(dst_layer) & overwrite){
    rmvec <- list.files(folder, pattern = layer, full.names = TRUE)
    file.remove(rmvec)

  } else if(file.exists(dst_layer) &! overwrite){
    warning("\nThe destination file lives already in your system,\nuse overwrite = TRUE if you want to replace it.")
    return(1L)
  }

  .Call("gdal_polygonize", raster, folder, layer, field, PACKAGE = "GDALPolygonize")
  return(0L)
}
