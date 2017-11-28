#!/bin/bash
dir=$(pwd)
file="$dir/chore.list"
#stat $dir/dummy.sh | grep Modify:
#stat $dir/dummy.sh -c %Y
TASKS=$((0))
while inotifywait -q -e modify $file >/dev/null; do
    echo "$file changed" 1>&2
    # do whatever else you need to do
    # do_video
    # send_mail
    # fb_post
    TASKS=$((TASKS + 1))
    bash shell_lab2.sh $TASKS
done
