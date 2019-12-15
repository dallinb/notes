# Using GeoJSON from Eurostat

## Overview

GeoJSON

An excellent primer was created by
[Eve the Analyst](http://datawanderings.com/about/)
to take one through the
http://datawanderings.com/2018/08/19/extracting-countries-from-geojson-with-ogr2ogr/
https://gdal.org/programs/index.html

## Extracting a Country Border

In this example, we'll use the
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
docker run \
  --rm \
  -v $PWD:$PWD \
  -w $PWD \
  osgeo/gdal:alpine-small-latest ogr2ogr \
    -where "id = 'UK'" uk.geojson \
    CNTR_RG_10M_2016_4326.geojson CNTR_RG_10M_2016_4326
```

## Post Extraction Activities & Validation

### Visually Validating the GeoJSON

If we try out the GeoJSON at http://geojsonlint.com/ it returns two
error messages:

* old-style crs member is not recommended
* Polygons and MultiPolygons should follow the right-hand rule

### Remove the "crs" field.

This is pretty straight forward and simply means removing the "crs" key and
value from the GeoJSON.

### The "Right-Hand-Rule"

One can either remove the field interactively with the web based tool at
http://mapster.me/right-hand-rule-geojson-fixer/ or, if programming with
Python, use the `geojson-rewind` package at
https://pypi.org/project/geojson-rewind/

## References

https://ec.europa.eu/eurostat/cache/GISCO/distribution/v2/
