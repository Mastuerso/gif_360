#!/bin/bash
dir=$(pwd)
file="$dir/camera.config"
while true; do
    inotifywait -qe modify $file >/dev/null
    echo "$file changed" 1>&2
    python "$dir/setConfig.py"
done
