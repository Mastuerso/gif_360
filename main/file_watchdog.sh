#!/bin/bash
dir=$(pwd)
file="$dir/chore.list"
while true; do
    inotifywait -qe modify $file >/dev/null
    echo "$file changed" 1>&2
    bash $dir/create_share.sh
done
