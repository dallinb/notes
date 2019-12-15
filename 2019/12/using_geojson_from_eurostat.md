# Using GeoJSON from Eurostat

## Overview

GeoJSON

An excellent primer was created by
[Eve the Analyst](http://datawanderings.com/about/)
to take one through the 
http://datawanderings.com/2018/08/19/extracting-countries-from-geojson-with-ogr2ogr/
https://gdal.org/programs/index.html

## Extracting a Country Border

https://github.com/OSGeo/gdal/tree/master/gdal/docker

```bash
docker pull osgeo/gdal:alpine-small-latest
```

```bash
docker run \
  --rm \
  -v $PWD:$PWD \
  -w $PWD \
  osgeo/gdal:alpine-small-latest ogrinfo CNTR_RG_01M_2016_4326.geojson
```

The output of the above command should be:

```
INFO: Open of `CNTR_RG_01M_2016_4326.geojson'
      using driver `GeoJSON' successful.
1: CNTR_RG_01M_2016_4326
```

```bash
docker run --rm -v $PWD:$PWD -w $PWD osgeo/gdal:alpine-small-latest ogr2ogr -where "id = 'UK'" uk.geojson CNTR_RG_10M_2016_4326.geojson CNTR_RG_10M_2016_4326
```

## Post Extraction Activities & Validation

### Visually Validating the GeoJSON

http://geojsonlint.com/

### Remove the "crs" field.

### The "Right-Hand-Rule"

http://mapster.me/right-hand-rule-geojson-fixer/
https://pypi.org/project/geojson-rewind/

## References

https://ec.europa.eu/eurostat/cache/GISCO/distribution/v2/
