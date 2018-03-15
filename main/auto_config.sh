#!/bin/bash
echo '===========CONFIGURING~CAMERAS===========' 1>&2
INPUT=$1
echo "cameras $INPUT" 1>&2
#dir=$(pwd)
dir=${2:-$(pwd)}
echo "working on $dir" 1>&2
#Number of lines
LineCount=$(echo "${INPUT}" | wc -l)
LineCount=$((LineCount - 1))
#camSettings
calibrated=$(bash $dir/lookup.sh calibrated $dir/gif_settings.txt)

if [[ $calibrated -eq $((1)) ]]; then
    index=$((0))
else
    index=$((1))
fi

shutterSpeed=$(bash $dir/lookup.sh Shutter $dir/camera.config $index)
aperture=$(bash $dir/lookup.sh Aperture $dir/camera.config $index)
iso=$(bash $dir/lookup.sh ISO $dir/camera.config $index)
format=$(bash $dir/lookup.sh Image $dir/camera.config $index)

while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    echo "Configuring camera at port: ${line}" 1>&2
    #CONFIGURING CAPTURE TARGET
    camera_capture_target=$(gphoto2 ${line} --get-config=capturetarget | grep Current:)
    camera_capture_target=${camera_capture_target:9}
    gphoto2 "${line}" --delete-all-files --folder="/store_00020001/DCIM/100CANON"
    if [ "$camera_capture_target" != "Memory card" ]; then
        gphoto2 ${line} --set-config capturetarget=1
    fi
    #NoLines="$NoLines$COUNT:  $line\n"
    gphoto2 $line --set-config shutterspeed="${shutterSpeed}"
    gphoto2 $line --set-config aperture="${aperture}"
    gphoto2 $line --set-config iso="${iso}"
    gphoto2 $line --set-config imageformat="${format}"
    if [[ $calibrated -eq $((0)) ]]; then
        gphoto2 $line --trigger-capture
    fi
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"
sleep 1
