#!/bin/sh

if [ -z "$*" ]; then
   echo "usage: $(basename $0) title"
   exit 2
fi

title="$*"
dir=$( date +'%Y/%m' )
mkdir -p $dir
file=$( echo $title | tr 'A-Z' 'a-z' | tr ' ' '_' )
file="${dir}/${file}.md"

echo "Title: $title"
echo "File: $file"

echo "# $title" > $file
