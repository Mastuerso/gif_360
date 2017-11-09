#!/bin/bash

wdir=$(pwd)
sendmail_file="/var/www/html/gif_360_web/server/send_mail.php"

#get recipient mail
recipient=$(sed '9q;d' "$wdir/gif_settings.txt")
recipient=${recipient:7}
echo "recipient: $recipient"

#get gif name
gif_name=$(sed '1q;d' "$wdir/gif_name.txt")
echo "gif name: $gif_name"

#modifying php ... 
echo "Editing and sending..."

#email line
echo recipient
email_line="16s/.*/\$recipient=\'${recipient}\';/"
sed -i $email_line $sendmail_file

#attachment line
echo attachment
attch_line="17s/.*/\$m_attch=\'\/home\/onikom\/Pictures\/${gif_name}.gif\';/"
sed -i $attch_line $sendmail_file

#send email
echo "Sending mail ..."
#cat $sendmail_file
php $sendmail_file
