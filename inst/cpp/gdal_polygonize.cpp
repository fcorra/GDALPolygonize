#include "gdal_priv.h"
#include "ogrsf_frmts.h"
#include "gdal.h"
#include "gdal_alg.h"

int main( int argc, char *argv[])
{
	GDALDataset *src_raster;
	GDALAllRegister();
	src_raster = (GDALDataset *) GDALOpen( argv[1], GA_ReadOnly);
	GDALRasterBand *src_band = src_raster->GetRasterBand( 1 );
	GDALRasterBand *src_mask = src_band->GetMaskBand();

	const char *dst_format = "ESRI Shapefile";
	GDALDriver *dst_driver;
	dst_driver = GetGDALDriverManager()->GetDriverByName(dst_format);

	GDALDataset *dst_dataset;
	dst_dataset = dst_driver->Create( argv[2], 0, 0, 0, GDT_CInt32, NULL );

	const char *src_crs = src_raster->GetProjectionRef();
	OGRSpatialReference * dst_crs = new OGRSpatialReference( src_crs );

	OGRLayer *dst_layer = dst_dataset->CreateLayer(argv[3], dst_crs, wkbPolygon, NULL );
	OGRFeature *dst_feature;
	dst_feature = OGRFeature::CreateFeature( dst_layer->GetLayerDefn() );
	
	OGRFieldDefn dst_field( argv[4], OFTInteger );
	dst_layer->CreateField( &dst_field );

	int iPixValField = dst_feature->GetFieldIndex( argv[4] );

	char **papszOptions = NULL;
	papszOptions = CSLSetNameValue( papszOptions, "CONNECTED", "8" );
	GDALPolygonize(src_band, src_mask, dst_layer, iPixValField, papszOptions, NULL, NULL);

	GDALClose(src_raster);
	GDALClose(dst_dataset);

	return 0;
}
