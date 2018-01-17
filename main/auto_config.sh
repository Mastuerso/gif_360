#!/bin/bash
INPUT=$1
dir=$(pwd)
#Number of lines
LineCount=$(echo "${INPUT}" | wc -l)
LineCount=$((LineCount - 1))
#camSettings
calibrated=$(bash $dir/lookup.sh calibrated gif_settings.txt)

if [[ $calibrated -eq $((1)) ]]; then
    index=$((0))
else
    index=$((1))
fi

shutterSpeed=$(bash $dir/lookup.sh Shutter camera.config $index)
aperture=$(bash $dir/lookup.sh Aperture camera.config $index)
iso=$(bash $dir/lookup.sh ISO camera.config $index)
format=$(bash $dir/lookup.sh Image camera.config $index)

while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    #NoLines="$NoLines$COUNT:  $line\n"
    gphoto2 $line --set-config shutterspeed=$shutterSpeed
    gphoto2 $line --set-config aperture=$aperture
    gphoto2 $line --set-config iso=$iso
    gphoto2 $line --set-config imageformat=$format
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"