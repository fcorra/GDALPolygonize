# if(getRversion() < "3.3.0") {
#   stop("Your version of R is too old. This package requires R-3.3.0 or newer on Windows.")
# }
#
# # Download gdal-2.2.0 from rwinlib
# VERSION <- commandArgs(TRUE)
# if(!file.exists(sprintf("../windows/gdal2-%s/include/gdal/gdal.h", VERSION))){
#   if(getRversion() < "3.3.0") setInternet2()
#   download.file(sprintf("https://github.com/rwinlib/gdal2/archive/v%s.zip", VERSION), "lib.zip", quiet = TRUE)
#   dir.create("../windows", showWarnings = FALSE)
#   unzip("lib.zip", exdir = "../windows")
#   unlink("lib.zip")
# }

# download.file("https://github.com/OSGeo/gdal/archive/master.zip", destfile = "gdal.zip", quiet = TRUE)
# dir.create("../libgdal", showWarnings = FALSE)
# unzip("gdal.zip", exdir = "..libgdal")
# unlink("gdal.zip")

download.file("http://download.gisinternals.com/sdk/downloads/release-1900-gdal-3-0-2-mapserver-7-4-2.zip",
              destfile = "gdalbin.zip", quiet = TRUE)
dir.create("../libgdal", showWarnings = FALSE)
unzip("gdalbin.zip", exdir = "../libgdal")
unlink("gdalbin.zip")
