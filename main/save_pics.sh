#!/bin/bash
INPUT=$1
echo "$INPUT" 1>&2
COUNT=$((0))
INDEX=$((0))
dir=$(pwd)
gif_dir_x=$dir/gifs/$(date +%b%d_%k%M_%S)
gif_dir=$(echo ${gif_dir_x//[[:blank:]]/})
echo "$gif_dir" 1>&2
mkdir -p $gif_dir/images
cp $dir/gif_settings.txt $gif_dir
#Number of lines
LineCount=$(echo "${INPUT}" | wc -l)
LineCount=$((LineCount - 1))
#echo "LineCount: $LineCount" 1>&2

while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    pic_name="image-$((COUNT + 10)).JPG"
    pic_names[$INDEX]="$pic_name"
    #pic_name=`printf %04d%s ${a%*}`.JPG
    nohup gphoto2 $line --get-all-files --filename "$gif_dir/images/$pic_name" --force-overwrite &
    #gphoto2 $line --delete-all-files --folder=/store_00020001/DCIM/100CANON
    INDEX=$((INDEX +1))
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"

#CHECK IMGs HERE
thisDir=$(bash $dir/file_check.sh $gif_dir/images JPG $INDEX)

COUNT=$((0))
while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    nohup gphoto2 $line --delete-all-files --folder=/store_00020001/DCIM/100CANON &
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"

if [ "$thisDir" == "valid dir" ]; then
    bash "$dir/do_video.sh" "$gif_dir"
    echo "$gif_dir" >> chore.list
fi
