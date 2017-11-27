#!/bin/bash
#dir=$(pwd)/images
#ffmpeg -framerate 10 -pattern_type glob -i $dir/'*.JPG' -c:v libx264 -pix_fmt yuv420p $dir/'out.mp4'
#echo "$1"
#echo "hola from dummy"
#nohup $(gnome-terminal) & nohup $(gnome-terminal)
#echo "this has been modified"
dir=$(pwd)
SELECTION=$(sed '6q;d' "$dir/gif_settings.txt")
SELECTION=${SELECTION:7}
if [[ $SELECTION -eq 1 ]]; then
  echo "freeze"
elif [[ $SELECTION -eq 0 ]]; then
  echo "dinamic"
fi
