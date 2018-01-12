#!/bin/bash

CAMPORTS=''
COUNT=$((0))
CAM_READY=false

while [[ $CAM_READY != true ]]; do
  OUTPUT=$(gphoto2 --auto-detect)
  #Number of lines
  #echo "${OUTPUT}" 1>&2
  CAMERAS=$(echo "${OUTPUT}" | wc -l)
  CAMERAS=$((CAMERAS - 2))
  if [[ $CAMERAS -gt 0 ]]; then
    CAM_READY=true
  else
    echo "No cameras detected ..." 1>&2
    sleep 20s
  fi
done

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
      #CLEAN SD
      gphoto2 ${line} gphoto2 $line --delete-all-files --folder=/store_00020001/DCIM/100CANON
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
