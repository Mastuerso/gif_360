#!/bin/bash

OUTPUT=$1
COUNT=$((0))
#Number of lines
LineCount=$(echo "${OUTPUT}" | wc -l)
#echo "LineCount: $LineCount" 1>&2
NoLines=''

while read -r line; do
  COUNT=$((COUNT + 1))
  if [[ $COUNT -lt $LineCount ]]; then
    NoLines="$NoLines$COUNT:  $line\n"
  fi
done <<< "${OUTPUT}"
  echo -e "$NoLines"
