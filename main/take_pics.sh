#!/bin/bash
INPUT=$1
#echo "$INPUT" 1>&2
COUNT=$((0))
dir=$(pwd)
DELAY=$(sed '7q;d' "$dir/gif_settings.txt")
DELAY=${DELAY:8}
DELAY=$(bc <<< "scale=3;$DELAY/$((1000))")
#echo "$DELAY" 1>&2
#Number of lines
LineCount=$(echo "${INPUT}" | wc -l)
LineCount=$((LineCount - 1))
#echo "LineCount: $LineCount" 1>&2
NoLines=''

while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    #NoLines="$NoLines$COUNT:  $line\n"
    gphoto2 $line --trigger-capture &
    sleep "$DELAY"
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"
#echo -e "$NoLines"
