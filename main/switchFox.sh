#!/bin/bash
dir=$(pwd)
foxPorcess=$(ps -e | grep firefox)
foxPorcess=${foxPorcess:1}
foxPorcess=${foxPorcess:0:4}
calibrated=$(bash "$dir/lookup.sh" "calibrated" "$dir/gif_settings.txt")
#echo "${foxPorcess}"
#echo "${calibrated}"

if [[ ${foxPorcess} != "" ]]; then
    echo "Firefox process number is: ${foxPorcess}"
    disown -h ${foxPorcess}
    if [[ ${calibrated} -eq $((0)) ]]; then
	kill ${foxPorcess}
        
    fi
else
    echo "Firefox is not beign executed"
    if [[ ${calibrated} -eq $((1)) ]]; then
	#kill ${foxPorcess}
        firefox localhost/gif_360_web/gui/ &
    fi
fi
