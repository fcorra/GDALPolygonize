#include "gdal_priv.h"
#include "ogrsf_frmts.h"
#include "gdal.h"
#include "gdal_alg.h"
#include "R.h"
#include "Rinternals.h"
#include "R_ext/Rdynload.h"

void gdal_polygonize( SEXP raster, SEXP folder, SEXP layer, SEXP field)
{
	GDALDataset *src_raster;
	GDALAllRegister();
	src_raster = (GDALDataset *) GDALOpen( CHAR(asChar(raster)), GA_ReadOnly);
	GDALRasterBand *src_band = src_raster->GetRasterBand( 1 );
	GDALRasterBand *src_mask = src_band->GetMaskBand();

	const char *dst_format = "ESRI Shapefile";
	GDALDriver *dst_driver;
	dst_driver = GetGDALDriverManager()->GetDriverByName(dst_format);

	GDALDataset *dst_dataset;
	dst_dataset = dst_driver->Create( CHAR(asChar(folder)), 0, 0, 0, GDT_CInt32, NULL );

	const char *src_crs = src_raster->GetProjectionRef();
	OGRSpatialReference * dst_crs = new OGRSpatialReference( src_crs );

	OGRLayer *dst_layer = dst_dataset->CreateLayer(CHAR(asChar(layer)), dst_crs, wkbPolygon, NULL );
	OGRFeature *dst_feature;
	dst_feature = OGRFeature::CreateFeature( dst_layer->GetLayerDefn() );
	
	OGRFieldDefn dst_field( CHAR(asChar(field)), OFTInteger );
	dst_layer->CreateField( &dst_field );

	int iPixValField = dst_feature->GetFieldIndex( CHAR(asChar(field)) );

	char **papszOptions = NULL;
	papszOptions = CSLSetNameValue( papszOptions, "CONNECTED", "8" );
	GDALPolygonize(src_band, src_mask, dst_layer, iPixValField, papszOptions, NULL, NULL);

	GDALClose(src_raster);
	GDALClose(dst_dataset);

}

static const R_CallMethodDef callMethods[] = {
	{"gdal_polygonize", (DL_FUNC) &gdal_polygonize, 4},
	{NULL, NULL, 0}
};

extern "C"{
  void R_init_GDALPolygonize(DllInfo *info){
    R_registerRoutines(info, NULL, callMethods, NULL, NULL);
    R_useDynamicSymbols(info, FALSE);
  }
}
