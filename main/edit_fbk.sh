#!/bin/bash
#modify fbk_upload, upload to facebook
file_addrss=$1
post_msg=$2

file_addrss=$(echo "$file_addrss" | sed 's_/_\\/_g')

link_arg="7s/.*/\$link_gif=\"http:\/\/socialevent.mx\/gif\/uploads\/360\/${gif_name}\";/"
message_arg="8s/.*/\$message_gif=\"${post_msg}\";/"
video_dir="9s/.*/\$video_dir=\"${file_addrss}\";/"

#echo "$message_arg"
#echo "$link_arg"
#echo "$video_dir"

sed -i $link_arg /var/www/html/gif_360_web/server/fbk_upld.php
sed -i $message_arg /var/www/html/gif_360_web/server/fbk_upld.php
sed -i $video_dir /var/www/html/gif_360_web/server/fbk_upld.php
