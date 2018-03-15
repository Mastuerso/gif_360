#!/bin/bash

echo '==================ASSEMBLING VIDEO==================' 1>&2

w_dir=$1
gifname=$2
dir=$(pwd)
myUserName=$(whoami)
dirPictures="/home/${myUserName}/Pictures/"

FPS=$(bash $dir/lookup.sh delay $w_dir/gif_settings.txt)
FPS=${FPS:-$((12))}

ffmpeg -framerate $FPS -pattern_type glob -i "$w_dir/images/*.JPG" -c:v libx264 -pix_fmt yuv420p "$w_dir/$gifname.mp4"
#ffmpeg -framerate $FPS -start_number $((11)) -i $w_dir/images/image-%d.JPG -c:v libx264 -pix_fmt yuv420p "$w_dir/$gifname.mp4"

if [ -d "${dirPictures}" ]; then
    cp "${w_dir}/${gifname}.mp4" "${myUserName}/${gifname}.mp4"
else
    cp "${w_dir}/${gifname}.mp4" "/home/${myUserName}/Imágenes/${gifname}.mp4"
fi

echo '===============================================' 1>&2
