#!/bin/bash
selection=$1
minidir=$2
#echo -e "selection: ${selection} \nminidir: ${minidir}"
if [[ $selection == "mail" ]]; then
    phpFile="/var/www/html/gif_360_web/server/send_mail.php"
elif [[ $selection == "facebook" ]]; then
    phpFile="/var/www/html/gif_360_web/server/fbk_upld.php"
fi
php "${phpFile}" "${minidir}"
