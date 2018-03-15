#!/bin/bash
PORT=$1
{
    ID=$(gphoto2 ${PORT} --get-config=ownername | grep Current) &&
    ID=${ID:12} &&
    MSG="camera ${ID} is at PORT: ${PORT}"
} ||
{
    MSG="camera founded at PORT: ${PORT} but usb communications seems futile."
}
echo "${MSG}"
#for number in {0..10..2};do
#    label=`printf %04d%s ${number%*}`.JPG
#    echo "${label}"
#done