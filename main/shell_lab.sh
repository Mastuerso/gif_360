#!/bin/bash
#detect cameras and check connectivity
CAMERAS=$(gphoto2 --auto-detect | grep usb)
#echo "${CAMERAS}"
if [[ "${CAMERAS}" != "" ]]; then
    while read CAMERA; do
        PORT=${CAMERA:22}
        PORT="--port="${PORT//[[:space:]]/}
        MSG=$(bash shell_lab2.sh)
        echo "${MSG}"
    done <<< "${CAMERAS}"
fi