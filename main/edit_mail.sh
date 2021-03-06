#!/bin/bash

#check if send mail is required
wdir=$1
myUserName=$(whoami)

isMailReq=$(sed '8q;d' "$wdir/gif_settings.txt")
isMailReq=${isMailReq:6}

if [ $isMailReq -eq $((0)) ]; then
    echo "email not required" 1>&2
else
    echo "Sending email ..." 1>&2
    sendmail_file="/var/www/html/gif_360_web/server/send_mail.php"

    #get recipient mail
    recipient=$(sed '9q;d' "$wdir/gif_settings.txt")
    recipient=${recipient:7}
    echo "recipient: $recipient" 1>&2

    #get gif name
    gif_name=$(sed '1q;d' "$wdir/gif_name.txt")
    echo "gif name: $gif_name" 1>&2

    img_name="${gif_name::-4}.gif"

    #modifying php ...
    echo "Editing and sending..." 1>&2

    #email line
    echo recipient 1>&2
    email_line="16s/.*/\$recipient=\'${recipient}\';/"
    sed -i $email_line $sendmail_file

    #attachment line
    echo attachment 1>&2
    attch_line="17s/.*/\$m_attch=\'\/home\/$myUserName\/Pictures\/${gif_name}\';/"
    sed -i $attch_line $sendmail_file

    #video url
    video_line="18s/.*/\$v_url=\'http\:\/\/socialevent.mx\/gif\/uploads\/360\/${gif_name}\';/"
    sed -i $video_line $sendmail_file

    #imgage url
    img_line="19s/.*/\$img_url=\'http\:\/\/socialevent.mx\/gif\/uploads\/360\/${img_name}\';/"
    sed -i $img_line $sendmail_file

    #send email
    echo "Sending mail ..." 1>&2
    #cat $sendmail_file
    php $sendmail_file
fi
