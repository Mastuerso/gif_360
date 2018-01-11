#!/bin/bash
echo "=================VIDEO=================" 1>&2
myUserName=$(whoami)
gifnamex=$(date +%b%d_%k%M_%S)
gifname=$(echo ${gifnamex//[[:blank:]]/})
w_dir=$1
FPS=$(sed '1q;d' "$w_dir/gif_settings.txt")
FPS=${FPS:6}
put_MARK=$(sed '10q;d' "$w_dir/gif_settings.txt")
put_MARK=${put_MARK:10}
MARK=$(sed '11q;d' "$w_dir/gif_settings.txt")
MARK=${MARK:6}
QUALITY=$(sed '5q;d' "$w_dir/gif_settings.txt")
QUALITY=${QUALITY:8}

GIFDONE=$(bash "$dir/file_exist.sh" "$w_dir" "mp4")

if [[ $GIFDONE -ne 1 ]]; then
  #insert calibration script here 
  #read and apply rotation
  bash backImg.sh "$w_dir"  
  bash net_gif.sh "$w_dir" "$gifname"
  if [ $QUALITY -lt $((100)) ]; then
      mogrify -resize $QUALITY"%" $w_dir/images/*.JPG
      sleep 2s
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
  
  cp "$w_dir/$gifname.mp4" "/home/$myUserName/Pictures/$gifname.mp4"
fi
