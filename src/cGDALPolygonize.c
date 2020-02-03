#include "gdal/gdal.h"
#include "gdal/ogr_api.h"
#include "gdal/gdal_alg.h"
#include "gdal/cpl_string.h"
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

void cGDALPolygonize(SEXP inpunt_, SEXP output_)
{
  //Define
  //[Raster]
  GDALDatasetH  hDataset;
  GDALRasterBandH hBand;
  const char *pszFilename;
  char *inSpatialReference;
  char **papszOptions = NULL;

  //[Vector]
  GDALDriverH *poDriver;
  GDALDatasetH hDS;
  OGRLayerH hLayer;
  OGRFieldDefnH hFieldDefn;
  int iPixValField;
  const char *outFilename;

  //Execute
  GDALAllRegister();
  pszFilename = CHAR(asChar(inpunt_));
  hDataset = GDALOpen( pszFilename, GA_ReadOnly );
  hBand = GDALGetRasterBand( hDataset, 1 );

  poDriver = (GDALDriverH*) GDALGetDriverByName( "ESRI Shapefile" );
  outFilename = CHAR(asChar(output_));
  hDS = GDALCreate( poDriver, outFilename, 0, 0, 0, GDT_Unknown, NULL );
  //GDALSetProjection(hDS, GDALGetProjectionRef(hDataset));
  hLayer = GDALDatasetCreateLayer(hDS, "Clusters", NULL, wkbUnknown, NULL);
  hFieldDefn = OGR_Fld_Create( "Polymer", OFTInteger );
  iPixValField = OGR_L_FindFieldIndex( hLayer, "Polymer", 1 );

  papszOptions = CSLSetNameValue( papszOptions, "CONNECTED", "8" );
  GDALPolygonize(hBand, NULL, hLayer, iPixValField, papszOptions, NULL, NULL);

  //End
  GDALClose(hDataset);
  GDALClose(hDS);
}

static const R_CallMethodDef callMethods[]  = {
  {"cGDALPolygonize", (DL_FUNC) &cGDALPolygonize, 2},
  {NULL, NULL}
};

void R_init_myLib(DllInfo *info) {
    R_registerRoutines(info, NULL, callMethods, NULL, NULL);
}

