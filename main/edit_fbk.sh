#!/bin/bash
#modify fbk_upload, upload to facebook
gif_name=$1

link_arg="7s/.*/\$link_gif=\"http:\/\/www.onikom.com.mx\/gif360\/${gif_name}\";/"
message_arg="8s/.*/\$message_gif=\"${gif_name}\";/"

#echo $message_arg
#echo $link_arg

sed -i $link_arg /var/www/html/gif_360_web/server/fbk_upld.php
sed -i $message_arg /var/www/html/gif_360_web/server/fbk_upld.php