#!/bin/bash
dir=$(pwd)
file="$dir/chore.list"
#stat $dir/dummy.sh | grep Modify:
#stat $dir/dummy.sh -c %Y
while inotifywait -q -e modify $file >/dev/null; do
    echo "$file changed" 1>&2
    # do whatever else you need to do
    LineCount=$(echo "${file}" | wc -l)
    if [[ $LineCount -gt 1 ]]; then
      bash create_share.sh
    fi
done
