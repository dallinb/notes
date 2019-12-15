#!/bin/sh

head -2 README.md > README.md.tmp
oldsubtitle=''

for file in $( find ???? -type f | sort ); do
  subtitle=$( dirname $file | tr '/' '-' )

  if [[ "$subtitle" != "$oldsubtitle" ]]; then
    echo "## $subtitle" >> README.md.tmp
  fi

  echo "* $(sed 's/^#.\(.*\)$/[\1]/' $file )($file)" >> README.md.tmp
done

mv README.md.tmp README.md
