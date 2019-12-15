#!/usr/bin/env python3
import geojson
import json
import sys

from geojson_rewind import rewind

with open(sys.argv[1]) as json_file:
    data = json.load(json_file)

    if 'crs' in data:
        del data['crs']

    data = rewind(data)
    widget = geojson.GeoJSON(data)
    widget.is_valid
    widget.errors()
    print(widget)
