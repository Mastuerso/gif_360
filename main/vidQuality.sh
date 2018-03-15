#!/bin/bash
echo "===============Quality===============" 1>&2
dir=$(pwd)
#echo "${dir}"
w_dir=$1
#echo "${w_dir}"
QUALITY=$(bash "$dir/lookup.sh" "quality" "$w_dir/gif_settings.txt")
echo "QUALITY:${QUALITY}" 1>&2
QUALITY=${QUALITY:-$((100))}
if [[ $QUALITY -lt $((100)) ]]; then
    mogrify -resize $QUALITY"%" $w_dir/images/*.JPG
fi

echo "=====================================" 1>&2
