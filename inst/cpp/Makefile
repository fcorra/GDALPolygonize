CXXFLAGS += `pkg-config --cflags gdal`
LDLIBS += `pkg-config --libs gdal`

BINS = gdal_polygonize
gdal_polygonize_OBJS = gdal_polygonize.o

all: $(BINS)

gdal_polygonize : $(gdal_polygonize_OBJS)
	$(CXX) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@

%.o: %.cpp
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@

