#!/bin/bash
echo "=================VIDEO=================" 1>&2
gifname=$(date +%b%d_%k%M_%S)
w_dir=$1
FPS=$(sed '1q;d' "$w_dir/gif_settings.txt")
FPS=${FPS:6}
put_MARK=$(sed '10q;d' "$w_dir/gif_settings.txt")
put_MARK=${put_MARK:10}
MARK=$(sed '11q;d' "$w_dir/gif_settings.txt")
MARK=${MARK:6}
QUALITY=$(sed '5q;d' "$w_dir/gif_settings.txt")
QUALITY=${QUALITY:8}

if [ ! -f $w_dir/*.mp4 ]; then
    GIFDONE=$((0))
    #echo "$GIFDONE"
  else
    GIFDONE=$((1))
    #echo "$GIFDONE"
fi

if [[ $GIFDONE -ne 1 ]]; then
  bash net_gif.sh "$w_dir" "$gifname"
  if [ $QUALITY -lt $((100)) ]; then
      mogrify -resize "$QUALITY%" "$(pwd)/images/*.JPG"
  fi

  echo $gifname.mp4 > $w_dir/gif_name.txt

  echo '====================MP4============================'

  ffmpeg -framerate $FPS -pattern_type glob -i "$w_dir/images/*.JPG" -c:v libx264 -pix_fmt yuv420p "$w_dir/$gifname.mp4"
  #ffmpeg -framerate $FPS -start_number $((11)) -i $w_dir/images/image-%d.JPG -c:v libx264 -pix_fmt yuv420p "$w_dir/$gifname.mp4"

  if [ $put_MARK -eq $((1)) ]; then
      echo '===================WATERMARK================================'
      #echo $MARK
      ffmpeg -i $w_dir/$gifname.mp4 -i $MARK -filter_complex "overlay=x=(main_w-overlay_w)/2:y=(main_h-overlay_h)/2" -c:v libx264 -pix_fmt yuv420p $w_dir/b$gifname.mp4
      rm $w_dir/$gifname.mp4
      mv $w_dir/b$gifname.mp4 $w_dir/$gifname.mp4
  fi

  cp "$w_dir/$gifname.mp4" "/home/onikom/Pictures/$gifname.mp4"
fi
