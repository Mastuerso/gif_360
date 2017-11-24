#!/bin/bash
gifname=$(date +"%b%d-%H%M")
w_dir=$(pwd)
FPS=$(sed '1q;d' "$w_dir/gif_settings.txt")
FPS=${FPS:6}
put_MARK=$(sed '10q;d' "$w_dir/gif_settings.txt")
put_MARK=${put_MARK:10}
MARK=$(sed '11q;d' "$w_dir/gif_settings.txt")
MARK=${MARK:6}
QUALITY=$(sed '5q;d' "$w_dir/gif_settings.txt")
QUALITY=${QUALITY:8}

if [ $QUALITY -lt $((100)) ]; then
    mogrify -resize "$QUALITY%" "$(pwd)/images/*.JPG"
fi

echo $gifname.mp4 >gif_name.txt

echo '====================MP4============================'


ffmpeg -framerate $FPS -pattern_type glob -i $w_dir'/images/*.JPG' -c:v libx264 -pix_fmt yuv420p $w_dir/$gifname.mp4

#sleep 2

if [ $put_MARK -eq $((1)) ]; then
    echo '===================WATERMARK================================'
    echo $MARK
    ffmpeg -vcodec libx264 -i $w_dir/$gifname.mp4 -i $MARK -filter_complex "overlay=x=(main_w-overlay_w)/2:y=(main_h-overlay_h)/2" b$gifname.mp4
    rm $w_dir/$gifname.mp4
    mv $w_dir/b$gifname.mp4 $w_dir/$gifname.mp4
fi

mv "$w_dir/$gifname.mp4" "/home/onikom/Pictures/$gifname.mp4"