#!/bin/sh
# Extract GeoJSON from the Eustat provided data.
#
# https://ec.europa.eu/eurostat/cache/GISCO/distribution/v2/communes/download/#communes16
# https://ec.europa.eu/eurostat/cache/GISCO/distribution/v2/nuts/download/#nuts16
set -e

INPUTDIR="$1"
LINTER="$( pwd )/geojson-lint.py"
OUTPUTDIR="$2"
PROG=$(basename $0)
TMPDIR="/tmp/${PROG}.$$.tmp"

function cleanup() {
  echo "INFO: cleanup, removing ${TMPDIR}"
  rm -rf $TMPDIR
}

function process_countries() {
  infile="COMM_RG_${resolution}_${year}_4326.geojson"
  docker run \
    --rm \
    -v $PWD:$PWD \
    -w $PWD \
    osgeo/gdal:alpine-small-latest ogrinfo $infile
  layer=$( echo "COMM_RG_${resolution}_${year}_4326" )
  echo "INFO: Layer ${layer} in ${infile}"

  for country in $( jq '.features[].id' $infile | tr -d '"' | sort -u )
  do
    outfile="${country}-${resolution}.geojson"

    if [ ! -f "${OUTPUTDIR}/${outfile}" ]; then
      docker run \
        --rm \
        -v $PWD:$PWD \
        -w $PWD \
        osgeo/gdal:alpine-small-latest ogr2ogr \
          -where "id = '${country}'" \
          $outfile \
          $infile \
          $layer

      if [ "$( jq .features $outfile )" = '[]' ]; then
        echo "WARN: Removing featureless file ${outfile}"
        rm $outfile
      else
        $LINTER $outfile | jq . > "${OUTPUTDIR}/${outfile}"
      fi
    else
      echo "INFO: File ${OUTPUTDIR}/${outfile} already exists."
    fi
  done
}

function process_file() {
  echo "INFO: Processing ${input_file}"
  bname=$( basename $input_file )
  theme=$( echo $bname | cut -d- -f 2 )
  year=$( echo $bname | cut -d- -f 3 )
  resolution=$( echo $bname | cut -d- -f 4 | cut -d. -f1 | tr 'a-z' 'A-Z')
  cd /
  cleanup
  mkdir $TMPDIR
  cd $TMPDIR
  unzip $input_file

  if [ $theme = 'countries' ]; then
    process_countries $resolution
  elif [ $theme = 'nuts' ]; then
    process_nuts $resolution
  else
    echo "ERROR: Unknown theme ${theme}."
    exit 1
  fi
}

function process_nuts() {
  ls -l
}

function usage_message() {
  echo "usage: ${PROG} inputdir outputdir" 1>&2
  exit 2
}

[[ $# -ne 2 ]] && usage_message
trap cleanup EXIT

if [ ! -d $OUTPUTDIR ]; then
  echo "INFO: creating ${OUTPUTDIR} directory."
  mkdir $OUTPUTDIR
fi

for category in countries nuts; do
  for input_file in ${INPUTDIR}/ref-${category}-????-??m.geojson.zip; do
    process_file $input_file
  done
done

echo "INFO: Complete"
exit 0
