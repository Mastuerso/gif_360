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
OUTPUT=$(gphoto2 --auto-detect)
COUNT=$((0))
#Number of lines
#echo "${OUTPUT}" 1>&2
CAMERAS=$(echo "${OUTPUT}" | wc -l)
CAMERAS=$((CAMERAS - 2))
CAMPORTS=''

if [[ $CAMERAS -gt 0 ]]; then
  echo "$CAMERAS cameras detected" 1>&2
  while read -r line; do
    COUNT=$((COUNT + 1))
    #GET CAMERAS PORTS
    if [[ $COUNT -gt 2 ]]; then
      #echo "$COUNT: $line" 1>&2
      line=${line:22}
      line="--port="${line//[[:space:]]/}
      CAMPORTS="${CAMPORTS}${line}\n"
      #echo "camera port is $line" 1>&2
      #CONFIGURING CAPTURE TARGET
      camera_capture_target=$(gphoto2 ${line} --get-config=capturetarget | grep Current:)
      camera_capture_target=${camera_capture_target:9}
      if [ "$camera_capture_target" != "Memory card" ]; then
          gphoto2 ${line} --set-config capturetarget=1
      fi
      #CAMERAS NUMBER
      camera_number=$(gphoto2 ${line} --get-config=ownername | grep Current:)
      camera_number=${camera_number:12}
      #echo "camera_number" 1>&2
      cam_ports[${camera_number}]="\n${line}"
      echo "camera $camera_number is at PORT: ${cam_ports[${camera_number}]}" 1>&2
    fi
  done <<< "${OUTPUT}"
  #SORTING CAMERAS
  current_cam=$((0))
  for i in "${cam_ports[@]}"; do
      cam_list[$current_cam]=$i
      current_cam=$(( current_cam + 1 ))
  done
  echo -e "${cam_list[@]}"
else
  echo "No cameras detected"
fi
