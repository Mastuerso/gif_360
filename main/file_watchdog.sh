#!/bin/bash
dir=$(pwd)
file="$dir/chore.list"
#stat $dir/dummy.sh | grep Modify:
#stat $dir/dummy.sh -c %Y
while inotifywait -q -e modify $file >/dev/null; do
    echo "$file changed" 1>&2
    sleep 40s
    # do whatever else you need to do
    bash create_share.sh
done
