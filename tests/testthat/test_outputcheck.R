context("Check the output")
library(sp)
library(rgdal)

test_that("The CRS of raster in preserved in output",
          {
            raster <- system.file("extdata", "bigrastertest.tif", package="GDALPolygonize")
            folder <- gsub("bigrastertest.tif", "testout", raster)
            rgdal_polygonize(raster, folder, "cluster", "DN")
            x <- readOGR(folder, "cluster")
            y <- readGDAL(raster)
            expect_identical(x@proj4string, y@proj4string)
          })

test_that("Check if overwrite is posible",
          {
            raster <- system.file("extdata", "bigrastertest.tif", package="GDALPolygonize")
            folder <- gsub("bigrastertest.tif", "testout", raster)
            rgdal_polygonize(raster, folder, "cluster", "DN")
            out <- rgdal_polygonize(raster, folder, "cluster", "DN")
            expect_true(out == 0L)
          })

test_that("Check if overwrite warning is inplace",
          {
            raster <- system.file("extdata", "bigrastertest.tif", package="GDALPolygonize")
            folder <- gsub("bigrastertest.tif", "testout", raster)
            expect_warning(out <- rgdal_polygonize(raster, folder, "cluster", "DN", overwrite = FALSE))
            expect_true(out == 1L)
          })

test_that("Check if missing file warning is in place",
          {
            expect_warning(out <- rgdal_polygonize("fake_file.tif", "foo", "foo", "foo"))
            expect_true(out == 1L)
          })

test_that("Check output names",
          {
            folder <- system.file("extdata", "testout", package="GDALPolygonize")
            x <- readOGR(folder, "cluster")
            expect_true(colnames(x@data) == "DN")
          })

test_that("Check if the output has the right dimentions",
          {
            folder <- system.file("extdata", "testout", package="GDALPolygonize")
            x <- readOGR(folder, "cluster")
            expect_true(dim(x@data)[1] == 1543 & length(unique(x@data[,1])) == 10)
          })
