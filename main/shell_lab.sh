#!/bin/bash
#dir=$(pwd)/images
#ffmpeg -framerate 10 -pattern_type glob -i $dir/'*.JPG' -c:v libx264 -pix_fmt yuv420p $dir/'out.mp4'
#echo "$1"
#echo "hola from dummy"
#nohup $(gnome-terminal) & nohup $(gnome-terminal)
#echo "this has been modified"
#dir=$(pwd)
#SELECTION=$(sed '6q;d' "$dir/gif_settings.txt")
#SELECTION=${SELECTION:7}
#if [[ $SELECTION -eq 1 ]]; then
#  echo "freeze"
#elif [[ $SELECTION -eq 0 ]]; then
#  echo "dinamic"
#fi
OUTPUT="$(gphoto2 --auto-detect)"
COUNT=$((0))
#Number of lines
#echo "${OUTPUT}" | wc -l
CAMERAS=$(echo "${OUTPUT}" | wc -l)
CAMERAS=$((CAMERAS - 2))
CAMPORTS=''

if [[ $CAMERAS -gt 0 ]]; then
  echo "$CAMERAS detected" 1>&2
  while read -r line; do
    COUNT=$((COUNT + 1))
    if [[ $COUNT -gt 2 ]]; then
      line=${line:22}
      line="--port="${line//[[:space:]]/}
      CAMPORTS="${CAMPORTS}${line}\n"
      echo "$line" 1>&2
      #camera_capture_target=$(gphoto2 ${line} --get-config=capturetarget | grep Current:)
      #camera_capture_target=${camera_capture_target:9}
      #if [ "$camera_capture_target" != "Memory card" ]; then
      #    gphoto2 ${line} --set-config capturetarget=1
      #fi
    fi
  done <<< "${OUTPUT}"
  echo -e "$CAMPORTS"
else
  echo "No cameras detected"
fi
