#!/bin/bash
camera_capture_target=$(gphoto2 --get-config=capturetarget | grep Current:)
camera_capture_target=${camera_capture_target:9}
if [ "$camera_capture_target" != "Memory card" ]; then
    echo "change to SD"
fi