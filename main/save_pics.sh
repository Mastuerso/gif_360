#!/bin/bash
INPUT=$1
#echo "$INPUT" 1>&2
COUNT=$((0))
dir=$(pwd)
gif_dir=$dir/gifs/$(date +%b%d_%k%M_%S)
mkdir -p $gif_dir/images
cp $dir/gif_settings.txt $priv_dir
#Number of lines
LineCount=$(echo "${INPUT}" | wc -l)
LineCount=$((LineCount - 1))
#echo "LineCount: $LineCount" 1>&2

while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    pic_name="image-$((COUNT + 10)).JPG"
    gphoto2 $line --get-all-files --filename "$gif_dir/images/$pic_name" --force-overwrite
    gphoto2 $line --delete-all-files --folder=/store_00020001/DCIM/100CANON
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"
echo "$gif_dir" >> chore.list
