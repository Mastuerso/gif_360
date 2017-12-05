#!/bin/bash
dir=$(pwd)
file="$dir/chore.list"
#stat $dir/dummy.sh | grep Modify:
#stat $dir/dummy.sh -c %Y
while inotifywait -q -e modify $file >/dev/null; do
    echo "$file changed" 1>&2
    #sleep 1m
    # do whatever else you need to do
    bash $dir/shell_lab.sh
done
