#!/bin/bash
dir=$(pwd)
SELECTION=$(sed '6q;d' "$dir/gif_settings.txt")
SELECTION=${SELECTION:7}

#VERIFY CALIBRATION FLAG
calibrated=$(bash $dir/lookup.sh calibrated gif_settings.txt)

if [[ $calibrated -eq $((1)) ]]; then
    if [[ $SELECTION -eq 1 ]]; then
        echo "freeze"
    elif [[ $SELECTION -eq 0 ]]; then
        echo "dinamic"
    fi
else
    #CalibrationScript and get calibration parameters
    #modify camera settings
    echo "calibration"
fi
