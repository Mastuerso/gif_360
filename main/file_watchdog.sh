#!/bin/bash
dir=$(pwd)
#stat $dir/dummy.sh | grep Modify:
#stat $dir/dummy.sh -c %Y
TASKS=$((0))
while inotifywait -q -e modify $dir/dummy.sh >/dev/null; do
    echo "filename is changed"
    # do whatever else you need to do
    # do_video
    # send_mail
    # fb_post
    TASKS=$((TASKS + 1))
    echo $TASKS
done
