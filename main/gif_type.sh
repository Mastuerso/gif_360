#!/bin/bash
dir=$(pwd)

#VERIFY CALIBRATION FLAG
calibrated=$(bash $dir/lookup.sh calibrated gif_settings.txt)

if [[ $calibrated -eq $((1)) ]]; then

    SELECTION=$(sed '6q;d' "$dir/gif_settings.txt")
    SELECTION=${SELECTION:7}
    
    if [[ $SELECTION -eq 1 ]]; then
    
        echo "freeze"
        
    elif [[ $SELECTION -eq 0 ]]; then
    
        echo "dinamic"
        
    fi
else

    echo "calibration"
    
fi
