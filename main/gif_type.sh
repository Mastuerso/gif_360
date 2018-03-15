#!/bin/bash
dir=$(pwd)

#VERIFY CALIBRATION FLAG
calibrated=$(bash $dir/lookup.sh calibrated $dir/gif_settings.txt)

if [[ $calibrated -eq $((1)) ]]; then

    SELECTION=$(bash $dir/lookup.sh freeze $dir/gif_settings.txt)

    if [[ $SELECTION -eq 1 ]]; then

        echo "freeze"

    elif [[ $SELECTION -eq 0 ]]; then

        echo "dinamic"

    fi
else

    echo "calibration"

fi
